import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../base/utils/basic_import.dart';
import '../../login/controller/login_controller.dart';

class LogInButtonWidget extends GetView<LoginController> {
  const LogInButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PrimaryButton(
        isLoading: controller.isLoading,
        title: Strings.logIn,
        disable: !controller.isFormValid.value,
        onPressed: () {
          if (controller.isFormValid.value) {
            controller.onLogInProcess;
          }
        },
      ),
    );
  }
}
