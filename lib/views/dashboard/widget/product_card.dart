part of '../screen/dashboard_screen.dart';

class ProductCard extends GetView<DashboardController> {
  final Product product;
  final VoidCallback onTap;
  const ProductCard({
    Key? key,
    required this.product,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _productCard(context, product);
  }

  Widget _productCard(BuildContext context, Product product) {
    final outOfStock = product.availableQuantity == "0";
    final bool hasOffer = double.parse(product.offerPrice ?? "0.0") <
            double.parse(product.price) &&
        double.parse(product.offerPrice ?? "0.0") != 0.0;
    return Opacity(
      opacity: outOfStock ? 0.5 : 1.0,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius),
        ),
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width * .5,
          child: Column(
            crossAxisAlignment: crossCenter,
            mainAxisAlignment: mainStart,
            mainAxisSize: mainMin,
            children: [_imageWidget(), _productData(hasOffer)],
          ),
        ),
      ),
    );
  }

  _imageWidget() {
    final outOfStock = product.availableQuantity == "0";
    return Expanded(
      flex: 3,
      child: GestureDetector(
        onTap: outOfStock ? null : onTap,
        child: Container(
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius),
              topRight: Radius.circular(Dimensions.radius),
            ),
            child: Image.network(
              "${controller.imagePath.value}${product.image}",
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: CustomColor.whiteColor,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  _productData(bool hasOffer) {
    final outOfStock = product.availableQuantity == "0";
    return Expanded(
      flex: 2,
      child: Padding(
        padding: EdgeInsets.only(
            left: Dimensions.horizontalSize * 0.7,
            right: Dimensions.horizontalSize * 0.7,
            top: Dimensions.heightSize * .5),
        child: Column(
          crossAxisAlignment: crossStart,
          children: [
            GestureDetector(
              onTap: outOfStock ? null : onTap,
              child: TextWidget(
                product.data.name,
                fontSize: Dimensions.labelLarge,
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.circle,
                  color: CustomColor.disableColor,
                  size: Dimensions.iconSizeSmall * .5,
                ),
                Sizes.width.v5,
                TextWidget(
                  product.orderQuantity,
                  fontSize: Dimensions.labelMedium,
                  fontWeight: FontWeight.w700,
                  color: CustomColor.disableColor,
                ),
                TextWidget(
                  product.unit,
                  fontSize: Dimensions.labelMedium,
                  fontWeight: FontWeight.w700,
                  color: CustomColor.disableColor,
                ),
              ],
            ),
            hasOffer
                ? Row(
                    children: [
                      FittedBox(
                          child: TextWidget(
                        "${product.currencySymbol}${product.offerPrice!}",
                        color: CustomColor.primary,
                        fontWeight: FontWeight.w700,
                      )),
                      Sizes.width.v5,
                      FittedBox(
                          child: TextWidget(
                        "${product.currencySymbol}${product.price}",
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
                    "${product.currencySymbol}${product.price}",
                    color: CustomColor.primary,
                    fontWeight: FontWeight.w700,
                  )),
            Sizes.height.v5,
            _buttonWidget(),
          ],
        ),
      ),
    );
  }

  _buttonWidget() {
    final cartController = Get.find<CartController>();

    return Obx(() => cartController.cartItems
            .any((item) => item.id == product.id.toString())
        ? AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: double.infinity,
            height: Dimensions.buttonHeight * 0.6,
            padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius * .7),
                border: Border.all(width: 0.5, color: CustomColor.blackColor)),
            child: Center(
              child: QuantityWidget(
                productId: product.id.toString(),
              ),
            ))
        : _button());
  }

  _button() {
    final cartController = Get.find<CartController>();
    final outOfStock = product.availableQuantity == "0";

    return GestureDetector(
      onTap: () {
        if (!outOfStock) {
          cartController.addToCart(CartDatum(
              id: product.id.toString(),
              name: product.data.name,
              price: product.price,
              offerPrice: product.offerPrice,
              purchaseLimit: product.purchaseLimit ?? 0,
              image: product.image,
              shipmentType: product.shipment.id.toString(),
              mainPrice: product.price,
              quantity: cartController.itemQuantity.value,
              availableQuantity: product.availableQuantity));
        }
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: double.infinity,
        height: Dimensions.buttonHeight * 0.6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius * .7),
          color: outOfStock ? CustomColor.disableColor : CustomColor.primary,
        ),
        child: Center(
          child: TextWidget(
            outOfStock ? Strings.outOfStock : Strings.add,
            fontSize: Dimensions.labelLarge,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            maxLines: 1,
            textOverflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
