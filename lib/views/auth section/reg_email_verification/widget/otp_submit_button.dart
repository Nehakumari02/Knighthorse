part of '../screen/reg_email_verification_screen.dart';

class OtpSubmitButton extends GetView<RegEmailVerificationController> {
  const OtpSubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PrimaryButton(
        title: Strings.submit,
        disable: !controller.isFormValid.value,
        isLoading: controller.isLoading,
        onPressed: () {
          if (controller.isFormValid.value) {
            controller.onEmailVerify;
          }
        },
      ),
    );
  }
}
