part of '../screen/reset_password_screen.dart';

class ResetPasswordSubmitButton extends GetView<ResetPasswordController> {
  const ResetPasswordSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PrimaryButton(
        title: Strings.submit,
        disable: !controller.isFormValid.value,
        isLoading: controller.isLoading,
        onPressed: () {
          if (controller.isFormValid.value) {
            controller.onResetPasswordSubmit;
          }
        },
      ),
    );
  }
}
