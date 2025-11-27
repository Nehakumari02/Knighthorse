part of 'order_details_screen.dart';

class OrderDetailsTabletScreen extends GetView<OrderDetailsController> {
  const OrderDetailsTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar('OrderDetails Tablet Screen'),
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return const SafeArea(
      child: Column(
        children: [],
      ),
    );
  }
}
