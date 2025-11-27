import 'package:flutter/material.dart';

import '../../utils/basic_import.dart';

class CustomTiles extends StatelessWidget {
  const CustomTiles(
      {super.key,
      required this.text,
      required this.onTap,
      required this.leadingIcon,
      this.bgColor});

  final String text;
  final VoidCallback onTap;
  final IconData leadingIcon;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSize * .0,
          vertical: Dimensions.paddingSize * 0.1),
      margin: EdgeInsets.only(
        bottom: Dimensions.verticalSize * .2,
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSize * .6,
              vertical: Dimensions.paddingSize * 0.4),
          decoration: BoxDecoration(
              color: bgColor ?? CustomColor.primary.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(Dimensions.radius * 1.2)),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: bgColor != null
                        ? CustomColor.whiteColor.withValues(alpha: .2)
                        : Colors.grey.withValues(alpha: .2),
                    borderRadius:
                        BorderRadius.circular(Dimensions.radius * .6)),
                child: Icon(leadingIcon,
                    color: bgColor != null
                        ? CustomColor.whiteColor
                        : CustomColor.blackColor,
                    size: Dimensions.iconSizeDefault * 1.2),
              ),
              Sizes.width.v10,
              Expanded(
                  child: TextWidget(text,
                      color: bgColor != null ? CustomColor.whiteColor : null)),
              Sizes.width.v10,
              Icon(Icons.arrow_forward_ios_sharp,
                  size: Dimensions.iconSizeSmall,
                  color: bgColor != null ? CustomColor.whiteColor : null),
            ],
          ),
        ),
      ),
    );
  }
}
