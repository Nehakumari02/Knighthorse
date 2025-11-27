part of '../screen/forgot_password_otp_verification_screen.dart';

class OtpSubmitButton extends GetView<OtpVerificationController> {
  const OtpSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PrimaryButton(
        title: Strings.submit,
        disable: !controller.isFormValid.value,
        isLoading: controller.isLoading,
        onPressed: () {
          if (controller.isFormValid.value) {
            controller.onOtpSubmit;
          }
        },
      ),
    );
  }
}
