import 'package:knighthorse/views/dashboard/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../base/utils/basic_import.dart';
import '../../../base/utils/no_data_widget.dart';
import '../../../routes/routes.dart';
import '../../dashboard/screen/dashboard_screen.dart';
import '../../../base/widgets/search_widget.dart';

import '../../navigation/controller/navigation_controller.dart';
import '../controller/all_product_list_controller.dart';
import '../widget/all_product_list_grid.dart';
part 'all_product_list_tablet_screen.dart';
part 'all_product_list_mobile_screen.dart';


class AllProductListScreen extends GetView<AllProductListController> {
  const AllProductListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: const AllProductListMobileScreen(),
      tablet: const AllProductListTabletScreen(),
    );
  }
}