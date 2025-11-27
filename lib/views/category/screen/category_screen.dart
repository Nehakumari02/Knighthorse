import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../base/utils/basic_import.dart';
import '../../../routes/routes.dart';
import '../controller/category_controller.dart';
part 'category_tablet_screen.dart';
part 'category_mobile_screen.dart';
part '../widget/category_lists.dart';
part '../widget/sub_category_list.dart';

class CategoryScreen extends GetView<CategoryController> {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: CategoryMobileScreen(),
      tablet: CategoryTabletScreen(),
    );
  }
}
