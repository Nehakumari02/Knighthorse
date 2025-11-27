import 'package:get/get.dart';
import '../views/popular_product_list/controller/popular_product_list_controller.dart';

class PopularProductListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PopularProductListController());
  }
}
