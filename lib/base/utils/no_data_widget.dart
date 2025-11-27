import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'basic_import.dart';

class NoDataWidget extends StatelessWidget {
  final double? height;
  final String? emptyMessage;
  final String? asset;
  final MainAxisAlignment? mainAlignment;
  const NoDataWidget(
      {super.key,
      this.height,
      this.emptyMessage,
      this.asset,
      this.mainAlignment});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: crossCenter,
        mainAxisAlignment: mainAlignment ?? mainCenter,
        children: [
          Lottie.asset(
            asset ?? "assets/animation/emptyAnimation.json",
            height: height ?? 100,
            animate: true,
          ),
          Sizes.height.v5,
          TextWidget(
            emptyMessage ?? Strings.noDataFound,
            typographyStyle: TypographyStyle.titleSmall,
            color: CustomColor.typographyShadeToken[100],
          ),
        ],
      ),
    );
  }
}
