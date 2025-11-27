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
                          crossAxisCount: 4,
                          shrinkWrap: true,
                          childAspectRatio: 0.9,
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
            Container(
              padding: EdgeInsets.all(Dimensions.radius * 1.3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: CustomColor.primary.withValues(alpha: 0.06),
              ),
              child: CircleAvatar(
                radius: Dimensions.radius * 1.2,
                backgroundColor: CustomColor.primary.withOpacity(0.05),
                child:
                    Image.network("${categoriesData.imagePath.value}${image}"),
              ),
            ),
            Sizes.height.v5,
            Flexible(
              child: TextWidget(
                label,
                typographyStyle: TypographyStyle.labelMedium,
                lineHeight: 1,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.center,
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.widthSize * .3,
                ),
              ),
            ),
          ],
        ));
  }
}
