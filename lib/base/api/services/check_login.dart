import 'package:knighthorse/base/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../languages/strings.dart';
import '../../../routes/routes.dart';
import '../../widgets/custom_snackbar.dart';

checkLogin({required VoidCallback onSuccess}) {
  if (LocalStorage.isLoggedIn) {
    onSuccess();
  } else {
    CustomSnackBar.error(Strings.youNeedToLoginFirst);
    Get.offAllNamed(Routes.loginScreen);
  }
}
