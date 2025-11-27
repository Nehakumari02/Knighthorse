import 'package:knighthorse/base/api/services/delivery_service.dart';
import 'package:knighthorse/base/utils/no_data_widget.dart';
import 'package:knighthorse/views/cart/controller/cart_controller.dart';
import 'package:knighthorse/views/cart/screen/cart_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:dynamic_languages/dynamic_languages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../base/utils/basic_import.dart';

import '../../../routes/routes.dart';
import '../../cart/model/cart_model.dart';
import '../controller/dashboard_controller.dart';
import '../model/popular_product_model.dart';
import '../widget/category_section.dart';

import '../widget/top_bar_widget.dart';

part 'dashboard_mobile_screen.dart';
part 'dashboard_tablet_screen.dart';
part '../widget/todays_special_offers.dart';
part '../widget/product_card.dart';
part '../widget/popular_grid.dart';
part '../widget/banner_widget.dart';
part '../widget/search_button.dart';
part '../widget/special_offer_product.dart';


class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: DashboardMobileScreen(),
      tablet: DashboardTabletScreen(),
    );
  }
}
