part of 'popular_product_list_screen.dart';

class PopularProductListTabletScreen extends GetView<DashboardController> {
  const PopularProductListTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar('PopularProductList Tablet Screen'),
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
