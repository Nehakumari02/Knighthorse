part of '../screen/login_screen.dart';

class HeadingWidget extends GetView<LoginController> {
  const HeadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: Dimensions.heightSize * 0.6, top: Dimensions.heightSize),
      child: Column(
        crossAxisAlignment: crossStart,
        spacing: Dimensions.heightSize * .6,
        children: [
          TextWidget(
            Strings.logIn,
            fontWeight: FontWeight.bold,
            typographyStyle: TypographyStyle.titleLarge,
          ),
          TextWidget(
            Strings.loginSubtitle,
            fontWeight: FontWeight.w400,
            typographyStyle: TypographyStyle.labelLarge,
            colorShade: ColorShade.mediumForty,
            // padding: EdgeInsets.only(right: Dimensions.horizontalSize * 1.95),
          ),
        ],
      ),
    );
  }
}
