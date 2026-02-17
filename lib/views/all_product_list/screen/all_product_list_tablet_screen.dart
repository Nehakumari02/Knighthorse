part of 'all_product_list_screen.dart';

class AllProductListTabletScreen extends GetView<AllProductListController> {
  const AllProductListTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar('All Products Tablet'),
      body: Center(child: Text("Tablet View Content")),
    );
  }
}