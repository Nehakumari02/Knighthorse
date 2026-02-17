import 'dart:async';
import 'dart:math'; // <--- REQUIRED for Random OTP generation
import 'package:knighthorse/base/utils/basic_import.dart';
import 'package:knighthorse/base/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twilio_flutter/twilio_flutter.dart'; // <--- REQUIRED for Twilio

import '../../../../base/api/services/auth_services.dart';
import '../../../../base/api/services/basic_services.dart';
import '../../../../routes/routes.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class RegistrationController extends GetxController {

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailAddressController = TextEditingController();
  final passwordController = TextEditingController();
  final gstNoController = TextEditingController();
  final countryController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final otpController = TextEditingController();

  // --- TWILIO CONFIGURATION ---
  // ⚠️ SECURITY WARNING: Storing keys on the client side is not recommended for production apps.
  // Ideally, call a backend server to handle Twilio requests.
  late TwilioFlutter twilioFlutter;
  final String accountSid = 'ACeba3ee7a19c3e8588dd1da488b801c97';
  final String authToken = '31a8c4925c0a0b0701477e242fa4f441';
  final String twilioNumber = '+18127831862'; // Your purchased Twilio phone number

  // State Variables
  var isOtpLoading = false.obs;
  var isOtpSent = false.obs;
  RxBool isOtpVerified = false.obs;
  var timerCount = 0.obs;
  Timer? _timer;
  // Comprehensive list of common country codes
  final countryList = [
    "+93", "+355", "+213", "+376", "+244", "+1", "+54", "+374", "+61", "+43",
    "+994", "+973", "+880", "+375", "+32", "+501", "+229", "+975", "+591", "+387",
    "+267", "+55", "+673", "+359", "+226", "+257", "+855", "+237", "+1", "+238",
    "+236", "+235", "+56", "+86", "+57", "+269", "+242", "+243", "+682", "+506",
    "+385", "+53", "+357", "+420", "+45", "+253", "+1", "+1", "+593", "+20",
    "+503", "+240", "+291", "+372", "+251", "+500", "+298", "+679", "+358", "+33",
    "+594", "+689", "+241", "+220", "+995", "+49", "+233", "+350", "+30", "+299",
    "+1", "+590", "+1", "+502", "+224", "+245", "+592", "+509", "+504", "+852",
    "+36", "+354", "+91", "+62", "+98", "+964", "+353", "+44", "+972", "+39",
    "+225", "+1", "+81", "+962", "+7", "+254", "+686", "+850", "+82", "+965",
    "+996", "+856", "+371", "+961", "+266", "+231", "+218", "+423", "+370", "+352",
    "+853", "+389", "+261", "+265", "+60", "+960", "+223", "+356", "+692", "+596",
    "+222", "+230", "+262", "+52", "+691", "+373", "+377", "+976", "+382", "+1",
    "+212", "+258", "+95", "+264", "+674", "+977", "+31", "+599", "+687", "+64",
    "+505", "+227", "+234", "+683", "+672", "+47", "+968", "+92", "+680", "+970",
    "+507", "+675", "+595", "+51", "+63", "+48", "+351", "+1", "+974", "+262",
    "+40", "+7", "+250", "+290", "+1", "+1", "+1", "+508", "+1", "+685", "+378",
    "+239", "+966", "+221", "+381", "+248", "+232", "+65", "+421", "+386", "+677",
    "+252", "+27", "+34", "+94", "+249", "+597", "+268", "+46", "+41", "+963",
    "+886", "+992", "+255", "+66", "+670", "+228", "+690", "+676", "+1", "+216",
    "+90", "+993", "+1", "+688", "+256", "+380", "+971", "+44", "+1", "+598",
    "+998", "+678", "+379", "+58", "+84", "+1", "+681", "+967", "+260", "+263"
  ].obs;

  final selectedCountryCode = "+91".obs;

  // Store the generated OTP locally to verify later
  String? _generatedOtp;

  RxString userType = 'retailer'.obs;
  RxString verificationStatus = 'pending'.obs;

  final pinController = TextEditingController();
  final referralIdController = TextEditingController();
  RxBool agree = false.obs;
  var selectedMethodIndex = 0.obs;
  RxString countrySelectMethod = ''.obs;
  RxBool isFormValid = false.obs;

  // Routing
  get onRegistration => registrationProcess();
  get onLogIn => Routes.loginScreen.toNamed;
  get onPrivacyPolicy => '';

  @override
  void onInit() {
    // Initialize Twilio
    twilioFlutter = TwilioFlutter(
      accountSid: accountSid,
      authToken: authToken,
      twilioNumber: twilioNumber,
    );

    emailAddressController.addListener(updateFormValidity);
    passwordController.addListener(updateFormValidity);
    firstNameController.addListener(updateFormValidity);
    lastNameController.addListener(updateFormValidity);
    gstNoController.addListener(updateFormValidity);
    countryController.addListener(updateFormValidity);
    mobileNumberController.addListener(updateFormValidity);

    BasicServices.getBasicSettingsInfo();

    mobileNumberController.addListener(() {
      if (isOtpVerified.value) {
        isOtpVerified.value = false; // Reset verification if number changes
        isOtpSent.value = false;     // Hide OTP field
        debugPrint("Number changed, verification reset.");
      }
      updateFormValidity();
    });
    super.onInit();
  }

  void startTimer() {
    timerCount.value = 60; // 60 seconds cooldown
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timerCount.value > 0) {
        timerCount.value--;
      } else {
        _timer?.cancel();
        isOtpLoading.value = false; // Allow resending logic if needed
      }
    });
  }

  // --- HELPER: Generate 4 Digit OTP ---
  String _generateRandomOtp() {
    var rng = Random();
    return (1000 + rng.nextInt(9000)).toString();
  }

  // --- SEND OTP VIA TWILIO ---
  Future<void> sendOtp() async {
    String phone = mobileNumberController.text.trim();
    // Remove '+' from country code if present, then combine
    String countryCode = countryController.text.trim().replaceAll("+", "");

    // Twilio requires format like +15551234567
    String fullPhoneNumber = '+$countryCode$phone';

    if (phone.isEmpty) {
      Get.snackbar("Error", "Enter mobile number");
      return;
    }

    try {
      isOtpLoading.value = true;

      // 1. Generate OTP
      _generatedOtp = _generateRandomOtp();
      debugPrint("Generated OTP (Dev Mode): $_generatedOtp");

      // 2. Send SMS using Twilio
      await twilioFlutter.sendSMS(
        toNumber: fullPhoneNumber,
        messageBody: 'Your Knight Horse verification code is: $_generatedOtp',
      );

      // 3. Update UI
      isOtpSent.value = true;
      startTimer();
      Get.snackbar("Success", "OTP Sent to $fullPhoneNumber");

    } catch (e) {
      print("Twilio Error: $e");
      Get.snackbar("Error", "Failed to send OTP. Check internet or number format.");
    } finally {
      isOtpLoading.value = false;
    }
  }

  // --- VERIFY OTP (LOCAL CHECK) ---
  Future<bool> verifyOtp() async {
    String userEnteredOtp = otpController.text.trim();

    if (_generatedOtp == null) {
      Get.snackbar("Error", "Please send OTP first");
      return false;
    }

    if (userEnteredOtp.isEmpty) {
      Get.snackbar("Error", "Please enter the OTP");
      return false;
    }

    // Compare local generated variable with user input
    if (userEnteredOtp == _generatedOtp) {
      isOtpVerified.value = true;
      _timer?.cancel(); // Stop timer on success
      Get.snackbar("Success", "Mobile number verified successfully!");
      return true;
    } else {
      Get.snackbar("Error", "Invalid OTP. Please try again.");
      return false;
    }
  }

  void updateFormValidity() {
    isFormValid.value = emailAddressController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        selectedCountryCode.value.isNotEmpty &&
        mobileNumberController.text.isNotEmpty;
  }

  Future<void> saveUserTypeGlobally(String userType) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_type', userType);
    debugPrint("✅ user_type saved globally: $userType");
  }

  Future<void> saveVerificationStatusGlobally(String verificationStatus) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('verificationStatus', verificationStatus);
    debugPrint("✅ verificationStatus saved globally: $verificationStatus");
  }

  // 👇 EMAIL SENDING FUNCTION
  Future<void> sendAdminAlertEmail() async {
    String username = 'Application.knighthorse@gmail.com';
    String password = 'mjxp hzcp ivud rxsn'; // Your App Password

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Knight Horse App')
      ..recipients.add('Application.knighthorse@gmail.com')
      ..subject = 'New User Registration: ${firstNameController.text}'
      ..text = '''
        A new user has just registered!

        Name: ${firstNameController.text} ${lastNameController.text}
        Email: ${emailAddressController.text}
        Phone: ${mobileNumberController.text}
        User Type: ${userType.value}
        
        Please check the admin panel for details.
      ''';

    try {
      final sendReport = await send(message, smtpServer);
      debugPrint('✅ Admin alert email sent: ' + sendReport.toString());
    } catch (e) {
      debugPrint('🔴 Failed to send admin alert: $e');
    }
  }

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  registrationProcess() async {
    // if (!isOtpVerified.value) {
    //   Get.snackbar(
    //       "Verification Required",
    //       "Please verify your mobile number with OTP before registering.",
    //       backgroundColor: Colors.red,
    //       colorText: Colors.white,
    //       snackPosition: SnackPosition.BOTTOM
    //   );
    //   return;
    // }

    return AuthServices.registrationProcess(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailAddressController.text,
      password: passwordController.text,
      userType: userType.value,
      verificationStatus: verificationStatus.value.toLowerCase(),
      gstNo: gstNoController.text,
      mobile_code: selectedCountryCode.value, // This uses the dropdown value
      mobile: mobileNumberController.text,
      dialCode: LocalStorage.email,
      isLoading: _isLoading,
    ).then((value) async {

      if (value == null || value == false) {
        debugPrint("Registration failed, service handled the error.");
        return;
      }

      sendAdminAlertEmail();

      await saveUserTypeGlobally(userType.value);
      await saveVerificationStatusGlobally(verificationStatus.value);

      if (verificationStatus.value == 'pending') {
        Get.dialog(
          AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: Colors.white,
            title: const Text(
              "Verification Pending",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            content: const Text(
              "Your account verification request is pending. Please wait for admin approval.",
              style: TextStyle(fontSize: 15),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                  Get.offAllNamed(Routes.loginScreen);
                },
                child: const Text(
                  "OK",
                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ],
          ),
          barrierDismissible: false,
        );
        return;
      }
    }).catchError((error) {
      Get.snackbar(
        "Error",
        "Something went wrong: $error",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.9),
        colorText: Colors.white,
      );
    });
  }
}