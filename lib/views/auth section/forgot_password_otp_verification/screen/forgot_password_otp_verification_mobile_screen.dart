part of 'forgot_password_otp_verification_screen.dart';

class ForgotPasswordOtpVerificationMobileScreen
    extends GetView<OtpVerificationController> {
  const ForgotPasswordOtpVerificationMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(''),
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.horizontalSize,
          vertical: Dimensions.verticalSize * .2,
        ),
        children: [
          BrandLogo(),
          OtpHeadingWidget(),
          OtpInputFieldWidget(),
          TimerWidget(onResendCode: () {
            controller.onResendOtp;
          }),
          OtpSubmitButton(),
        ],
      ),
    );
  }
}
