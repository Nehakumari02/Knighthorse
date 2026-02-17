part of '../screen/category_screen.dart';

class SubCategoryList extends GetView<CategoryController> {
  const SubCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return categoryGridView();
  }

  Widget categoryGridView() {
    return Obx(
      () => GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          childAspectRatio: .75,
          mainAxisSpacing: Dimensions.heightSize,
          crossAxisSpacing: Dimensions.widthSize,
          children: List.generate(
            controller.filteredSubCategories.length,
            (index) {
              final item = controller.filteredSubCategories[index];
              return _subCategoryItem(item.image, item.data.name, index);
            },
          )),
    );
  }

  Widget _subCategoryItem(String image, String label, int index) {
    return GestureDetector(
      onTap: () {
        controller.selelctedSubCategory.value =
        controller.filteredSubCategories[index];
        Routes.productListScreen.toNamed;
      },
      child: Card(
        // Added slight rounding to the card to match the square look
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radius * 0.5)),
        child: Column(
          mainAxisAlignment: mainCenter,
          mainAxisSize: mainMin,
          children: [
            Center(
                child: Container(
                  height: Dimensions.heightSize * 8.0,
                  width: Dimensions.heightSize * 8.0,
                  decoration: BoxDecoration(
                    color: CustomColor.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
                  ),
                  // 1. ClipRRect is REQUIRED when using BoxFit.cover to keep it square
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
                    child: Image.network(
                      "${controller.imagePath.value}${image}",
                      fit: BoxFit.cover, // 2. This prevents stretching
                      errorBuilder: (context, error, stackTrace) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            decoration: BoxDecoration(
                              // 3. Changed Shimmer to match square shape
                              borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
                              color: CustomColor.whiteColor,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )),
            Sizes.height.v5,
            // Removed Flexible to ensure text has enough room
            TextWidget(
              label,
              // Decreased font size as requested
              fontSize: Dimensions.labelSmall * 0.85,
              lineHeight: 1.2,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.widthSize * 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }}
