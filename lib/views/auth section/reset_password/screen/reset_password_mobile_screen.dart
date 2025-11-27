part of 'reset_password_screen.dart';

class ResetPasswordMobileScreen extends GetView<ResetPasswordController> {
  const ResetPasswordMobileScreen({super.key});

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
          ResetPasswordHeading(),
          ResetPasswordInput(),
          ResetPasswordSubmitButton()
        ],
      ),
    );
  }
}
