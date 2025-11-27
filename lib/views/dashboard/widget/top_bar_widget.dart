import 'package:knighthorse/base/utils/basic_import.dart';
import 'package:knighthorse/views/dashboard/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopBarWidget extends GetView<DashboardController>
    implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(Dimensions.appBarHeight * 1);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      title: Row(
        children: [
          GestureDetector(
            onTap: () => _showCustomDialog(context),
            child: CircleAvatar(
              radius: Dimensions.radius * 1.5,
              backgroundColor: CustomColor.whiteColor,
              child: Icon(
                Icons.location_on_rounded,
                color: CustomColor.blackColor,
                size: Dimensions.iconSizeDefault,
              ),
            ),
          ),
          Sizes.width.v10,
          Obx(() => TextWidget(
                controller.selectedArea.value,
                fontWeight: FontWeight.w500,
                color: CustomColor.tertiaryDark.withOpacity(0.4),
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis,
              )),
        ],
      ),
      actions: [],
    );
  }

  void _showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius * 1.6),
        ),
        child: Obx(() {
          final isLoading = controller.isAreaLoading;
          final areaCount = controller.areaList.length;
          final maxHeight = MediaQuery.of(context).size.height * 0.4;
          final estimatedHeight = areaCount * 56.0 + 40; // tile + padding
          final dialogHeight =
              isLoading ? 100.0 : estimatedHeight.clamp(100.0, maxHeight);

          return SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: dialogHeight,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: Dimensions.verticalSize,
                  horizontal: Dimensions.horizontalSize * .3),
              child: Column(
                children: [
                  controller.isAreaLoading
                      ? Loader()
                      : Expanded(
                          child: ListView.builder(
                            reverse: true,
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.horizontalSize * 0.2,
                            ),
                            itemCount: controller.areaList.length,
                            itemBuilder: (_, index) => _tileWidget(index),
                          ),
                        ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _tileWidget(int index) {
    final area = controller.areaList[index];
    return GestureDetector(
      onTap: () {
        controller.setSelectedArea(area);
        controller.getPopularProducts();
        controller.getSpecialProducts();
        Get.back();
      },
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius * 1.2),
            side: BorderSide(color: CustomColor.blackColor, width: 1)),
        margin: EdgeInsets.only(
          bottom: Dimensions.heightSize,
        ),
        child: ListTile(
          title: TextWidget(area.name),
          minTileHeight: Dimensions.heightSize * 3,
          trailing: Icon(
            Icons.location_on,
            color: CustomColor.selected,
            size: Dimensions.iconSizeDefault,
          ),
        ),
      ),
    );
  }
}
