import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../base/utils/basic_import.dart';
import '../../../base/utils/no_data_widget.dart';
import '../../../routes/routes.dart';
import '../../dashboard/controller/dashboard_controller.dart';
import '../../dashboard/screen/dashboard_screen.dart';
import '../../navigation/controller/navigation_controller.dart';
import '../../product_list/screen/product_list_screen.dart';
part 'popular_product_list_tablet_screen.dart';
part 'popular_product_list_mobile_screen.dart';
part '../widget/popular_products_list.dart';

class PopularProductListScreen extends GetView<DashboardController> {
  const PopularProductListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: PopularProductListMobileScreen(),
      tablet: PopularProductListTabletScreen(),
    );
  }
}
