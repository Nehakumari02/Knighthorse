import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../base/utils/basic_import.dart';
import '../../../../../../base/widgets/added/card_type_widget.dart';
import '../../../../../../base/widgets/added/custom_dialog_widget.dart';
import '../../../../routes/routes.dart';
import '../../auth section/login/controller/login_controller.dart';

class DeleteAccountWidget extends StatelessWidget {
  const DeleteAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Obx(
      () => controller.isLoading
          ? Loader()
          : CardTypeWidget(
              title: Strings.deleteAccount,
              description: '',
              icon: Icons.delete,
              isDeleteAccount: true,
              onTap: () {
                CustomDialog.open(
                    context: context,
                    onConfirm: () {
                      Get.close(1);
                      controller.deleteAccountProcess();
                      Routes.loginScreen.offAllNamed;
                    },
                    title: Strings.deleteAccount,
                    subTitle: Strings.deleteAccountSubTitle);
              },
            ),
    );
  }
}
