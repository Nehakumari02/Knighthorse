part of '../screen/payment_screen.dart';

class PlaceOrderButton extends GetView<CartController> {
  const PlaceOrderButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PrimaryButton(
          title: Strings.placeOrder,
          isLoading: controller.isCheckingOut,
          onPressed: () {
            controller.checkoutProcess();
          }),
    );
  }
}
