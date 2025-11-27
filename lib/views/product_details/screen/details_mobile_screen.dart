part of 'details_screen.dart';

class DetailsMobileScreen extends GetView<DetailsController> {
  const DetailsMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: true,
        Strings.details,
      ),
      body: Obx(() => controller.isLoading ? Loader() : _bodyWidget(context)),
      bottomNavigationBar:
          Obx(() => controller.isLoading ? SizedBox() : _bottomBar(context)),
      extendBody: true,
    );
  }

  _bodyWidget(BuildContext context) {
    return SafeArea(
      child: ListView(
          padding: EdgeInsets.only(
            top: Dimensions.verticalSize,
          ),
          children: [ProductDetails(), SimilarItems()]),
    );
  }

  Widget _bottomBar(BuildContext context) {
    final outOfStock =
        controller.selectedProduct.value!.availableQuantity == "0";
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.horizontalSize * .7,
          vertical: Dimensions.verticalSize * .5),
      decoration: BoxDecoration(color: Colors.transparent),
      child: Row(
        children: [
          Expanded(
            child: Obx(() {
              return PrimaryButton(
                title: outOfStock ? Strings.outOfStock : Strings.addToCart,
                disable: controller.hasAdded || outOfStock,
                // isLoading: Get.find<CartController>().isAddingToCart,
                onPressed: () {
                  if (!controller.hasAdded) {
                    Get.find<CartController>().addToCart(CartDatum(
                        id: controller.selectedProduct.value!.id.toString(),
                        name: controller.selectedProduct.value!.data.name,
                        price: controller.selectedProduct.value!.price,
                        mainPrice: controller.selectedProduct.value!.price,
                        shipmentType: controller
                            .selectedProduct.value!.shipment.id
                            .toString(),
                        image: controller.selectedProduct.value!.image,
                        offerPrice:
                            controller.selectedProduct.value!.offerPrice,
                        quantity: controller.cartController!.itemQuantity.value,
                        availableQuantity: controller
                            .selectedProduct.value!.availableQuantity));
                  } else {
                    return;
                  }
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
