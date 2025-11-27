import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../utils/basic_import.dart';

class Loader extends StatelessWidget {
  const Loader({
    super.key,
    this.color,
  });
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.threeArchedCircle(
        color: color ?? CustomColor.primary,
        // rightDotColor: CustomColor.secondary,
        size: Dimensions.verticalSize * 2,
      ),
    );
  }
}
