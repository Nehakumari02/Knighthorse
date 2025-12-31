import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../base/utils/basic_import.dart';
import '../../../routes/routes.dart';
import '../controller/dashboard_controller.dart';
// 👇 Add these imports
import '../../category/controller/category_controller.dart';
import '../../navigation/controller/navigation_controller.dart';

class FeaturedCategoriesSection extends GetView<DashboardController> {
  const FeaturedCategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isFeaturedLoading.value) return const SizedBox.shrink();
      if (controller.featuredCategories.isEmpty) return const SizedBox.shrink();

      return Padding(
        padding: EdgeInsets.only(
          left: Dimensions.horizontalSize * .7,
          right: Dimensions.horizontalSize * .7,
          bottom: Dimensions.verticalSize * .5,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  "Featured Categories",
                  fontSize: Dimensions.titleMedium,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            Sizes.height.v10,
            _featuredList(),
          ],
        ),
      );
    });
  }

  Widget _featuredList() {
    return SizedBox(
      height: 130.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.featuredCategories.length,
        itemBuilder: (context, index) {
          var featuredItem = controller.featuredCategories[index];

          return Padding(
            padding: EdgeInsets.only(right: 15.w),
            child: InkWell(
              onTap: () {
                final categoriesData = Get.find<CategoryController>();
                var navController = Get.find<NavigationController>();

                print("🔵 FEATURED CATEGORY CLICKED");
                print("➡️ Featured ID: ${featuredItem.id}");
                print("➡️ Featured Name: ${featuredItem.name}");

                // 1. Find matching category index
                int matchIndex = categoriesData.categories.indexWhere(
                        (cat) => cat.id.toString() == featuredItem.id.toString()
                );

                print("🔍 Searching in main category list...");
                print("📦 Total Categories: ${categoriesData.categories.length}");
                print("📌 Match Index Found: $matchIndex");

                if (matchIndex != -1) {
                  print("✅ MATCH FOUND — Opening Subcategories");

                  categoriesData.categoryScrollIndex.value = matchIndex;
                  categoriesData.selelctedCategory.value =
                  categoriesData.categories[matchIndex];


                  // Switch to category tab
                  navController.selectedIndex.value = 1;
                  print("🟢 Navigation Tab Switched to: ${navController.selectedIndex.value}");

                  // Force rebuild
                  categoriesData.update();
                  print("♻️ CategoryController Updated");

                  // Navigate
                  Get.toNamed(Routes.navigation);
                  print("🚀 Navigating to: ${Routes.navigation}");

                } else {
                  print("❌ ERROR: Category ID ${featuredItem.id} NOT found in main list!");
                }
              }

              ,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 70.h,
                    width: 70.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: CustomColor.primary.withOpacity(0.06),
                      border: Border.all(color: Colors.grey.withOpacity(0.3)),
                    ),
                    child: CircleAvatar(
                      radius: Dimensions.radius * 1.2,
                      backgroundColor: Colors.transparent,
                      child: ClipOval(
                        child: Image.network(
                          featuredItem.image,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(Icons.image_not_supported, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  Sizes.height.v5,
                  SizedBox(
                    width: 75.w,
                    child: TextWidget(
                      featuredItem.name,
                      fontSize: Dimensions.labelSmall,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                      maxLines: 2,

                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}