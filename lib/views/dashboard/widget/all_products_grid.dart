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
                  // Navigate to the class defined at the bottom of this file
                  Get.to(() => const _FullProductListScreen());
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

  // Widget for the Home Page (Horizontal Scroll)
  Widget _homeHorizontalList() {
    // Show max 6 items on home page
    var itemCount = controller.allProductList.length > 6
        ? 6
        : controller.allProductList.length;

    // Must wrap horizontal ListView in a SizedBox with height
    return SizedBox(
      height: 210.h, // Adjust height to fit your ProductCard
      child: ListView.separated(
        scrollDirection: Axis.horizontal, // Makes it scroll sideways
        itemCount: itemCount,
        separatorBuilder: (context, index) => SizedBox(width: 10.w),
        itemBuilder: (context, index) {
          return SizedBox(
            width: 160.w, // Fixed width for each card
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

// ==========================================================
// 2. INTERNAL CLASS FOR "VIEW MORE" SCREEN (Same File)
// ==========================================================

class _FullProductListScreen extends GetView<DashboardController> {
  const _FullProductListScreen();

  @override
  Widget build(BuildContext context) {
    // Ensure filter is reset/initialized when opening this screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initializeFilter();
    });

    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          "All Products",
          fontSize: Dimensions.titleMedium,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          // 👇 FILTER BUTTON
          IconButton(
            onPressed: () {
              _showFilterBottomSheet(context);
            },
            icon: const Icon(Icons.filter_list_rounded),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalSize * .7),
        child: Obx(() {
          // 👇 USE filteredProductList INSTEAD OF allProductList
          if (controller.filteredProductList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.search_off, size: 50, color: Colors.grey),
                  const SizedBox(height: 10),
                  TextWidget(
                    "No products found in this price range",
                    color: Colors.grey,
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10.h,
              crossAxisSpacing: 10.w,
              childAspectRatio: 0.75,
            ),
            itemCount: controller.filteredProductList.length,
            itemBuilder: (context, index) {
              return ProductCard(
                product: controller.filteredProductList[index],
                onTap: () {
                  Get.toNamed(Routes.detailsScreen, arguments: {
                    "productId": controller.filteredProductList[index].id
                  });
                },
              );
            },
          );
        }),
      ),
    );
  }

  // 👇 FILTER BOTTOM SHEET UI
  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    "Filter by Price",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  TextButton(
                    onPressed: () {
                      // Reset Logic
                      controller.initializeFilter();
                      Get.back();
                    },
                    child: const Text("Reset"),
                  )
                ],
              ),
              const SizedBox(height: 20),

              // PRICE LABELS
              Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "₹${controller.currentRangeValues.value.start.round()}", // 👈 Changed here                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "₹${controller.currentRangeValues.value.end.round()}", // 👈 Changed here                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              )),

              // SLIDER
              Obx(() => RangeSlider(
                values: controller.currentRangeValues.value,
                min: 0,
                max: controller.maxFilterPrice.value,
                divisions: 100, // Optional: makes it snap
                activeColor: CustomColor.primary,
                labels: RangeLabels(
                  "₹${controller.currentRangeValues.value.start.round()}", // 👈 Changed here
                  "₹${controller.currentRangeValues.value.end.round()}",
                ),
                onChanged: (RangeValues values) {
                  controller.applyPriceFilter(values);
                },
              )),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColor.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 12)
                  ),
                  onPressed: () => Get.back(),
                  child: const Text("Apply Filter", style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}