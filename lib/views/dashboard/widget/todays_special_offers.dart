part of '../screen/dashboard_screen.dart';

class TodaysSpecialOffers extends GetView<DashboardController> {
  const TodaysSpecialOffers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: Dimensions.horizontalSize * .7,
        left: Dimensions.horizontalSize * .7,
        bottom: Dimensions.verticalSize * .5,

      ),
      child: Obx(()=> controller.offerProducts.isEmpty? SizedBox.shrink(): Column(
          crossAxisAlignment: crossStart,
          children: [
            TextWidget(
              Strings.todaysSpecialOffer,
              fontSize: Dimensions.titleMedium,
              fontWeight: FontWeight.w600,
            ),
            // Sizes.height.v10,
            // _spendInfo(),
            Sizes.height.v10,
            _offerProductCaousel(context),
            Sizes.height.v5,
            _indicaorWidget()
          ],
        ),
      ),
    );
  }

  _offerProductCaousel(BuildContext context) {
    return ClipRect(
      child: CarouselSlider.builder(
        itemCount: controller.offerProducts.length,
        itemBuilder: (context, index, realIndex) {
          return ProductCard(
            product: controller.offerProducts[index],
            onTap: () {
              Get.toNamed(Routes.detailsScreen,
                  arguments: {"productId": controller.offerProducts[index].id});
            },
          );
        },
        options: CarouselOptions(
          height: Dimensions.buttonHeight * 5.0,
          autoPlay: true,
          enlargeCenterPage: false,
          viewportFraction: 0.5,
          aspectRatio: 9 / 10,
          autoPlayInterval: Duration(seconds: 3),
          onPageChanged: (index, reason) {
            controller.currentOfferIndex.value = index;
          },
        ),
      ),
    );
  }

  _indicaorWidget() {
    return Obx(() => controller.offerProducts.isNotEmpty
        ? Center(
            child: SizedBox(
              child: SingleChildScrollView(
                child: Row(
                    mainAxisAlignment: mainCenter,
                    mainAxisSize: mainMin,
                    children: [
                      DotsIndicator(
                        dotsCount: controller.offerProducts.length,
                        position: controller.currentOfferIndex.value.toDouble(),
                        decorator: DotsDecorator(
                          activeColor: CustomColor.primary,
                          color: CustomColor.disableColor,
                          size: Size(Dimensions.heightSize * .8,
                              Dimensions.widthSize * .8),
                          activeSize: Size(Dimensions.heightSize * 1.6,
                              Dimensions.widthSize * .8),
                          activeShape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius * .5),
                          ),
                        ),
                      )
                    ]),
              ),
            ),
          )
        : SizedBox.shrink());
  }

  _spendInfo() {
    return Obx(
      () => DeliveryServices.freedeliveryStatus.value == 1
          ? Stack(
              children: [
                Card(
                  color: CustomColor.primary.withValues(alpha: 0.9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius),
                  ),
                  child: Padding(
                      padding: EdgeInsets.all(Dimensions.paddingSize),
                      child: TextWidget(
                        DynamicLanguage.isLoading
                            ? ""
                            : "${DynamicLanguage.key(Strings.ifYouSpend)} ${controller.offerSpendAmount}, ${DynamicLanguage.key(Strings.youWillGet)} ${controller.freeDeliveryAmount} ${DynamicLanguage.key(Strings.freeDeliveries)} 😊",
                        fontWeight: FontWeight.w500,
                      )),
                ),
                Positioned.fill(
                  child: IgnorePointer(
                    child: Shimmer.fromColors(
                      baseColor: CustomColor.whiteColor.withOpacity(0.1),
                      highlightColor: CustomColor.primary.withOpacity(0.3),
                      child: Container(
                        decoration: BoxDecoration(
                          color: CustomColor.primary,
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : SizedBox.shrink(),
    );
  }
}
