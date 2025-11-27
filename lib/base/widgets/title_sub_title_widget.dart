import 'package:flutter/material.dart';

import '../utils/basic_import.dart';

class TitleSubTitleWidget extends StatelessWidget {
  const TitleSubTitleWidget({
    super.key,
    required this.title,
    required this.subTitle,
    this.subTitleFontSize,
    this.titleColor,
    this.subTitleColor,
    this.isCenterText = false,
  });
  final String title, subTitle;
  final double? subTitleFontSize;
  final Color? titleColor, subTitleColor;
  final bool isCenterText;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isCenterText ? crossCenter : crossStart,
      mainAxisAlignment: isCenterText ? mainCenter : mainCenter,
      children: [
        TextWidget(
          title,
          color: titleColor,
          fontWeight: FontWeight.w600,
          textAlign: isCenterText ? TextAlign.center : TextAlign.start,
          typographyStyle: TypographyStyle.headlineSmall,
        ),
        Sizes.height.btnInputTitleAndBox,
        Visibility(
          visible: subTitle != '',
          child: TextWidget(
            subTitle,
            color: subTitleColor,
            colorShade: ColorShade.mediumForty,
            fontWeight: FontWeight.w500,
            fontSize: subTitleFontSize,
            textAlign: isCenterText ? TextAlign.center : TextAlign.start,
            typographyStyle: TypographyStyle.bodySmall,
          ),
        ),
      ],
    );
  }
}
