part of '../screen/phone_login_otp_screen.dart';

class LoginOtpWidget extends GetView<PhoneLoginOtpController> {
  const LoginOtpWidget({Key? key}) : super(key: key);
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
