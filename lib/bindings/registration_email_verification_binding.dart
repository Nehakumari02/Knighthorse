import 'package:get/get.dart';
import '../views/auth section/reg_email_verification/controller/reg_email_verification_controller.dart';

class RegEmailVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegEmailVerificationController());
  }
}
