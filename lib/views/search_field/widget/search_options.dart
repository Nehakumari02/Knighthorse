part of '../screen/search_field_screen.dart';

class SearchOptions extends GetView<SearchFieldController> {
  const SearchOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isSearchLoading
          ? Loader()
          : controller.searchList.isEmpty
              ? NoDataWidget()
              : ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.horizontalSize * .5,
                    vertical: Dimensions.verticalSize,
                  ),
                  itemCount: controller.searchList.length,
                  itemBuilder: (context, index) {
                    return _searchOIptionTile(index);
                  }),
    );
  }

  _searchOIptionTile(int index) {
    var data = controller.searchList[index];
    return Padding(
      padding: EdgeInsets.only(bottom: Dimensions.heightSize),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(Routes.detailsScreen, arguments: {"productId": data.id});
        },
        child: Column(
          crossAxisAlignment: crossStart,
          mainAxisSize: mainMin,
          children: [
            Row(
              crossAxisAlignment: crossCenter,
              children: [
                _leadingBox(data.image),
                Sizes.width.v10,
                TextWidget(
                  data.data.name,
                  typographyStyle: TypographyStyle.labelLarge,
                  fontWeight: FontWeight.w400,
                )
              ],
            ),
            DividerWidget()
          ],
        ),
      ),
    );
  }

  _leadingBox(String image) {
    return CircleAvatar(
      radius: Dimensions.radius * 3,
      backgroundColor: CustomColor.disableColor,
      backgroundImage: NetworkImage("${controller.imagePath}$image"),
    );
  }
}
