import 'package:get/get.dart';
import '../views/check_out/controller/check_out_controller.dart';

class CheckOutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CheckOutController());
  }
}
