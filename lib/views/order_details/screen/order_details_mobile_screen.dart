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
            // ❌ FIXED: The previous line 'Routes.navigation.offAllNamed' did nothing.
            // You need to call a function like Get.back() or your specific route.
            Get.back();
          },
        ),
        action: [
          IconButton(
            onPressed: () {
              controller.generateInvoice();
            },
            icon: const Icon(Icons.download_rounded),
            tooltip: "Download Invoice",
          ),
          const SizedBox(width: 10),
        ],
      ),
      // This Obx handles the switching between Loader and Body
      body: Obx(() => controller.isLoading ? Loader() : _bodyWidget(context)),
    );
  }

  _bodyWidget(BuildContext context) {
    return SafeArea(
      // ❌ REMOVED: You don't need a second Obx here.
      // The Obx in the build() method already listens to 'isLoading'.
      // If isLoading is false, this widget builds. You don't need to check again.
      child: ListView(
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
    );
  }
}