import 'package:get/get.dart';

import '../views/cart/controller/cart_controller.dart';
import '../views/category/controller/category_controller.dart';
import '../views/dashboard/controller/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => CategoryController());
    Get.lazyPut(() => CartController());
  }
}
