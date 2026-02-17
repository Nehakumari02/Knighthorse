import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../dashboard/controller/dashboard_controller.dart';

class AllProductListController extends GetxController {
  final dashboardController = Get.find<DashboardController>();

  @override
  void onInit() {
    super.onInit();
    // Refresh data if coming to this screen fresh
    if (dashboardController.allProductList.isEmpty) {
      dashboardController.getAllProducts();
    }
  }

  void loadMore() {
    dashboardController.loadMoreAllProducts();
  }
}