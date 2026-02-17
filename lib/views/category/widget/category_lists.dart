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
    return Container(
        height: Dimensions.heightSize * 8.5,
        width: Dimensions.heightSize * 9.5,
    child: Obx(() {
      var isSelected =
          controller.selelctedCategory.value == controller.categories[index];
      return GestureDetector(
        onTap: () {
          controller.categoryScrollIndex.value = index;
          controller.selelctedCategory.value = controller.categories[index];
        },
        child: Card(
          elevation: isSelected ? 2 : 0,
          shape: RoundedRectangleBorder(
            // --- CHANGE: Card shape to square/rounded rectangle ---
            borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
            side: isSelected
                ? BorderSide(color: CustomColor.primary, width: 1.5)
                : BorderSide.none,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.horizontalSize * .02,
                vertical: Dimensions.verticalSize * .15),
            child: Column(
              mainAxisAlignment: mainCenter,
              mainAxisSize: mainMin,
              children: [
                // --- CHANGE: Container now has fixed square dimensions and borderRadius ---
                Container(
                  height: Dimensions.heightSize * 5.7,
                  width: Dimensions.heightSize * 5.7,
                  padding: EdgeInsets.all(Dimensions.radius * 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius * 0.4),
                    color: CustomColor.primary.withOpacity(0.1),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Dimensions.radius * 0.4),
                    child: Image.network(
                      "${controller.imagePath.value}$image",
                      fit: BoxFit.contain, // Ensures the whole icon fits in the square
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(Icons.category, color: CustomColor.primary),
                    ),
                  ),
                ),
                Sizes.height.v5,

                // --- CHANGE: Decreased font size and removed maxLines/overflow ---
                TextWidget(
                  label,
                  fontSize: Dimensions.labelSmall * 0.8, // Decreased font size
                  lineHeight: 1.1,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                  textAlign: TextAlign.center,
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.widthSize * 0.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    })
    );
  }}
