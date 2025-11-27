part of '../screen/reg_email_verification_screen.dart';

class OtpInputFieldWidget extends GetView<RegEmailVerificationController> {
  const OtpInputFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Dimensions.verticalSize * .5),
      child: OtpInputField(
        controller: controller.otpController,
      ),
    );
  }
}
