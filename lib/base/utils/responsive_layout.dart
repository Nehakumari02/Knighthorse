import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dimensions.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent, // Make status bar transparent
        statusBarIconBrightness: Brightness.dark, // Black icons
        statusBarBrightness: Brightness.light, // For iOS (black text)
      ),
    );
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < Dimensions.mobileScreenWidth) {
          return mobile;
        } else if (constraints.maxWidth < Dimensions.tabletScreenWidth) {
          // return tablet ?? mobile; =>>  use this for tablet
          return mobile;
        } else {
          return desktop ?? mobile;
        }
      },
    );
  }
}
