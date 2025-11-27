import 'package:knighthorse/base/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../base/utils/basic_import.dart';
import '../../../base/widgets/added/card_type_widget.dart';
import '../controller/settings_controller.dart';
import '../widget/delete_account_widget.dart';
import '../widget/language_change_widget.dart';
part 'settings_tablet_screen.dart';
part 'settings_mobile_screen.dart';
part '../widget/settings_method_list.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: SettingsMobileScreen(),
      tablet: SettingsTabletScreen(),
    );
  }
}
