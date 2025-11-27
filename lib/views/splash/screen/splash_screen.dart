import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../base/api/services/basic_services.dart';
import '../../../base/utils/basic_import.dart';
import '../controller/splash_controller.dart';
import '../widget/app_version.dart';
import '../widget/splash_image.dart';

part 'splash_mobile_screen.dart';
part 'splash_tablet_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobile: SplashMobileScreen(),
      tablet: SplashTabletScreen(),
    );
  }
}
