import 'package:knighthorse/views/cart/screen/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../category/screen/category_screen.dart';
import '../../dashboard/screen/dashboard_screen.dart';
import '../../profile/screen/profile_screen.dart';

class NavigationController extends GetxController {
  RxInt selectedIndex = 0.obs;

  List<Widget> bodyPages = [
    DashboardScreen(),
    CategoryScreen(),
    CartScreen(),
    ProfileScreen()
  ];

  void changePage(int index) {
    selectedIndex.value = index;
  }
}
