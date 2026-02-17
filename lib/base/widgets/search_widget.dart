import 'package:flutter/material.dart';
import '../utils/basic_import.dart'; // Ensure this points to your dimensions/colors

class SearchWidget extends StatelessWidget {
  final TextEditingController textController;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFilterTap;
  final String hintText;

  const SearchWidget({
    Key? key,
    required this.textController,
    this.onChanged,
    this.onFilterTap,
    this.hintText = "Search products...",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Dimensions.verticalSize * 0.5),
      decoration: BoxDecoration(
        color: CustomColor.whiteColor,
        borderRadius: BorderRadius.circular(Dimensions.radius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: TextField(
        controller: textController,
        onChanged: onChanged,
        style: CustomStyle.labelLarge,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: CustomStyle.labelMedium.copyWith(
            color: CustomColor.disableColor,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: CustomColor.primary,

          ),
          // Show filter icon if onFilterTap is provided
          suffixIcon: onFilterTap != null
              ? IconButton(
            icon: Icon(Icons.tune, color: CustomColor.primary),
            onPressed: onFilterTap,
          )
              : null,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius),
            borderSide: BorderSide(color: CustomColor.primary, width: 1),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: Dimensions.verticalSize * 0.7,
            horizontal: Dimensions.horizontalSize,
          ),
        ),
      ),
    );
  }
}