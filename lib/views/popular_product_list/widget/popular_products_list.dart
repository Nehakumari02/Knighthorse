part of '../screen/popular_product_list_screen.dart';

class PopularProductsList extends GetView<DashboardController> {
  const PopularProductsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _productList();
  }

  _productList() {
    return Obx(
      () => controller.popularProductsList.isEmpty
          ? NoDataWidget(
              asset: "assets/animation/emptyAnimation.json",
            )
          : GridView.builder(
              padding: EdgeInsets.only(
                top: Dimensions.verticalSize * .2,
              ),
              controller: controller.scrollController,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: Dimensions.paddingSize * 0.3,
                mainAxisSpacing: Dimensions.paddingSize * 0.4,
              ),
              itemCount: controller.popularProductsList.length + 1,
              itemBuilder: (context, index) {
                if (index < controller.popularProductsList.length) {
                  return ProductCard(
                    product: controller.popularProductsList[index],
                    onTap: () {
                      Get.toNamed(Routes.detailsScreen, arguments: {
                        "productId": controller.popularProductsList[index].id
                      });
                    },
                  );
                } else {
                  return controller.isLastPage.value
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
