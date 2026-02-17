import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../base/utils/basic_import.dart';
import '../../../base/utils/no_data_widget.dart';
import '../../dashboard/controller/dashboard_controller.dart';
import '../../dashboard/screen/dashboard_screen.dart';
import '../../../routes/routes.dart';
class AllProductList extends GetView<DashboardController> {
  const AllProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    scrollController.addListener(() {
      // Only load more if we aren't currently filtering or if you want
      // pagination to work with filtered results
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
        controller.loadMoreAllProducts();
      }
    });

    return Obx(() => controller.filteredProductList.isEmpty // ✅ Changed to filteredProductList
        ? const NoDataWidget()
        : GridView.builder(
      padding: EdgeInsets.only(top: Dimensions.verticalSize * .2),
      controller: scrollController,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.52,
        crossAxisSpacing: Dimensions.paddingSize * 0.3,
        mainAxisSpacing: Dimensions.paddingSize * 0.4,
      ),
      // ✅ Use filteredProductList length
      itemCount: controller.filteredProductList.length + 1,
      itemBuilder: (context, index) {
        if (index < controller.filteredProductList.length) {
          return ProductCard(
            // ✅ Use filteredProductList for the data
            product: controller.filteredProductList[index],
            onTap: () {
              Get.toNamed(Routes.detailsScreen, arguments: {
                "productId": controller.filteredProductList[index].id
              });
            },
          );
        } else {
          return Obx(() => controller.isLastAllProductPage.value
              ? const SizedBox()
              : const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(child: CircularProgressIndicator()),
          ));
        }
      },
    ));
  }
}