import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../base/api/services/auth_services.dart';

class OtpVerificationController extends GetxController {
  final otpController = TextEditingController();
  RxString currentText = "".obs;
  RxBool isFormValid = false.obs;
  void _updateFormValidity() {
    isFormValid.value = otpController.text.length == 6;
  }

  @override
  void onInit() {
    timerInit();
    otpController.addListener(_updateFormValidity);
    super.onInit();
  }

  // Routing
  get onOtpSubmit => otpVerifyProcess();
  get onResendOtp => onResendOtpProcess();

  changeCurrentText(value) {
    currentText.value = value;
  }

  @override
  void dispose() {
    timer?.cancel();
    otpController.dispose();
    super.dispose();
  }

  timerInit() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining.value != 0) {
        secondsRemaining.value--;
      } else {
        enableResend.value = true;
      }
    });
  }

  RxInt secondsRemaining = 59.obs;
  RxInt minuteRemaining = 00.obs;
  RxBool enableResend = false.obs;
  Timer? timer;

  resendCode() {
    secondsRemaining.value = 59;
    enableResend.value = false;
  }

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final _isResendLoading = false.obs;
  bool get isResendLoading => _isResendLoading.value;

  otpVerifyProcess() async {
    return AuthServices.otpVerifyProcess(
      code: otpController.text,
      isLoading: _isLoading,
    );
  }

  onResendOtpProcess() {
    return AuthServices.resendForgotOtpCode(
      isResendLoading: _isResendLoading,
    );
  }
}
