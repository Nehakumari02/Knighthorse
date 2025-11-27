import 'package:knighthorse/views/auth%20section/login/controller/login_controller.dart';
import 'package:knighthorse/views/auth%20section/login/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../base/utils/basic_import.dart';
import '../controller/forgot_pin_controller.dart';
import '../widget/login_with_password.dart';
part 'forgot_pin_tablet_screen.dart';
part 'forgot_pin_mobile_screen.dart';
part '../widget/forgot_input_field.dart';
part '../widget/heading_widget.dart';
part '../widget/button_widget.dart';

class ForgotPinScreen extends GetView<ForgotPinController> {
  const ForgotPinScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: ForgotPinMobileScreen(),
      tablet: ForgotPinTabletScreen(),
    );
  }
}
