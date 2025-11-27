import 'package:knighthorse/views/auth%20section/login/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../base/utils/basic_import.dart';
import '../controller/reset_password_controller.dart';
part 'reset_password_tablet_screen.dart';
part 'reset_password_mobile_screen.dart';
part '../widget/reset_password_heading.dart';
part '../widget/reset_password_input.dart';
part '../widget/reset_button.dart';

class ResetPasswordScreen extends GetView<ResetPasswordController> {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: ResetPasswordMobileScreen(),
      tablet: ResetPasswordTabletScreen(),
    );
  }
}
