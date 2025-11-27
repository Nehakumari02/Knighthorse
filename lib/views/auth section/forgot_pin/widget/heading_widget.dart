part of '../screen/forgot_pin_screen.dart';

class HeadingWidget extends GetView<ForgotPinController> {
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
            Strings.forgottenPass,
            fontWeight: FontWeight.bold,
            typographyStyle: TypographyStyle.titleLarge,
          ),
          TextWidget(
            Strings.forgottenPassSubTitle,
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
