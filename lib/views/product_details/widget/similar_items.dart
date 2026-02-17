part of '../screen/details_screen.dart';

class SimilarItems extends GetView<DetailsController> {
  const SimilarItems({Key? key}) : super(key: key);
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
                Strings.similarItems,
                fontSize: Dimensions.titleMedium,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          Sizes.height.v10,
          _similarProductList(),
        ],
      ),
    );
  }

  _similarProductList() {
    return SizedBox(
        height: 280.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.similarProduct.length,
          itemBuilder: (context, index) {
            return ProductCard(
                product: controller.similarProduct[index],
                onTap: () {
                  controller
                      .getProductDetails(controller.similarProduct[index].id);
                });
          },
        ));
  }
}
