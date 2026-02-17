import 'package:knighthorse/base/utils/basic_import.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/routes.dart';
import '../../category/controller/category_controller.dart';
import '../../navigation/controller/navigation_controller.dart';
import '../controller/dashboard_controller.dart';

class CategorySection extends GetView<DashboardController> {
  final categoriesData = Get.find<CategoryController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: Dimensions.horizontalSize * .7,
        right: Dimensions.horizontalSize * .7,
        bottom: Dimensions.verticalSize * .5,
      ),
      child: Obx(() {
        final isExpanded = controller.isExpanded.value;
        final totalItems = categoriesData.categories.length;
        final visibleItemCount =
            isExpanded ? totalItems : (totalItems > 8 ? 8 : totalItems);
        return categoriesData.isCategoriesLoading
            ? Loader()
            : Card(
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(Dimensions.radius * 2.4)),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: Dimensions.horizontalSize * .5,
                    right: Dimensions.horizontalSize * .5,
                    top: Dimensions.verticalSize * .6,
                    bottom: Dimensions.verticalSize * .4,
                  ),
                  child: Column(
                    children: [
                      AnimatedSize(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: GridView.count(
                          key: ValueKey(isExpanded),
                          crossAxisCount: 3,
                          shrinkWrap: true,
                          childAspectRatio: 0.76,
                          mainAxisSpacing: Dimensions.heightSize,
                          physics: NeverScrollableScrollPhysics(),
                          children: List.generate(visibleItemCount, (index) {
                            final data = categoriesData.categories[index];
                            return _categoryItem(
                                data.image, data.data.name, index);
                          }),
                        ),
                      ),
                      Sizes.height.v5,
                      Row(
                        mainAxisAlignment: mainCenter,
                        children: [
                          TextWidget(
                            isExpanded ? Strings.seeLess : Strings.seeMore,
                            typographyStyle: TypographyStyle.labelMedium,
                            onTap: () {
                              controller.isExpanded.toggle();
                            },
                          ),
                          Icon(
                            isExpanded
                                ? Icons.keyboard_arrow_up_rounded
                                : Icons.keyboard_arrow_down_rounded,
                            size: Dimensions.iconSizeDefault,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
      }),
    );
  }

  Widget _categoryItem(String image, String label, int index) {
    return GestureDetector(
        onTap: () {
          categoriesData.categoryScrollIndex.value = index;
          categoriesData.selelctedCategory.value =
          categoriesData.categories[index];
          Get.find<NavigationController>().selectedIndex.value = 1;
          Routes.navigation.toNamed;
        },
        child: Column(
          mainAxisSize: mainMin,
          mainAxisAlignment: mainStart,
          children: [
            // --- SQUARE CONTAINER REPLACING CIRCLE ---
            Container(
              height: Dimensions.heightSize * 6, // Fixed Height for uniform squares
              width: Dimensions.heightSize * 6,  // Fixed Width
              decoration: BoxDecoration(
                // Removed BoxShape.circle
                borderRadius: BorderRadius.circular(Dimensions.radius),
                color: CustomColor.primary.withValues(alpha: 0.06),
              ),
              // ClipRRect ensures the image corners match the container corners
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.radius),
                child: Image.network(
                  "${categoriesData.imagePath.value}${image}",
                  fit: BoxFit.cover, // Ensures no stretching and fills the square
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.category, color: CustomColor.primary),
                ),
              ),
            ),
            Sizes.height.v5,
            Flexible(
              child: TextWidget(
                label,
                // Adjusted to match your subcategory font preference
                fontSize: Dimensions.labelSmall * 0.85,
                lineHeight: 1.1,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.center,
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.widthSize * .3,
                ),
              ),
            ),
          ],
        ));
  }}
