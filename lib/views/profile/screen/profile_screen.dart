import 'package:knighthorse/base/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../base/utils/basic_import.dart';
import '../../../base/utils/cart_db_helper.dart';
import '../../../base/widgets/added/custom_dialog_widget.dart';
import '../../../base/widgets/added/custom_tiles.dart';
import '../../../routes/routes.dart';
import '../../auth section/login/controller/login_controller.dart';
import '../controller/profile_controller.dart';
part 'profile_tablet_screen.dart';
part 'profile_mobile_screen.dart';
part '../widget/profile_image.dart';
part '../widget/balance_sheet_card.dart';
part '../widget/list_tile_widget.dart';
part '../widget/user_email.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: ProfileMobileScreen(),
      tablet: ProfileTabletScreen(),
    );
  }
}
