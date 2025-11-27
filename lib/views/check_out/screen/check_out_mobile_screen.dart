part of 'check_out_screen.dart';

class CheckOutMobileScreen extends GetView<CartController> {
  const CheckOutMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(Strings.checkOut),
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.horizontalSize * .7,
            vertical: Dimensions.verticalSize * .2),
        children: [DeliveryDetails(), ButtonWidget() ],
      ),
    );
  }
}
