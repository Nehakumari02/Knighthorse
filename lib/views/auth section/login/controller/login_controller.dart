import 'package:knighthorse/assets/assets.dart';
import 'package:knighthorse/base/utils/basic_import.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_form_field/phone_form_field.dart';
import '../../../../base/api/services/auth_services.dart';
import '../../../../routes/routes.dart';
import '../model/country_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart'; // <-- 1. ADD THIS IMPORT


class LoginController extends GetxController {
  final Rxn<PhoneNumber> selectCountry = Rxn<PhoneNumber>();
  final emailAddressController = TextEditingController();
  final phoneNumberController = TextEditingController();

  final passwordController = TextEditingController();
  final otpController = TextEditingController();
  RxBool isFormValid = false.obs;
  RxBool isPhoneFormValid = false.obs;
  RxBool isRemember = false.obs;
  RxString dialCode = "".obs;
  get onForgotPassword => Routes.forgotPasswordOtpVerificationScreen.toNamed;
  get onRegistration => Routes.registrationScreen.toNamed;
  get onLogInProcess =>
      selectedMethodIndex.value == 0 ? logInProcess() : logInPhoneProcess();

  @override
  void onInit() {
    selectCountry.value = PhoneNumber(isoCode: IsoCode.AC, nsn: '');
    // emailAddressController.text = "user@appdevs.net";
    // passwordController.text = "appdevs";
    emailAddressController.addListener(_updateFormValidity);
    passwordController.addListener(_updateFormValidity);
    phoneNumberController.addListener(_updateFormValidity);
    ever(selectedMethodIndex, (_) => _updateFormValidity());
    super.onInit();
  }
  Future<void> saveVerificationStatusGlobally(String? status) async {
    final prefs = await SharedPreferences.getInstance();
    // Use 'pending' as a safe default if status is null or empty
    String statusToSave = (status ?? 'pending').toLowerCase();
    if (statusToSave.isEmpty) {
      statusToSave = 'pending';
    }
    await prefs.setString('verificationStatus', statusToSave);
    debugPrint("✅ verificationStatus saved globally: $statusToSave");

  }

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  logInProcess() async {
    _isLoading.value = true;

    try {
      final value = await AuthServices.logInService(
        credentials: emailAddressController.text,
        password: passwordController.text,
        isLoading: _isLoading,
      );

      _isLoading.value = false;
      emailAddressController.clear();
      passwordController.clear();

      if (value == null) {
        // Get.snackbar(
        //   "Login Failed",
        //   "No response from server.",
        //   snackPosition: SnackPosition.BOTTOM,
        //   backgroundColor: Colors.redAccent,
        //   colorText: Colors.white,
        // );
        return;
      }

      // ✅ Extract verificationStatus safely
      final verificationStatus = value.data.userInfo.verificationStatus;
      print('Verification Status: $verificationStatus');
      // final verificationStatus = 'approved';
      debugPrint("📋 verificationStatus from backend: $verificationStatus");
      await saveVerificationStatusGlobally(verificationStatus);

      if (verificationStatus == 'pending') {
        // ⚠️ Show pending dialog
        Get.dialog(
          AlertDialog(
            title: const Text("Verification Pending"),
            content: const Text(
              "Your account verification is still pending. Please wait for admin approval.",
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back(); // close dialog
                  Get.offAllNamed(Routes.loginScreen); // redirect to login
                },
                child: const Text("OK"),
              ),
            ],
          ),
          barrierDismissible: false,
        );
        return;
      }

      if (verificationStatus == 'denied') {
        // ❌ Redirect to WhatsApp support
        final whatsappUrl = Uri.parse("https://wa.me/919876543210?text=Hello, my verification was denied. Please assist.");
        if (await canLaunchUrl(whatsappUrl)) {
          await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
        } else {
          Get.snackbar(
            "Error",
            "Could not open WhatsApp.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent,
            colorText: Colors.white,
          );
        }
        return;
      }

      if (verificationStatus == 'approved') {
        // ✅ Proceed with normal login navigation
        Get.offAllNamed(Routes.navigation);
        CustomSnackBar.success(
          title: "Success",
          message: "Login Successful",
        );
      } else {
        // fallback
        Get.snackbar(
          "Login Failed",
          "Unknown verification status: $verificationStatus",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      _isLoading.value = false;
      debugPrint("❌ Login error: $e");
      Get.snackbar(
        "Login Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }


  // login with phone number
  logInPhoneProcess() async {
    return AuthServices.logInPhoneService(
      dialCode: "+${dialCode.value}",
      number: phoneNumberController.text,
      isLoading: _isLoading,
    ).then((value) {
      phoneNumberController.clear();
    });
  }

  logOutProcess() async {
    await _googleSignIn.signOut();
    googleAccount.value = null;
    return AuthServices.logOutService(
      isLoading: _isLoading,
    );
  }

  deleteAccountProcess() async {
    return AuthServices.deleteAccountServices(
      isLoading: _isLoading,
    );
  }

  void _updateFormValidity() {
    if (selectedMethodIndex.value == 0) {
      isFormValid.value = emailAddressController.text.isNotEmpty &&
              passwordController.text.isNotEmpty ||
          phoneNumberController.text.isNotEmpty;
    } else {
      isFormValid.value = phoneNumberController.text.isNotEmpty;
    }
    ;
  }

  // google login

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
    // clientId:
    //     "241025086768-0avlp5im4fjqvk3u5t3uck9dpt7llrju.apps.googleusercontent.com",
//   scopes:  <String>[
//   'email',
//   'https://www.googleapis.com/auth/contacts.readonly',
// ]
  );
  var googleAccount = Rx<GoogleSignInAccount?>(null);

  var authCode = ''.obs;
  var accessToken = ''.obs;
  var idToken = ''.obs;

  final _isGoogleLoading = false.obs;
  bool get isGoogleLoading => _isGoogleLoading.value;

  /// Sign In with Google
  Future<void> onGoogleLogin() async {
    try {
      await _googleSignIn.signOut();

      final account = await _googleSignIn.signIn();
      if (account != null) {
        googleAccount.value = account;

        final GoogleSignInAuthentication authentication =
            await account.authentication;

        accessToken.value = authentication.accessToken ?? '';

        AuthServices.loginWithGoogle(
          accessToken.value,
          _isGoogleLoading,
        );

        CustomSnackBar.success(
            title: Strings.success, message: Strings.loginSuccess);
      }
    } catch (error) {
      debugPrint("Error: $error");
      Get.snackbar("Error", error.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  final List<Country> countries = [];
  final selectedCountry = ''.obs;
  final leadingAsset = "".obs;

  var selectedMethodIndex = 0.obs;
  List loginMethod = [Strings.email, Strings.phoneNumber];

  List otherLoginMethod = [Assets.icons.google.path];
}
