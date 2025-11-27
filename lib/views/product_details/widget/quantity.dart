part of '../screen/details_screen.dart';

class Quantity extends GetView<DetailsController> {
  const Quantity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisSize: mainMin,
        children: [
          _circleButton(Icons.remove, controller.decrementQuantity),
          TextWidget(
            controller.quantity.toString(),
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.horizontalSize * .5),
          ),
          _circleButton(Icons.add, controller.incrementQuantity),
        ],
      ),
    );
  }

  Widget _circleButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(
          Dimensions.radius * .15,
        ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
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
}
