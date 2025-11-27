part of '../screen/login_screen.dart';

class DoNotHaveAccount extends GetView<LoginController> {
  const DoNotHaveAccount({
    Key? key,
    this.colorShade,
    this.optionalFunction,
  }) : super(key: key);
  final ColorShade? colorShade;
  final VoidCallback? optionalFunction;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: BasicServices.userRegistration.value == 1,
        child: Column(
          children: [
            Sizes.height.v20,
            Row(
              mainAxisAlignment: mainCenter,
              children: [
                TextWidget(
                  Strings.newTo,
                  colorShade: colorShade ?? ColorShade.mediumForty,
                  padding: Dimensions.horizontalSize.edgeHorizontal * 0.08,
                  typographyStyle: TypographyStyle.titleSmall,
                ),
                TextWidget(
                  Strings.registerNow,
                  colorShade: ColorShade.mediumForty,
                  fontWeight: FontWeight.w600,
                  color: CustomColor.primary,
                  typographyStyle: TypographyStyle.titleSmall,
                  onTap: () {
                    Routes.registrationScreen.toNamed;
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
