import 'dart:async';

import 'package:knighthorse/base/utils/local_storage.dart';
import 'package:get/get.dart';

import '../../../base/api/services/basic_services.dart';
import '../../../routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    _goToScreen();
  }
  _goToScreen() async {
    Timer(const Duration(seconds: 3), () async { // <-- Make the callback async

      if (LocalStorage.isLoggedIn) {
        // User is logged in, now check their verification status
        final prefs = await SharedPreferences.getInstance();

        // Get the saved status. Default to 'approved' as a safe fallback
        // for users who logged in before this check was added.
        final status = (prefs.getString('verificationStatus') ?? 'pending').toLowerCase();
        debugPrint("✅ SplashController: Verification status found is '$status'");

        if (status == 'approved') {
          // User already logged in AND approved → go to main app
          Get.offAllNamed(Routes.navigation);
        } else {
          // User is 'pending' or 'denied'
          // Send them to the login screen. Your LoginController will
          // see this status and show the correct dialog or redirect.
          Get.offAllNamed(Routes.loginScreen);
        }

      } else {
        // User is not logged in → go to login screen
        Get.offAllNamed(Routes.loginScreen);
      }
    });
  }
}
