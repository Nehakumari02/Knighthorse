part of 'login_screen.dart';

class LoginMobileScreen extends GetView<LoginController> {
  const LoginMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        '',
        showBackButton: false,
      ),
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
          InputField(),
          ButtonWidget(),
          OtherLoginOption(),
          DoNotHaveAccount(),
        ],
      ),
    );
  }
}
