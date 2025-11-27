part of '../screen/cart_screen.dart';

class QuantityWidget extends GetView<CartController> {
  final String productId;
  final MainAxisSize? mainAxisSize;
  const QuantityWidget({
    Key? key,
    required this.productId,
    this.mainAxisSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final cartItem =
          controller.cartItems.firstWhereOrNull((item) => item.id == productId);
      final quantity = cartItem!.quantity.value;
      return Row(
        mainAxisSize: mainAxisSize ?? mainMax,
        mainAxisAlignment: mainSpaceBet,
        children: [
          _circleButton(
              Icons.remove, () => controller.decreaseQuantity(productId)),
          TextWidget(
            quantity.toString(),
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.widthSize * 0.6,
            ),
          ),
          _circleButton(Icons.add, () {
            controller.increaseQuantity(productId);
          })
        ],
      );
    });
  }

  Widget _circleButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(
          Dimensions.radius * .2,
        ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          // borderRadius: BorderRadius.circular(Dimensions.radius * .5),
          color: CustomColor.disableColor,
        ),
        child: Icon(
          icon,
          size: Dimensions.iconSizeDefault,
          color: CustomColor.blackColor,
        ),
      ),
    );
  }

  _button() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: double.infinity,
      height: Dimensions.buttonHeight * 0.6,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius * .7),
          border: Border.all(width: 1, color: CustomColor.blackColor)),
    );
  }
}
