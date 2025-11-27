part of '../screen/registration_screen.dart';

class AlreadyAccount extends GetView<RegistrationController> {
  const AlreadyAccount({Key? key}) : super(key: key);
@override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Sizes.height.v30,
        Row(
          mainAxisAlignment: mainCenter,
          children: [
            TextWidget(
              Strings.alreadyHaveAn,
              colorShade: ColorShade.mediumForty,
              typographyStyle: TypographyStyle.labelMedium,
              padding: Dimensions.horizontalSize.edgeHorizontal * 0.07,
            ),
            TextWidget(
              Strings.loginNow,
              colorShade: ColorShade.mediumForty,
              typographyStyle: TypographyStyle.labelMedium,
              color: CustomColor.primary,
              onTap: () {
                Routes.loginScreen.toNamed;
              },
            ),
          ],
        ),
        Sizes.height.v30,
      ],
    );
  }
}
