import 'package:knighthorse/views/dashboard/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../base/utils/basic_import.dart';
import '../../../base/utils/no_data_widget.dart';
import '../../../routes/routes.dart';
import '../../dashboard/screen/dashboard_screen.dart';
import '../../navigation/controller/navigation_controller.dart';
import '../../product_list/screen/product_list_screen.dart';
import '../controller/special_product_list_controller.dart';
part 'special_product_list_tablet_screen.dart';
part 'special_product_list_mobile_screen.dart';
part '../widget/special_product_list.dart';

class SpecialProductListScreen extends GetView<SpecialProductListController> {
  const SpecialProductListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: SpecialProductListMobileScreen(),
      tablet: SpecialProductListTabletScreen(),
    );
  }
}
