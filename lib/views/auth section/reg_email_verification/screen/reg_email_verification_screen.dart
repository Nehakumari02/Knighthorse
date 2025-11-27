import 'package:knighthorse/views/auth%20section/login/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../base/utils/basic_import.dart';
import '../../../../base/widgets/timer_widget.dart';
import '../../registration/controller/registration_controller.dart';
import '../controller/reg_email_verification_controller.dart';
part 'reg_email_verification_tablet_screen.dart';
part 'reg_email_verification_mobile_screen.dart';
part '../widget/otp_heading.dart';
part '../widget/otp_input_field_widget.dart';
part '../widget/otp_submit_button.dart';

class RegEmailVerificationScreen extends GetView<RegEmailVerificationController> {
  const RegEmailVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: RegEmailVerificationMobileScreen(),
      tablet: RegEmailVerificationTabletScreen(),
    );
  }
}
