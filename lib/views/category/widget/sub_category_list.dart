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
          childAspectRatio: .9,
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
        child: Column(
          mainAxisAlignment: mainCenter,
          mainAxisSize: mainMin,
          children: [
            Center(
                child: CircleAvatar(
              radius: Dimensions.radius * 1.8,
              backgroundColor: CustomColor.primary.withOpacity(0.1),
              child: Image.network(
                "${controller.imagePath.value}${image}",
                errorBuilder: (context, error, stackTrace) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      width: Dimensions.radius * 3.6,
                      height: Dimensions.radius * 3.6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: CustomColor.whiteColor,
                      ),
                    ),
                  );
                },
              ),
            )),
            Sizes.height.v5,
            Flexible(
              child: TextWidget(
                label,
                typographyStyle: TypographyStyle.labelMedium,
                lineHeight: 1,
                maxLines: 2,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.center,
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.widthSize,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
