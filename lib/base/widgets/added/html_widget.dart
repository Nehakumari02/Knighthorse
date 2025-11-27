import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import '../../themes/token.dart';
import '../../utils/dimensions.dart';

class HTMLWidget extends StatelessWidget {
  const HTMLWidget({super.key, required this.data});

  final String data;

  @override
  Widget build(BuildContext context) {
    return Html(
      data: data,
      style: {
        'p': Style(
            color: Get.isDarkMode
                ? CustomColor.whiteColor
                : Colors.black.withValues(alpha: 1),
            fontSize: FontSize(Dimensions.labelSmall * 1.2)),
        'li': Style(
            color: Get.isDarkMode
                ? CustomColor.whiteColor
                : Colors.black.withValues(alpha: .8),
            fontSize: FontSize(Dimensions.labelSmall * 1.0)),
        'a': Style(
            color: CustomColor.primary.withValues(alpha: .8),
            fontSize: FontSize(Dimensions.labelSmall * 1.0))
      },
    );
  }
}
