part of '../screen/dashboard_screen.dart';

class SpecialOfferProduct extends GetView<DashboardController> {
  const SpecialOfferProduct({Key? key}) : super(key: key);

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
            mainAxisAlignment: mainSpaceBet,
            children: [
              TextWidget(
                Strings.specialOffer,
                fontSize: Dimensions.titleMedium,
                fontWeight: FontWeight.w600,
              ),
              InkWell(
                onTap: () {
                  Routes.specialProductListScreen.toNamed;
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
          Obx(()=> controller.specialProductsList.isEmpty? NoDataWidget(height: 70.h,): _specialProductList()),
        ],
      ),
    );
  }

  _specialProductList() {
    return SizedBox(
        height: 250.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.specialProductsList.length > 5
              ? 5
              : controller.specialProductsList.length,
          itemBuilder: (context, index) {
            return _productCard(context, controller.specialProductsList[index]);
          },
        ));
  }

  Widget _productCard(BuildContext context, Product product) {
    final bool hasOffer = double.parse(product.offerPrice ?? "0.0") <
            double.parse(product.price) &&
        double.parse(product.offerPrice ?? "0.0") != 0.0;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.radius),
      ),
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width * .65,
        child: Column(
          crossAxisAlignment: crossCenter,
          mainAxisAlignment: mainStart,
          mainAxisSize: mainMin,
          children: [_imageWidget(product), _productData(hasOffer, product)],
        ),
      ),
    );
  }

  _imageWidget(Product product) {
    return Expanded(
      flex: 3,
      child: GestureDetector(
        onTap: () {
          Get.toNamed(Routes.detailsScreen,
              arguments: {"productId": product.id});
        },
        child: Container(
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
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
              Positioned(
                top: 25,
                left: -35,
                child: Transform.rotate(
                  angle: -0.78,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.horizontalSize,
                      vertical: Dimensions.verticalSize * .2,
                    ),
                    color: CustomColor.primary,
                    child: Row(
                      mainAxisAlignment: mainCenter,
                      children: [
                        TextWidget(
                          Strings.discountOffer,
                          color: CustomColor.whiteColor,
                          typographyStyle: TypographyStyle.labelMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _productData(bool hasOffer, Product product) {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: EdgeInsets.only(
            left: Dimensions.horizontalSize * 0.4,
            right: Dimensions.horizontalSize * 0.4,
            top: Dimensions.heightSize * .5),
        child: Column(
          crossAxisAlignment: crossStart,
          children: [
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.detailsScreen,
                    arguments: {"productId": product.id});
              },
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
            Row(children: [
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
              Sizes.width.v15,
              Flexible(
                child: _buttonWidget(product),
              )
            ]),
            Sizes.height.v5,
          ],
        ),
      ),
    );
  }

  _buttonWidget(Product product) {
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
            child:
                Center(child: QuantityWidget(productId: product.id.toString())),
          )
        : _button(product));
  }

  _button(Product product) {
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
              image: product.image,
              shipmentType: product.shipment.id.toString(),
              mainPrice: product.price,
              purchaseLimit: product.purchaseLimit ?? 1000,
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
