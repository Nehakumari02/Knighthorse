import 'package:knighthorse/base/api/services/basic_services.dart';
import 'package:knighthorse/routes/routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../base/utils/basic_import.dart';
import '../../../base/utils/local_storage.dart';
import '../controller/onboard_controller.dart';

part 'onboard_mobile_screen.dart';
part 'onboard_tablet_screen.dart';

class OnboardScreen extends GetView<OnboardController> {
  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobile: OnboardMobileScreen(),
      tablet: OnboardTabletScreen(),
    );
  }
}
