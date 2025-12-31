part of '../screen/category_screen.dart';

class CategoryLists extends GetView<CategoryController> {
  const CategoryLists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.only(
          right: Dimensions.widthSize,
        ),
        reverse: false,
        controller: controller.categoryScrollController,
        itemCount: controller.categories.length,
        itemBuilder: (context, index) {
          final data = controller.categories[index];
          return _categoryItemCard(data.image, data.data.name, index);
        });
  }

  Widget _categoryItemCard(String image, String label, int index) {
    return Obx(() {
      var isSelected =
          controller.selelctedCategory.value == controller.categories[index];
      return GestureDetector(
        onTap: () {
          controller.categoryScrollIndex.value = index;
          controller.selelctedCategory.value = controller.categories[index];
        },
        child: Card(
          elevation: isSelected ? 2 : 0,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.horizontalSize * .4,
                vertical: Dimensions.verticalSize * .4),
            child: Column(
              mainAxisAlignment: mainCenter,
              mainAxisSize: mainMin,
              children: [
                Container(
                  padding: EdgeInsets.all(Dimensions.radius * 1.2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: CustomColor.primary.withValues(alpha: 0.15),
                  ),
                  child: Center(
                      child: CircleAvatar(
                    radius: Dimensions.radius * 1.1,
                    backgroundColor: CustomColor.primary.withOpacity(0.1),
                    child:
                        Image.network("${controller.imagePath.value}${image}"),
                  )),
                ),
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
        ),
      );
    });
  }
}
