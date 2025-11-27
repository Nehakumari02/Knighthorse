part of 'payment_screen.dart';

class PaymentMobileScreen extends GetView<CartController> {
  const PaymentMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(Strings.confirmPayment),
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.horizontalSize * .7,
            vertical: Dimensions.verticalSize * .2),
        children: [
          BalanceSheetCard(
            color: CustomColor.whiteColor,
          ),
          BillingDetails(),
          PaymentMethods()
        ],
      ),
    );
  }
}
