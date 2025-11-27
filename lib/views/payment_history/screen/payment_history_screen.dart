import 'package:knighthorse/base/utils/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../base/utils/basic_import.dart';
import '../../../base/widgets/transaction_card.dart';
import '../controller/payment_history_controller.dart';
part 'payment_history_tablet_screen.dart';
part 'payment_history_mobile_screen.dart';

class PaymentHistoryScreen extends GetView<PaymentHistoryController> {
  const PaymentHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: PaymentHistoryMobileScreen(),
      tablet: PaymentHistoryTabletScreen(),
    );
  }
}
