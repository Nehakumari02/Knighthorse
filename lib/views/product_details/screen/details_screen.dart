import 'package:knighthorse/base/api/services/basic_services.dart';
import 'package:knighthorse/views/cart/controller/cart_controller.dart';
import 'package:knighthorse/views/cart/model/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../base/utils/basic_import.dart';
import '../../cart/screen/cart_screen.dart';
import '../../dashboard/screen/dashboard_screen.dart';
import '../controller/details_controller.dart';
part 'details_tablet_screen.dart';
part 'details_mobile_screen.dart';
part '../widget/product_details.dart';
part '../widget/quantity.dart';
part '../widget/similar_items.dart';
class DetailsScreen extends GetView<DetailsController> {


  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: DetailsMobileScreen(),
      tablet: DetailsTabletScreen(),
    );
  }
}
