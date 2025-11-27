import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../base/utils/basic_import.dart';
import '../controller/navigation_controller.dart';
import '../widget/navigation_bar_widget.dart';

part 'navigation_mobile_screen.dart';
part 'navigation_tablet_screen.dart';

class NavigationScreen extends GetView<NavigationController> {
  const NavigationScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: NavigationMobileScreen(),
      tablet: NavigationTabletScreen(),
    );
  }
}
