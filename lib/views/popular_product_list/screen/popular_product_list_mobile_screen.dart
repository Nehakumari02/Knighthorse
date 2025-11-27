part of 'popular_product_list_screen.dart';

class PopularProductListMobileScreen extends GetView<DashboardController> {
  const PopularProductListMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        Strings.popularProducts,
        action: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: Dimensions.horizontalSize * .5,
            ),
            decoration: BoxDecoration(
              color: CustomColor.whiteColor,
              borderRadius: BorderRadius.circular(Dimensions.radius),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart_outlined,
                  color: CustomColor.blackColor),
              onPressed: () {
                Get.find<NavigationController>().selectedIndex.value = 2;
                Routes.navigation.toNamed;
              },
            ),
          ),
        ],
      ),
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: Dimensions.defaultHorizontalSize),
        child: Obx(() => Column(
              children: [
                AnimatedSlide(
                  duration: Duration(milliseconds: 300),
                  offset: controller.showSearchBox.value
                      ? Offset(0, 0)
                      : Offset(0, -1),
                  curve: Curves.easeInOut,
                  child: AnimatedOpacity(
                    duration: Duration(milliseconds: 300),
                    opacity: controller.showSearchBox.value ? 1 : 0,
                    child: SearchWidget(
                      textController: controller.searchController,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          controller.page.value = 1;
                          controller.getPopularProducts(termValue: value);
                        } else {
                          controller.page.value = 1;
                          controller.getPopularProducts();
                        }
                      },
                    ),
                  ),
                ),
                Expanded(
                    child: Obx(() => controller.page.value == 1 &&
                            controller.isPopularLoading
                        ? Loader()
                        : controller.popularProductsList.isEmpty
                            ? NoDataWidget()
                            : PopularProductsList())),
              ],
            )),
      ),
    );
  }
}
