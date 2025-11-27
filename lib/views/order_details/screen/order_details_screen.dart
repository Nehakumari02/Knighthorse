import 'package:knighthorse/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../base/utils/basic_import.dart';
import '../../../base/widgets/divider.dart';
import '../../../base/widgets/double_side_text_widget.dart';
import '../controller/order_details_controller.dart';
part 'order_details_tablet_screen.dart';
part 'order_details_mobile_screen.dart';
part '../widget/product_details.dart';
part '../widget/shipment_info.dart';
part '../widget/delivary_info.dart';
part '../widget/billing_summary.dart';
part '../widget/payment_info.dart';

class OrderDetailsScreen extends GetView<OrderDetailsController> {
  const OrderDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: OrderDetailsMobileScreen(),
      tablet: OrderDetailsTabletScreen(),
    );
  }
}
