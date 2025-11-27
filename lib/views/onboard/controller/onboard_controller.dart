import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knighthorse/base/extensions/extensions.dart';

import '../../../routes/routes.dart';

class OnboardController extends GetxController {
  RxInt selectedIndex = 0.obs;

  get onLogIn => Routes.loginScreen.toNamed;
  get onRegistration => Routes.registrationScreen.toNamed;

  final pageController = PageController();

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
