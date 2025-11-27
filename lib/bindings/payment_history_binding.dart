import 'package:get/get.dart';
import '../views/payment_history/controller/payment_history_controller.dart';

class PaymentHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PaymentHistoryController());
  }
}
