import 'package:get/get.dart';

import '../views/onboard/controller/onboard_controller.dart';

class OnboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OnboardController());
  }
}
