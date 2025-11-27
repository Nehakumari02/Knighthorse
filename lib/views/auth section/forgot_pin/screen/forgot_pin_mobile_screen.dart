part of 'forgot_pin_screen.dart';

class ForgotPinMobileScreen extends GetView<ForgotPinController> {
  const ForgotPinMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(""),
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
          HeadingWidget(),
          ForgotInputField(),
          ButtonWidget()
        ],
      ),
    );
  }
}
