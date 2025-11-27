import 'package:knighthorse/views/auth%20section/login/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../base/utils/basic_import.dart';
import '../../../../base/widgets/timer_widget.dart';
import '../../login/controller/login_controller.dart';
import '../controller/phone_login_otp_controller.dart';
part 'phone_login_otp_tablet_screen.dart';
part 'phone_login_otp_mobile_screen.dart';
part '../widget/login_otp_widget.dart';
part '../widget/heading_widget.dart';

class PhoneLoginOtpScreen extends GetView<PhoneLoginOtpController> {
  const PhoneLoginOtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: PhoneLoginOtpMobileScreen(),
      tablet: PhoneLoginOtpTabletScreen(),
    );
  }
}
