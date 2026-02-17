part of 'all_product_list_screen.dart';

class AllProductListMobileScreen extends GetView<DashboardController> {
  const AllProductListMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        "All Products",
        action: [
          _cartButton(),
        ],
      ),
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.defaultHorizontalSize),
        child: Column(
          children: [
            // --- NEW PRICE FILTER BAR ---
            _filterWidget(context),

            Expanded(
              child: Obx(() {
                if (controller.isAllProductLoading && controller.page.value == 1) {
                  return const Loader();
                }
                return const AllProductList();
              }),
            ),
          ],
        ),
      ),
    );
  }

  // 👇 The Bar that replaces the Search Widget
  _filterWidget(BuildContext context) {
    return Obx(() => AnimatedSlide(
      duration: const Duration(milliseconds: 300),
      offset: controller.showSearchBox.value ? const Offset(0, 0) : const Offset(0, -1),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: controller.showSearchBox.value ? 1 : 0,
        child: InkWell(
          onTap: () => _showFilterBottomSheet(context),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.horizontalSize,
              vertical: Dimensions.verticalSize * 0.8,
            ),
            margin: EdgeInsets.only(bottom: Dimensions.verticalSize),
            decoration: BoxDecoration(
              color: CustomColor.whiteColor,
              borderRadius: BorderRadius.circular(Dimensions.radius),
              border: Border.all(color: CustomColor.primary.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                Icon(Icons.tune, color: CustomColor.primary),
                SizedBox(width: Dimensions.widthSize),
                Expanded(
                  child: TextWidget(
                    "Filter by Price: ₹${controller.currentRangeValues.value.start.round()} - ₹${controller.currentRangeValues.value.end.round()}",
                    color: CustomColor.blackColor,
                    fontSize: Dimensions.labelMedium,
                  ),
                ),
                Icon(Icons.arrow_drop_down, color: CustomColor.primary),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  // 👇 THE BOTTOM SHEET UI
  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(Dimensions.radius * 2)),
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
                    "Price Range",
                    fontSize: Dimensions.titleMedium,
                    fontWeight: FontWeight.bold,
                  ),
                  TextButton(
                    onPressed: () {
                      controller.initializeFilter();
                      Get.back();
                    },
                    child: const Text("Reset"),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Obx(() => RangeSlider(
                values: controller.currentRangeValues.value,
                min: 0,
                max: controller.maxFilterPrice.value,
                divisions: 100,
                activeColor: CustomColor.primary,
                labels: RangeLabels(
                  "₹${controller.currentRangeValues.value.start.round()}",
                  "₹${controller.currentRangeValues.value.end.round()}",
                ),
                onChanged: (RangeValues values) {
                  controller.applyPriceFilter(values);
                },
              )),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: PrimaryButton( // Use your custom primary button
                  title: "Apply Filter",
                  onPressed: () => Get.back(),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  _cartButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimensions.horizontalSize * .5),
      decoration: BoxDecoration(
        color: CustomColor.whiteColor,
        borderRadius: BorderRadius.circular(Dimensions.radius),
      ),
      child: IconButton(
        icon: Icon(Icons.shopping_cart_outlined, color: CustomColor.blackColor),
        onPressed: () {
          Get.find<NavigationController>().selectedIndex.value = 2;
          Get.toNamed(Routes.navigation);
        },
      ),
    );
  }
}