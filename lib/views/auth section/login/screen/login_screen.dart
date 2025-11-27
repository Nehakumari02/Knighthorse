import 'package:knighthorse/base/api/services/basic_services.dart';
import 'package:knighthorse/base/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_form_field/phone_form_field.dart';
import '../../../../base/utils/basic_import.dart';
import '../../../../base/widgets/divider.dart';
import '../../../../base/widgets/primary_phone_form_field.dart';
import '../../../../routes/routes.dart';
import '../controller/login_controller.dart';
part 'login_tablet_screen.dart';
part 'login_mobile_screen.dart';
part '../widget/brand_logo.dart';
part '../widget/input_field.dart';
part '../widget/do_not_have_account.dart';
part '../widget/heading_widget.dart';
part '../widget/button_widget.dart';
part '../widget/phone_number_input_field.dart';
part '../widget/other_login_option.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: LoginMobileScreen(),
      tablet: LoginTabletScreen(),
    );
  }
}
