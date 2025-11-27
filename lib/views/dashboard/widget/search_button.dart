part of '../screen/dashboard_screen.dart';

class SearchButton extends GetView<DashboardController> {
  const SearchButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: Dimensions.horizontalSize * .7,
        right: Dimensions.horizontalSize * .7,
        bottom: Dimensions.heightSize * .8,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.horizontalSize,
        vertical: Dimensions.verticalSize * .6,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius * 2.8),
          color: CustomColor.whiteColor),
      child: InkWell(
        onTap: () {
          Routes.searchFieldScreen.toNamed;
        },
        child: Row(
          // mainAxisAlignment: mainSpaceBet,
          children: [
            Icon(
              Icons.search,
              size: Dimensions.iconSizeLarge,
              color: CustomColor.disableColor,
            ),
            Sizes.width.v10,
            TextWidget(
              Strings.searchHere,
              typographyStyle: TypographyStyle.labelMedium,
              fontWeight: FontWeight.w400,
              color: CustomColor.tertiaryDark.withValues(alpha: 0.4),
            ),
          ],
        ),
      ),
    );
  }
}
