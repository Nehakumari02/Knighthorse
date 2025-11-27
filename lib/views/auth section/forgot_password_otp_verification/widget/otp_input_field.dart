part of '../screen/forgot_password_otp_verification_screen.dart';

class OtpInputFieldWidget extends GetView<OtpVerificationController> {
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
