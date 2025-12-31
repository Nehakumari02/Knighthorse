part of '../screen/profile_screen.dart';

class BalanceSheetCard extends GetView<ProfileController> {
  final Color? color;
  const BalanceSheetCard({
    Key? key,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(

    visible :false,
    child: Obx(
      () => controller.isLoading
          ? Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius * 2.4),
                ),
                color: CustomColor.whiteColor,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.horizontalSize * 0.9,
                    vertical: Dimensions.verticalSize * 0.7,
                  ),
                  child: Row(
                    mainAxisAlignment: mainSpaceBet,
                    children: [
                      CircleAvatar(
                        radius: Dimensions.radius * 3,
                        backgroundColor: Colors.grey.shade300,
                      ),
                      Column(
                        crossAxisAlignment: crossEnd,
                        children: [
                          Container(
                            width: 100,
                            height: 12,
                            color: Colors.white,
                          ),
                          Sizes.height.v5,
                          Row(
                            children: [
                              Container(
                                width: 50.w,
                                height: 14.h,
                                color: Colors.white,
                              ),
                              Sizes.width.v5,
                              Container(
                                width: 30.w,
                                height: 14.h,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius * 2.4),
              ),
              // color: color ?? CustomColor.primary,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.horizontalSize * 0.9,
                  vertical: Dimensions.verticalSize * 0.7,
                ),
                child: Row(
                  mainAxisAlignment: mainCenter,
                  children: [
                    // CircleAvatar(
                    //   radius: Dimensions.radius * 3,
                    //   backgroundColor: CustomColor.disableColor,
                    //   backgroundImage:
                    //       NetworkImage(controller.baseCurrencyFlag.value),
                    // ),
                    Column(
                      crossAxisAlignment: crossCenter,
                      children: [
                        TextWidget(
                          Strings.availableBalance,
                          typographyStyle: TypographyStyle.titleSmall,
                          fontWeight: FontWeight.w400,
                        ),
                        Sizes.height.v5,
                        Row(
                          children: [
                            TextWidget(
                              double.tryParse(controller.walletBalance.value)!
                                  .toStringAsFixed(2),
                              typographyStyle: TypographyStyle.headlineSmall,
                              fontWeight: FontWeight.w600,
                            ),
                            Sizes.width.v5,
                            TextWidget(
                              controller.walletCurrency.value,
                              typographyStyle: TypographyStyle.headlineSmall,
                              fontWeight: FontWeight.w600,
                              color: CustomColor.primary,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    ),
    );
  }

}
