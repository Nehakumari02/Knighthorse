import 'package:dynamic_languages/dynamic_languages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../base/utils/basic_import.dart';
import '../../../routes/routes.dart';
import '../../auth section/auth_model/shipment_settings_model.dart';
import '../../cart/controller/cart_controller.dart';
import '../../profile/controller/profile_controller.dart';
import '../controller/check_out_controller.dart';
import '../widget/date_slot_widget.dart';
import '../widget/time_slot_widget.dart';
part 'check_out_tablet_screen.dart';
part 'check_out_mobile_screen.dart';
part '../widget/order_details.dart';
part '../widget/delivery_details.dart';
part '../widget/button_widget.dart';
part '../widget/shipment_widget.dart';

class CheckOutScreen extends GetView<CartController> {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: CheckOutMobileScreen(),
      tablet: CheckOutTabletScreen(),
    );
  }
}
