import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../base/utils/basic_import.dart';
import '../../auth section/login/screen/login_screen.dart';
import '../../profile/controller/profile_controller.dart';
import '../../profile/screen/profile_screen.dart';
import '../widget/profile_picture_picker.dart';
part 'update_profile_tablet_screen.dart';
part 'update_profile_mobile_screen.dart';
part '../widget/button_widget.dart';
part '../widget/input_field_widget.dart';

class UpdateProfileScreen extends GetView<ProfileController> {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: UpdateProfileMobileScreen(),
      tablet: UpdateProfileTabletScreen(),
    );
  }
}
