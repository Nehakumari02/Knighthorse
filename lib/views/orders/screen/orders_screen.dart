import 'package:knighthorse/base/utils/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../base/utils/basic_import.dart';
import '../../../routes/routes.dart';
import '../controller/orders_controller.dart';
part 'orders_tablet_screen.dart';
part 'orders_mobile_screen.dart';
part '../widget/order_tiles_widget.dart';

class OrdersScreen extends GetView<OrdersController> {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: OrdersMobileScreen(),
      tablet: OrdersTabletScreen(),
    );
  }
}
