part of 'registration_screen.dart';

class RegistrationMobileScreen extends GetView<RegistrationController> {
  const RegistrationMobileScreen({super.key});

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
          RegHeading(),
          RegInputField(),
          RegSubmitButton(),
          AlreadyAccount()
        ],
      ),
    );
  }
}
