part of '../screen/profile_screen.dart';

class ListTileWidget extends GetView<ProfileController> {
  const ListTileWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSize * .2),
        child: ListView(
          // spacing: Dimensions.heightSize * 0.6,
          children: [
            CustomTiles(
              onTap: () {
                Routes.settingsScreen.toNamed;
              },
              text: Strings.settings,
              leadingIcon: Icons.settings_outlined,
            ),
            if (LocalStorage.isLoggedIn)
              CustomTiles(
                onTap: () {
                  Routes.ordersScreen.toNamed;
                },
                text: Strings.yourOrders,
                leadingIcon: Icons.policy_outlined,
              ),
            if (LocalStorage.isLoggedIn)
              CustomTiles(
                onTap: () {
                  Routes.paymentHistoryScreen.toNamed;
                },
                text: Strings.paymentHistory,
                leadingIcon: Icons.info_outline_rounded,
              ),
            if (LocalStorage.isLoggedIn)
              CustomTiles(
                onTap: () {
                  CustomDialog.open(
                      loading: false,
                      context: context,
                      onConfirm: () {
                        Get.put(LoginController()).logOutProcess();
                        CartDatabaseHelper().clearCart();
                      },
                      title: Strings.logout,
                      subTitle: Strings.logoutSubTitle);
                },
                text: Strings.logout,
                leadingIcon: Icons.exit_to_app_rounded,
              ),
          ],
        ),
      ),
    );
  }

  _infoColumn(String label, String value) {
    return ListTile();
  }
}
