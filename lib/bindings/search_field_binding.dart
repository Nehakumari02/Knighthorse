import 'package:get/get.dart';
import '../views/search_field/controller/search_field_controller.dart';

class SearchFieldBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchFieldController());
  }
}
