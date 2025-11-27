part of 'settings_screen.dart';

class SettingsMobileScreen extends GetView<SettingsController> {
  const SettingsMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(Strings.settings),
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.horizontalSize * .7,
          vertical: Dimensions.verticalSize * .2,
        ),
        children: [
          SettingsMethodList()
          ],
      ),
    );
  }
}
