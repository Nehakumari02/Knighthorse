import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../base/api/services/auth_services.dart';

class ResetPasswordController extends GetxController {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  RxBool isFormValid = false.obs;

  @override
  void onInit() {
    newPasswordController.addListener(_updateFormValidity);
    confirmPasswordController.addListener(_updateFormValidity);
    super.onInit();
  }

  get onResetPasswordSubmit => resetPasswordProcess();

  void _updateFormValidity() {
    isFormValid.value = newPasswordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty;
  }

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  resetPasswordProcess() async {
    return AuthServices.resetPasswordProcess(
      password: newPasswordController.text,
      confirmPassword: confirmPasswordController.text,
      isLoading: _isLoading,
    );
  }
}
