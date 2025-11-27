import 'package:knighthorse/base/utils/basic_import.dart';
import 'package:knighthorse/base/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/routes.dart';
import '../model/setup_method_model.dart';

class SettingsController extends GetxController {
  List<SetupMethodModel> get menuItems => [
        if (LocalStorage.isLoggedIn)
          SetupMethodModel(
            title: Strings.changePassword,
            description: '',
            icon: Icons.key_rounded,
            onTap: () {
              Routes.changePasswordScreen.toNamed;
            },
          ),
      ];
}
