part of 'orders_screen.dart';

class OrdersMobileScreen extends GetView<OrdersController> {
  const OrdersMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        Strings.yourOrders,
        onTap: () {
          Routes.navigation.toNamed;
        },
      ),
      body: Obx(() => controller.isLoading ? Loader() : _bodyWidget(context)),
    );
  }

  _bodyWidget(BuildContext context) {
    return SafeArea(
        child: Obx(
      () => controller.orderList.isEmpty
          ? NoDataWidget(
              emptyMessage: Strings.historyNotFound,
            )
          : ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.horizontalSize * .7,
                vertical: Dimensions.verticalSize * .5,
              ),
              itemCount: controller.orderList.length,
              itemBuilder: (context, index) {
                return OrderTilesWidget(index: index);
              }),
    ));
  }
}
