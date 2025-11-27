part of 'special_product_list_screen.dart';

class SpecialProductListTabletScreen extends GetView<SpecialProductListController> {
  const SpecialProductListTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar('SpecialProductList Tablet Screen'),
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
