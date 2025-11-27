part of '../screen/cart_screen.dart';

class CartItemList extends GetView<CartController> {
  const CartItemList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
        itemCount: controller.cartItems.length,
        itemBuilder: (context, index) {
          final item = controller.cartItems[index];
          final bool hasOffer = double.parse(item.offerPrice ?? "0.0") <
                  double.parse(item.mainPrice) &&
              double.parse(item.offerPrice ?? "0.0") != 0.0;
          return Obx(() => _cartItemCard(
              title: item.name,
              price: item.price.obs,
              mainPrice: item.mainPrice.obs,
              image: item.image!,
              offerPrice: item.offerPrice!.obs,
              quantity: item.quantity.value,
              index: index,
              id: item.id,
              hasOffer: hasOffer));
        },
      ),
    );
  }

  _cartItemCard({
    required String title,
    required RxString price,
    required RxString mainPrice,
    required RxString offerPrice,
    required String image,
    required String id,
    required int index,
    required int quantity,
    required bool hasOffer,
  }) {
    return Card(
      margin: EdgeInsets.only(
        bottom: Dimensions.verticalSize * .5,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.radius),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.horizontalSize * 0.6,
          vertical: Dimensions.verticalSize * 0.5,
        ),
        child: Row(
          crossAxisAlignment: crossCenter,
          children: [
            CircleAvatar(
              radius: Dimensions.radius * 3,
              backgroundColor: CustomColor.disableColor,
              backgroundImage: NetworkImage("${controller.imagePath}$image"),
            ),
            Sizes.width.v10,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    child: TextWidget(
                      title,
                      fontWeight: FontWeight.w500,
                      textOverflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Sizes.height.v5,
                  Row(
                    mainAxisAlignment: mainSpaceBet,
                    children: [
                      Row(
                        children: [
                          hasOffer
                              ? Row(
                                  children: [
                                    FittedBox(
                                        child: TextWidget(
                                      "${controller.currencySymbol}${(double.parse(offerPrice.value) * quantity).toStringAsFixed(2)}",
                                      color: CustomColor.primary,
                                      fontWeight: FontWeight.w700,
                                    )),
                                    Sizes.width.v5,
                                    FittedBox(
                                        child: TextWidget(
                                      "${controller.currencySymbol}${double.parse(mainPrice.value).toStringAsFixed(2)}",
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
                                  "${controller.currencySymbol}${(double.parse(price.value) * quantity).toStringAsFixed(2)}",
                                  color: CustomColor.primary,
                                  fontWeight: FontWeight.w700,
                                )),
                          Sizes.width.v10,
                          GestureDetector(
                            onTap: () {
                              controller.removeFromCart(id);
                            },
                            child: Icon(
                              Icons.delete_outline_outlined,
                              color: CustomColor.redColor,
                              size: Dimensions.iconSizeDefault,
                            ),
                          ),
                        ],
                      ),
                      QuantityWidget(productId: id),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
