part of 'order_details_screen.dart';

class OrderDetailsMobileScreen extends GetView<OrderDetailsController> {
  const OrderDetailsMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        Strings.orderDetails,
        leading: BackButtonWidget(
          onTap: () {
            Routes.navigation.offAllNamed;
          },
        ),
      ),
      body: Obx(() => controller.isLoading ? Loader() : _bodyWidget(context)),
    );
  }

  _bodyWidget(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => controller.isLoading
            ? Loader()
            : ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.horizontalSize * .7,
                  vertical: Dimensions.verticalSize * .5,
                ),
                children: [
                  ProductDetails(),
                  BillingSummary(),
                  ShipmentInfo(),
                  DelivaryInfo(),
                  PaymentInfo()
                ],
              ),
      ),
    );
  }
}
