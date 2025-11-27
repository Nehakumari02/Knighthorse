part of '../screen/check_out_screen.dart';

class ButtonWidget extends GetView<CartController> {
  const ButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Dimensions.verticalSize * .5),
      child: Obx(()=> PrimaryButton(
            title: Strings.confirmPayment,
            disable: !controller.isDetailsValid.value,
            onPressed: () {
              if(controller.isDetailsValid.value){
                controller.deliverySet();
              Routes.paymentScreen.toNamed;
              }
            }),
      ),
    );
  }
}
