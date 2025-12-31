part of '../screen/check_out_screen.dart';

class OrderDetails extends GetView<CartController> {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisSize: mainMin,
        crossAxisAlignment: crossStart,
        children: [
          TextWidget(
            Strings.orderDetails,
            typographyStyle: TypographyStyle.titleMedium,
            fontWeight: FontWeight.w500,
          ),
          Sizes.height.v10,
          _productListWidget(context),
        ],
      ),
    );
  }

  _productListWidget(BuildContext context) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * .16),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: controller.cartItems.length,
        itemBuilder: (context, index) {
          final item = controller.cartItems[index];
          final bool hasOffer = double.parse(item.offerPrice ?? "0.0") <
                  double.parse(item.mainPrice) &&
              double.parse(item.offerPrice ?? "0.0") != 0.0;
          return _productDetails(context,
              title: item.name,
              quantity: item.quantity.value.toString(),
              price: item.price,
              mainPrice: item.mainPrice,
              offerPrice: item.offerPrice!.toString(),
              image: item.image!,
              hasOffer: hasOffer,
              shipmentId: item.shipmentType!);
        },
      ),
    );
  }

  _productDetails(
    BuildContext context, {
    required String title,
    required String quantity,
    required String price,
    required String mainPrice,
    required String offerPrice,
    required String image,
    required String shipmentId,
    required bool hasOffer,
  }) {
    return Card(
      margin: EdgeInsets.only(
        right: Dimensions.horizontalSize * 0.4,
        bottom: Dimensions.verticalSize * .5,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.radius),
      ),
      child: Container(
        width: MediaQuery.sizeOf(context).width * .7,
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.horizontalSize * 0.6,
          vertical: Dimensions.verticalSize * 0.3,
        ),
        child: Column(
          mainAxisAlignment: mainCenter,
          mainAxisSize: mainMin,
          children: [
            Row(
              crossAxisAlignment: crossCenter,
              mainAxisSize: mainMin,
              children: [
                CircleAvatar(
                  radius: Dimensions.radius * 3,
                  backgroundColor: CustomColor.disableColor,
                  backgroundImage:
                      NetworkImage("${controller.imagePath}$image"),
                ),
                Sizes.width.v10,
                Flexible(
                  fit: FlexFit.loose,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: mainMin,
                    children: [
                      Row(
                        mainAxisAlignment: mainSpaceBet,
                        children: [
                          Flexible(
                            child: TextWidget(
                              title,
                              fontWeight: FontWeight.w400,
                              textOverflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      TextWidget(
                        "${DynamicLanguage.key(Strings.quantity)}: $quantity",
                        fontSize: Dimensions.bodySmall,
                      ),
                      Row(
                        mainAxisAlignment: mainSpaceBet,
                        children: [
                          hasOffer
                              ? Row(
                                  children: [
                                    FittedBox(
                                        child: TextWidget(
                                      "${controller.currencySymbol}${(double.parse(offerPrice) * double.parse(quantity)).toStringAsFixed(2)}",
                                      color: CustomColor.primary,
                                      fontWeight: FontWeight.w700,
                                    )),
                                    Sizes.width.v5,
                                    FittedBox(
                                        child: TextWidget(
                                      "${controller.currencySymbol}${(double.parse(mainPrice) * double.parse(quantity)).toStringAsFixed(2)}",
                                      style: CustomStyle.labelSmall.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: CustomColor.disableColor,
                                        decoration: TextDecoration.lineThrough,
                                        decorationThickness: 2.0,
                                      ),
                                    )),
                                  ],
                                )
                              : FittedBox(
                                  child: TextWidget(
                                  "${controller.currencySymbol}${(double.parse(price) * double.parse(quantity)).toStringAsFixed(2)}",
                                  color: CustomColor.primary,
                                  fontWeight: FontWeight.w700,
                                )),
                        ],
                      ),
                      // TextWidget(
                      //   _getShipmentName(shipmentId),
                      //   typographyStyle: TypographyStyle.labelMedium,
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getShipmentName(String shipmentId) {
    return controller.shipmentType
        .firstWhere((e) => e.id.toString() == shipmentId)
        .name;
  }
}
