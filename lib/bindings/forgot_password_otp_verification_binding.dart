import 'package:get/get.dart';
import '../views/auth section/forgot_password_otp_verification/controller/forgot_password_otp_verification_controller.dart';

class ForgotPasswordOtpVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OtpVerificationController());
  }
}
