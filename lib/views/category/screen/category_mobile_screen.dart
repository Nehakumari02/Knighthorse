part of 'category_screen.dart';

class CategoryMobileScreen extends GetView<CategoryController> {
  const CategoryMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        Strings.categories,
        showBackButton: false,
      ),
      body: Obx(() =>
          controller.isCategoriesLoading || controller.isSubCategoriesLoading
              ? Loader()
              : _bodyWidget(context)),
    );
  }

  _bodyWidget(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: Dimensions.horizontalSize * .7),
        child: Row(
          crossAxisAlignment: crossStart,
          children: [
            Expanded(
              flex: 2,
              child: CategoryLists(),
            ),
            Expanded(flex: 4, child: SubCategoryList()),
          ],
        ),
      ),
    );
  }
}
