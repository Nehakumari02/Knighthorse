part of '../screen/dashboard_screen.dart';

class PopularProductGrid extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: Dimensions.horizontalSize * .7,
        right: Dimensions.horizontalSize * .7,
        bottom: Dimensions.verticalSize * .5,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                Strings.popularProducts,
                fontSize: Dimensions.titleMedium,
                fontWeight: FontWeight.w600,
              ),
              InkWell(
                onTap: () {
                  Routes.popularProductListScreen.toNamed;
                },
                child: TextWidget(
                  fontSize: Dimensions.labelMedium,
                  Strings.viewMore,
                  fontWeight: FontWeight.w600,
                  color: CustomColor.primary,
                ),
              ),
            ],
          ),
          Sizes.height.v10,
          Obx(()=>controller.popularProductsList.isEmpty? NoDataWidget(height: 70.h,): _popularProductList()) ,
        ],
      ),
    );
  }

  _popularProductList() {
    return SizedBox(
        height: 280.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.popularProductsList.length > 5
              ? 5
              : controller.popularProductsList.length,
          itemBuilder: (context, index) {
            return ProductCard(
              product: controller.popularProductsList[index],
              onTap: () {
                Get.toNamed(Routes.detailsScreen, arguments: {
                  "productId": controller.popularProductsList[index].id
                });
              },
            );
          },
        ));
  }
}
