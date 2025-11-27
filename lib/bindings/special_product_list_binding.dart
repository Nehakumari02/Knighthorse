import 'package:get/get.dart';
import '../views/special_product_list/controller/special_product_list_controller.dart';

class SpecialProductListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SpecialProductListController());
  }
}
