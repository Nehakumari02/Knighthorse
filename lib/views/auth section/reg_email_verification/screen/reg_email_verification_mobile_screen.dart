part of 'reg_email_verification_screen.dart';

class RegEmailVerificationMobileScreen
    extends GetView<RegEmailVerificationController> {
  const RegEmailVerificationMobileScreen({super.key});

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
          OtpHeading(),
          OtpInputFieldWidget(),
          TimerWidget(onResendCode: () {
            controller.onResendOtp;
          }),
          OtpSubmitButton()
        ],
      ),
    );
  }
}
