import 'package:knighthorse/base/api/services/check_login.dart';
import 'package:knighthorse/base/utils/no_data_widget.dart';
import 'package:knighthorse/base/widgets/divider.dart';
import 'package:knighthorse/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../base/utils/basic_import.dart';
import '../controller/cart_controller.dart';
part 'cart_tablet_screen.dart';
part 'cart_mobile_screen.dart';
part '../widget/cart_item_list.dart';
part '../widget/promo_code_section.dart';
part '../widget/summary_section.dart';
part '../widget/checkout_button.dart';
part '../widget/quantity_widget.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: CartMobileScreen(),
      tablet: CartTabletScreen(),
    );
  }
}
