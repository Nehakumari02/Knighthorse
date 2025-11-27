import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../base/utils/basic_import.dart';
import '../controller/change_password_controller.dart';
part 'change_password_tablet_screen.dart';
part 'change_password_mobile_screen.dart';

class ChangePasswordScreen extends GetView<ChangePasswordController> {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: ChangePasswordMobileScreen(),
      tablet: ChangePasswordTabletScreen(),
    );
  }
}
