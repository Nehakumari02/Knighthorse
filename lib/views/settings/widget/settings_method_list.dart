part of '../screen/settings_screen.dart';

class SettingsMethodList extends GetView<SettingsController> {
  const SettingsMethodList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LanguageChangeWidget(),
        Column(
          children: List.generate(
            controller.menuItems.length,
            (index) {
              return CardTypeWidget(
                title: controller.menuItems[index].title,
                description: controller.menuItems[index].description,
                icon: controller.menuItems[index].icon,
                onTap: controller.menuItems[index].onTap,
                child: controller.menuItems[index].child,
              );
            },
          ),
        ),
        if (LocalStorage.isLoggedIn) DeleteAccountWidget(),
      ],
    );
  }
}
