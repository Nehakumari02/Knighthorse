import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:knighthorse/views/navigation/controller/navigation_controller.dart';
import '../../../base/utils/basic_import.dart';

class BottomItem extends StatelessWidget {
  BottomItem(
      {super.key, this.image, required this.label, this.index, this.icon});
  final String? image;
  final IconData? icon;
  final String label;
  final int? index;
  final controller = Get.put(NavigationController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // index == 2 || index == 3
        //     ? checkLogin(
        //         onSuccess: () => controller.selectedIndex.value = index!,
        //       )
        //     : 
            controller.selectedIndex.value = index!;
      },
      child: Obx(
        () => SizedBox(
          width: Dimensions.widthSize * 5.8,
          child: Column(
            mainAxisAlignment: mainCenter,
            children: [
              image != null && image!.isNotEmpty
                  ? SvgPicture.asset(
                      image!,
                      color: controller.selectedIndex.value == index
                          ? CustomColor.primary
                          : CustomColor.disableColor,
                    )
                  : icon != null
                      ? Icon(
                          icon,
                          color: controller.selectedIndex.value == index
                              ? CustomColor.primary
                              : CustomColor.disableColor,
                        )
                      : SizedBox.shrink(),
              Sizes.height.v5,
              TextWidget(
                label,
                style: TextStyle(
                  fontSize: Dimensions.labelSmall * 0.9,
                  fontWeight: FontWeight.w400,
                ),
                color: controller.selectedIndex.value == index
                    ? CustomColor.primary
                    : CustomColor.disableColor,
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
