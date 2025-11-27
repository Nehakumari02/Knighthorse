part of 'phone_login_otp_screen.dart';

class PhoneLoginOtpTabletScreen extends GetView<LoginController> {
  const PhoneLoginOtpTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar('PhoneLoginOtp Tablet Screen'),
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
