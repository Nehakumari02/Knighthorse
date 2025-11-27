
part of 'navigation_screen.dart';
class NavigationTabletScreen extends GetView<NavigationController> {
  const NavigationTabletScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar('Navigation Tablet Screen'),
      body: _bodyWidget(context),
    );
  }
  _bodyWidget(BuildContext context) {
    return const SafeArea(
      child: Column(
        children: [],
      ),
    );
  }
}

