import 'package:knighthorse/views/auth%20section/login/controller/login_controller.dart';
import 'package:knighthorse/views/auth%20section/login/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../base/utils/basic_import.dart';
import '../../../../base/widgets/timer_widget.dart';
import '../../forgot_pin/controller/forgot_pin_controller.dart';
import '../controller/forgot_password_otp_verification_controller.dart';
part 'forgot_password_otp_verification_tablet_screen.dart';
part 'forgot_password_otp_verification_mobile_screen.dart';
part '../widget/otp_input_field.dart';
part '../widget/otp_heading_widget.dart';
part '../widget/submit_otp_button.dart';

class ForgotPasswordOtpVerificationScreen extends  GetView<OtpVerificationController> {
  const ForgotPasswordOtpVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: ForgotPasswordOtpVerificationMobileScreen(),
      tablet: ForgotPasswordOtpVerificationTabletScreen(),
    );
  }
}
