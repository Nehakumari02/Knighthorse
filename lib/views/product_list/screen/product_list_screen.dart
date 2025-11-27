import 'package:knighthorse/base/utils/no_data_widget.dart';
import 'package:knighthorse/views/dashboard/screen/dashboard_screen.dart';
import 'package:knighthorse/views/navigation/controller/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../base/utils/basic_import.dart';
import '../../../routes/routes.dart';
import '../controller/product_list_controller.dart';
part 'product_list_tablet_screen.dart';
part 'product_list_mobile_screen.dart';
part '../widget/product_grid_list.dart';
part '../widget/search_widget.dart';

class ProductListScreen extends GetView<ProductListController> {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: ProductListMobileScreen(),
      tablet: ProductListTabletScreen(),
    );
  }
}
