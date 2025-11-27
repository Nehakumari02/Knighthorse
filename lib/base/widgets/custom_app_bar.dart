import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:knighthorse/base/utils/basic_import.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
    this.title, {
    super.key,
    this.backgroundColor,
    this.elevation = 0,
    this.autoLeading = false,
    this.showBackButton = true,
    this.centerTitle = true,
    this.isWhite = false,
    this.action,
    this.leading,
    this.bottom,
    this.toolbarHeight,
    this.appbarSize,
    this.leadingWidth,
    this.onTap,
  });

  final String title;
  final Color? backgroundColor;
  final double elevation;
  final List<Widget>? action;
  final Widget? leading;
  final bool autoLeading;
  final bool showBackButton;
  final bool centerTitle;
  final bool isWhite;
  final PreferredSizeWidget? bottom;
  final double? toolbarHeight;
  final double? appbarSize;
  final double? leadingWidth;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      title: TextWidget(
        title,
        color: isWhite ? Colors.white : null,
        fontSize: Dimensions.titleLarge * .9,
        fontWeight: FontWeight.w400,
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.horizontalSize * .3,
        ),
      ),
      actions: action,
      systemOverlayStyle: SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      leading: showBackButton
          ? leading ??
              BackButtonWidget(
                onTap: onTap ??
                    () {
                      Get.close(1);
                    },
                isWhite: isWhite,
              )
          : null,
      bottom: bottom,
      elevation: elevation,
      toolbarHeight: toolbarHeight,
      leadingWidth: leadingWidth,
      scrolledUnderElevation: 0,
      backgroundColor: backgroundColor ?? Colors.transparent,
      automaticallyImplyLeading: autoLeading,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(appbarSize ?? Dimensions.appBarHeight * 1.3);
}
