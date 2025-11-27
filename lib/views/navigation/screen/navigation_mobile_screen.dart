part of 'navigation_screen.dart';

class NavigationMobileScreen extends GetView<NavigationController> {
  const NavigationMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Obx(() => controller.bodyPages[controller.selectedIndex.value]),
      bottomNavigationBar: NavigationBarWidget(),
    );
  }
}
