part of '../screen/registration_screen.dart';

class RegHeading extends GetView<RegistrationController> {
  const RegHeading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: Dimensions.verticalSize, top: Dimensions.heightSize),
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
          TextWidget(
            Strings.registerInfo,
            style: CustomStyle.titleLarge.copyWith(
              fontSize: Dimensions.titleLarge * 0.9,
            ),
          ),
          Sizes.height.v5,
          TextWidget(
            Strings.registerInfoSubtitle,
            fontWeight: FontWeight.w400,
            typographyStyle: TypographyStyle.labelMedium,
            lineHeight: 1.5,
            padding: EdgeInsets.only(right: Dimensions.horizontalSize),
          ),
          
        ],
      ),
    );
  }
}
