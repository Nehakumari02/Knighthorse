part of '../screen/cart_screen.dart';

class CheckoutButton extends GetView<CartController> {
  const CheckoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Dimensions.verticalSize * .5),
      child: PrimaryButton(
        title: Strings.checkOut,
        onPressed: () {
          checkLogin(onSuccess: () {
            Routes.checkOutScreen.toNamed;
            controller.updateCartProcess();
          });
        },
      ),
    );
  }
}
