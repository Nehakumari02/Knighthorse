
import 'package:knighthorse/views/cart/controller/cart_controller.dart';
import 'package:get/get.dart';

import '../views/category/controller/category_controller.dart';
import '../views/dashboard/controller/dashboard_controller.dart';
import '../views/navigation/controller/navigation_controller.dart';
import '../views/profile/controller/profile_controller.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => NavigationController());
    Get.lazyPut(() => CartController());
    Get.lazyPut(() => CategoryController());
    Get.lazyPut(() => ProfileController());
  }
}
