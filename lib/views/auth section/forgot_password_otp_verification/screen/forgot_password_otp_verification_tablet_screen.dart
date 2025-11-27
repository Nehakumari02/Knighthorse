part of 'forgot_password_otp_verification_screen.dart';

class ForgotPasswordOtpVerificationTabletScreen extends  GetView<ForgotPinController> {
  const ForgotPasswordOtpVerificationTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar('ForgotPasswordOtpVerification Tablet Screen'),
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return const SafeArea(
      child: Column(
        children: [],
      ),
    );
  }
}
