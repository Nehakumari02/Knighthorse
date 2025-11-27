import 'package:get/get.dart';
import '../views/auth section/forgot_pin/controller/forgot_pin_controller.dart';

class ForgotPinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgotPinController());
  }
}
