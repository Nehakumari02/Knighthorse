part of 'profile_screen.dart';

class ProfileMobileScreen extends GetView<ProfileController> {
  const ProfileMobileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        "",
        showBackButton: false,
        action: [
          if (LocalStorage.isLoggedIn)
            Padding(
              padding: EdgeInsets.only(
                right: Dimensions.horizontalSize * 0.5,
              ),
              child: GestureDetector(
                onTap: () {
                  Routes.update_profileScreen.toNamed;
                },
                child: CircleAvatar(
                  backgroundColor: CustomColor.whiteColor,
                  child: Icon(Icons.edit,
                      color: CustomColor.primary, size: Dimensions.bodyLarge),
                ),
              ),
            )
        ],
      ),
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.defaultHorizontalSize,
        ),
        child: Column(
          mainAxisAlignment: mainStart,
          children: [
            ProfileImagePicker(),
            UserAndEmailWidget(),
            LocalStorage.isLoggedIn
                ? Column(children: [
                    BalanceSheetCard(),
                  ])
                : CustomTiles(
                    onTap: () {
                      Routes.loginScreen.offAllNamed;
                    },
                    text: Strings.logIn,
                    leadingIcon: Icons.login,
                  ),
            ListTileWidget(),
          ],
        ),
      ),
    );
  }
}
