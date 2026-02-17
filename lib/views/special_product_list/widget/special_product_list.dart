part of '../screen/special_product_list_screen.dart';

class SpecialProductList extends GetView<DashboardController> {
  const SpecialProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _productList();
  }

  _productList() {
    return Obx(
      () => controller.specialProductsList.isEmpty
          ? NoDataWidget(
              asset: "assets/animation/emptyAnimation.json",
            )
          : GridView.builder(
              padding: EdgeInsets.only(
                top: Dimensions.verticalSize * .2,
              ),
              controller: controller.offerScreenScrollController,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.5,
                crossAxisSpacing: Dimensions.paddingSize * 0.3,
                mainAxisSpacing: Dimensions.paddingSize * 0.4,
              ),
              itemCount: controller.specialProductsList.length + 1,
              itemBuilder: (context, index) {
                if (index < controller.specialProductsList.length) {
                  return ProductCard(
                    product: controller.specialProductsList[index],
                    onTap: () {
                      Get.toNamed(Routes.detailsScreen, arguments: {
                        "productId": controller.specialProductsList[index].id
                      });
                    },
                  );
                } else {
                  return controller.isLastOfferPage.value
                      ? SizedBox()
                      : Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(child: Loader()),
                        );
                }
              },
            ),
    );
  }
}
