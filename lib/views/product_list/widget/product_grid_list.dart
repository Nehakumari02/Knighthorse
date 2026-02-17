part of '../screen/product_list_screen.dart';

class ProductGridList extends GetView<ProductListController> {
  const ProductGridList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _productList();
  }

  _productList() {
    return Obx(
      () => GridView.builder(
        padding: EdgeInsets.only(
          top: Dimensions.verticalSize * .2,
        ),
        controller: controller.scrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.50,
          crossAxisSpacing: Dimensions.paddingSize * 0.3,
          mainAxisSpacing: Dimensions.paddingSize * 0.4,
        ),
        itemCount: controller.productsList.length + 1,
        itemBuilder: (context, index) {
          if (index < controller.productsList.length) {
            return ProductCard(
              product: controller.productsList[index],
              onTap: () {
                Get.toNamed(Routes.detailsScreen, 
                arguments: {
                  "productId": controller.productsList[index].id
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
