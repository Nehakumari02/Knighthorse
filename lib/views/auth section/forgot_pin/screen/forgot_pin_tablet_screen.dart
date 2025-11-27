part of 'forgot_pin_screen.dart';

class ForgotPinTabletScreen extends GetView<ForgotPinController> {
  const ForgotPinTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar('ForgotPin Tablet Screen'),
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
