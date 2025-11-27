part of 'reg_email_verification_screen.dart';

class RegEmailVerificationTabletScreen extends GetView<RegistrationController> {
  const RegEmailVerificationTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar('RegistrationEmailVerification Tablet Screen'),
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
