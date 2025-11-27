import 'dart:convert';

import 'package:knighthorse/base/api/services/delivery_service.dart';
import 'package:knighthorse/views/cart/controller/cart_controller.dart';
import 'package:knighthorse/views/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../base/utils/basic_import.dart';
import '../../../base/widgets/divider.dart';
import '../../../base/widgets/double_side_text_widget.dart';
import '../../../routes/routes.dart';
import '../../congratulations/model/congratulations_model.dart';
import '../../congratulations/screen/congratulations_screen.dart';
import '../../profile/screen/profile_screen.dart';
part 'payment_tablet_screen.dart';
part 'payment_mobile_screen.dart';
part '../widget/billing_details.dart';
part '../widget/payment_methods.dart';
part '../widget/place_order_button.dart';
part '../widget/web_payment_screen.dart';

class PaymentScreen extends GetView<CartController> {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: PaymentMobileScreen(),
      tablet: PaymentTabletScreen(),
    );
  }
}
