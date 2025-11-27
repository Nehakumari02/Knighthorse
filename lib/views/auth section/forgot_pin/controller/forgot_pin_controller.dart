import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../base/api/services/auth_services.dart';

class ForgotPinController extends GetxController {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  final emailAddressController = TextEditingController();
  RxBool isFormValid = false.obs;
  void onInit() {
    emailAddressController.addListener(_updateFormValidity);
    super.onInit();
  }

  void _updateFormValidity() {
    isFormValid.value = emailAddressController.text.isNotEmpty;
  }

  @override
  void onClose() {
    emailAddressController.dispose();
    super.onClose();
  }

  // Route
  get onForgotPassword => forgotPasswordProcess();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  forgotPasswordProcess() {
    return AuthServices.forgotPasswordProcess(
      credentials: emailAddressController.text,
      isLoading: _isLoading,
    );
  }
}
