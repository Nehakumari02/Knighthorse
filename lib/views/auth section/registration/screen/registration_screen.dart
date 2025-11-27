import 'package:knighthorse/views/auth%20section/login/controller/login_controller.dart';
import 'package:knighthorse/views/auth%20section/login/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../base/utils/basic_import.dart';
import '../../../../base/utils/local_storage.dart';
import '../../../../routes/routes.dart';
import '../controller/registration_controller.dart';
part 'registration_tablet_screen.dart';
part 'registration_mobile_screen.dart';
part '../widget/already_account.dart';
part '../widget/reg_heading.dart';
part '../widget/reg_input_field.dart';
part '../widget/reg_submit_button.dart';

class RegistrationScreen extends GetView<RegistrationController> {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: RegistrationMobileScreen(),
      tablet: RegistrationTabletScreen(),
    );
  }
}
