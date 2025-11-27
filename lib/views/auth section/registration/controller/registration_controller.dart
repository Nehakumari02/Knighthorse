import 'dart:async'; // <--- REQUIRED for Timer
import 'package:knighthorse/base/utils/basic_import.dart';
import 'package:knighthorse/base/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sendotp_flutter_sdk/sendotp_flutter_sdk.dart';



import '../../../../base/api/services/auth_services.dart';
import '../../../../base/api/services/basic_services.dart';
import '../../../../routes/routes.dart';
import 'package:url_launcher/url_launcher.dart'; // <-- for WhatsApp redirection


class RegistrationController extends GetxController {

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailAddressController = TextEditingController();

  final passwordController = TextEditingController();

  final gstNoController = TextEditingController();
  // Inside RegistrationController
  final countryController = TextEditingController();
  final mobileNumberController = TextEditingController();
  // Inside RegistrationController
  final otpController = TextEditingController();
  // MSG91 Configuration
  final String widgetId = '356b7a694930393632393837';
  final String token = '475234T9sqbLGt6926d193P1';


  // State Variables
  var isOtpLoading = false.obs;
  var isOtpSent = false.obs;
  RxBool isOtpVerified = false.obs; // <--- ADD THIS
  var timerCount = 0.obs; // Observable for UI
  Timer? _timer;          // The actual Timer object (Causes error if missing)
  String? currentReqId;   // To store MSG91 Request ID

  // void sendOtp() {
  //   // Add your API logic here
  //   print("OTP Sent to ${mobileNumberController.text}");
  // }
  RxString userType = 'retailer'.obs; // <-- ADD THIS LINE
  RxString verificationStatus = 'pending'.obs; // 'pending', 'approved', 'denied'


  final pinController = TextEditingController();

  final referralIdController = TextEditingController();
  RxBool agree = false.obs;
  var selectedMethodIndex = 0.obs;
  RxString countrySelectMethod = ''.obs;

  // Routing
  get onRegistration => registrationProcess();
  get onLogIn => Routes.loginScreen.toNamed;
  get onPrivacyPolicy => '';
  RxBool isFormValid = false.obs;

  @override
  void onInit() {
    emailAddressController.addListener(_updateFormValidity);
    passwordController.addListener(_updateFormValidity);
    firstNameController.addListener(_updateFormValidity);
    lastNameController.addListener(_updateFormValidity);
    gstNoController.addListener(_updateFormValidity);
    countryController.addListener(_updateFormValidity);
    mobileNumberController.addListener(_updateFormValidity);

    BasicServices.getBasicSettingsInfo();
    // ADD THIS LISTENER:
    mobileNumberController.addListener(() {
      if (isOtpVerified.value) {
        isOtpVerified.value = false; // Reset verification if user changes number
        debugPrint("Number changed, verification reset.");
      }
      _updateFormValidity();
    });
    super.onInit();
    OTPWidget.initializeWidget(widgetId, token);


  }
  void startTimer() {
    timerCount.value = 60; // 60 seconds cooldown
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timerCount.value > 0) {
        timerCount.value--;
      } else {
        _timer?.cancel();
        isOtpSent.value = false; // Allow resending
      }
    });
  }
  // --- SEND OTP ---
  Future<void> sendOtp() async {
    String phone = mobileNumberController.text.trim();
    String countryCode = countryController.text.trim().replaceAll("+", "");

    if (phone.isEmpty) {
      Get.snackbar("Error", "Enter mobile number");
      return;
    }

    try {
      isOtpLoading.value = true;

      // 2. Call SDK to Send
      // Note: Combine Country Code + Phone (e.g., "919876543210")
      final data = {
        'identifier': '$countryCode$phone'
      };

      final response = await OTPWidget.sendOTP(data);

      print("MSG91 Response: $response");

      // Check for success (The SDK returns a Map, check documentation for specific success keys)
      // Usually, if it returns a Map with 'message' or 'reqId', it worked.
      if (response != null && response['message'] != null) {

        // 3. STORE THE REQ ID (Crucial!)
        currentReqId = response['message'];

        isOtpSent.value = true;
        startTimer(); // Start your countdown UI
        Get.snackbar("Success", "OTP Sent!");
      } else {
        Get.snackbar("Error", "Failed to send OTP. Try again.");
      }

    } catch (e) {
      print("Error: $e");
      Get.snackbar("Error", "Something went wrong.");
    } finally {
      isOtpLoading.value = false;
    }
  }

  // --- VERIFY OTP ---
  Future<bool> verifyOtp() async {
    if (currentReqId == null) {
      Get.snackbar("Error", "Please send OTP first");
      return false;
    }

    try {
      final data = {
        'reqId': currentReqId,
        'otp': otpController.text.trim()
      };

      final dynamic response = await OTPWidget.verifyOTP(data);
      print("Verify Response: $response");

      if (response == null) {
        Get.snackbar("Error", "No response from server");
        return false;
      }

      if (response['type'] == 'success' ||
          response['message'] == 'OTP verified successfully' ||
          response['type'] == true) {

        // --- THIS IS THE CHANGE ---
        isOtpVerified.value = true; // Mark as verified
        Get.snackbar("Success", "Mobile number verified successfully!");
        // --------------------------

        return true;
      } else {
        Get.snackbar("Error", response['message'] ?? "Invalid OTP");
        return false;
      }
    } catch (e) {
      print("Verification Error: $e");
      Get.snackbar("Error", "Verification failed");
      return false;
    }
  }  void _updateFormValidity() {
    isFormValid.value = emailAddressController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&

    countryController.text.isNotEmpty &&
    mobileNumberController.text.isNotEmpty;

  }
  Future<void> saveUserTypeGlobally(String userType) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_type', userType);
    debugPrint("✅ user_type saved globally: $userType");
  }
  Future<void> saveVerificationStatusGlobally(String verificationStatus) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('verificationStatus', verificationStatus); // <-- use argument
    debugPrint("✅ verificationStatus saved globally: $verificationStatus");
  }



  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  registrationProcess() async {
    // --- NEW VALIDATION CHECK ---
    if (!isOtpVerified.value) {
      Get.snackbar(
          "Verification Required",
          "Please verify your mobile number with OTP before registering.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM
      );
      return; // STOP EXECUTION HERE
    }
    return AuthServices.registrationProcess(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailAddressController.text,
      password: passwordController.text,
      userType: userType.value,
      verificationStatus: verificationStatus.value.toLowerCase(),
      gstNo: gstNoController.text,
      mobile_code: countryController.text,
      mobile: mobileNumberController.text,

      dialCode: LocalStorage.email,
      isLoading: _isLoading,
    ).then((value) async {

      // --- THIS IS THE FIX ---
      // If the service returns null or false, it means registration
      // failed (and the service likely already showed an error snackbar).
      if (value == null || value == false) {
        debugPrint("Registration failed, service handled the error.");
        return; // Stop execution here, don't show the dialog.
      }
      // --- END OF FIX ---

      // If we get here, registration was truly successful.
      await saveUserTypeGlobally(userType.value);
      await saveVerificationStatusGlobally(verificationStatus.value);

      // Check verification status and handle accordingly
      if (verificationStatus.value == 'pending') {
        Get.dialog(
          // ... your dialog code ...
          AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: Colors.white,
            title: const Text(
              "Verification Pending",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            content: const Text(
              "Your account verification request is pending. Please wait for admin approval.",
              style: TextStyle(fontSize: 15),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back(); // Close the dialog
                  Get.offAllNamed(Routes.loginScreen); // Redirect to login screen
                },
                child: const Text(
                  "OK",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          barrierDismissible: false,
        );
        return;
      } else if (verificationStatus.value == 'denied') {
        // ... your 'denied' logic ...
      } else if (verificationStatus.value == 'approved') {
        // ... your 'approved' logic ...
      }
    }).catchError((error) {
      // This will now only catch *unexpected* errors (network, server 500, etc.)
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
