import 'package:knighthorse/assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../base/utils/basic_import.dart';
import '../../cart/controller/cart_controller.dart';
import '../controller/navigation_controller.dart';
import 'bottom_item.dart';

class NavigationBarWidget extends StatelessWidget {
  NavigationBarWidget({super.key});
  final controller = Get.put(NavigationController());
  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: CustomColor.whiteColor,
      padding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      height: Dimensions.heightSize * 6,
      shape: const CircularNotchedRectangle(),
      notchMargin: 10,
      elevation: 5,
      shadowColor: CustomColor.blackColor.withOpacity(0.6),
      child: Row(
        mainAxisAlignment: mainSpaceBet,
        children: [
          Expanded(
            child: Padding(
              padding:
                  EdgeInsets.only(left: 0.5, top: Dimensions.paddingSize * 0.2),
              child: BottomItem(
                image: Assets.icons.home,
                label: Strings.home,
                index: 0,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: Dimensions.paddingSize * 0.2),
              child: BottomItem(
                icon: Icons.category_outlined,
                label: Strings.category,
                index: 1,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: Dimensions.paddingSize * 0.2),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  BottomItem(
                    icon: Icons.shopping_cart_outlined,
                    label: Strings.cart,
                    index: 2,
                  ),
                  Positioned(
                      top: 0,
                      right: 25,
                      child: Obx(() {
                              // show nothing while data is loading
                              
                              if (cartController.isDataLoading) {
                                return SizedBox.shrink();
                              }

                              // show badge only if cart has items
                              if (cartController.cartItems.isNotEmpty) {
                                return CircleAvatar(
                                  radius: Dimensions.radius * .8,
                                  backgroundColor: CustomColor.redColor,
                                  child: TextWidget(
                                    cartController.cartItems.length.toString(),
                                    color: CustomColor.whiteColor,
                                    fontSize: Dimensions.labelSmall * .8,
                                  ),
                                );
                              }

                              return SizedBox.shrink();
                            }))
                      
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: Dimensions.paddingSize * 0.2),
              child: BottomItem(
                icon: Icons.account_circle_outlined,
                label: Strings.profile,
                index: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
