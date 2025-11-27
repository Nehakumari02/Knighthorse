import 'package:get/get.dart';
import '../views/auth section/phone_login_otp/controller/phone_login_otp_controller.dart';

class PhoneLoginOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PhoneLoginOtpController());
  }
}
