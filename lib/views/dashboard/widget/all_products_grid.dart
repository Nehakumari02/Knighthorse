part of '../screen/dashboard_screen.dart';

class AllProductsGrid extends GetView<DashboardController> {
  const AllProductsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: Dimensions.horizontalSize * .7,
        right: Dimensions.horizontalSize * .7,
        bottom: Dimensions.verticalSize * .5,
      ),
      child: Column(
        children: [
          // --- Header ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                "All Products",
                fontSize: Dimensions.titleMedium,
                fontWeight: FontWeight.w600,
              ),
              InkWell(
                onTap: () {
                  // ✅ FIXED: Navigating to the public standalone screen
                  Get.to(() => const AllProductListScreen());
                },
                child: TextWidget(
                  fontSize: Dimensions.labelMedium,
                  Strings.viewMore,
                  fontWeight: FontWeight.w600,
                  color: CustomColor.primary,
                ),
              ),
            ],
          ),
          Sizes.height.v10,

          // --- Horizontal Scroll List (Home Page View) ---
          Obx(() => controller.allProductList.isEmpty
              ? NoDataWidget(height: 70.h)
              : _homeHorizontalList()),
        ],
      ),
    );
  }

  Widget _homeHorizontalList() {
    var itemCount = controller.allProductList.length > 6
        ? 6
        : controller.allProductList.length;

    return SizedBox(
      height: 270.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        separatorBuilder: (context, index) => SizedBox(width: 10.w),
        itemBuilder: (context, index) {
          return SizedBox(
            width: 160.w,
            child: ProductCard(
              product: controller.allProductList[index],
              onTap: () {
                Get.toNamed(Routes.detailsScreen, arguments: {
                  "productId": controller.allProductList[index].id
                });
              },
            ),
          );
        },
      ),
    );
  }
}

// ❌ DELETE EVERYTHING BELOW THIS LINE (The _FullProductListScreen class)