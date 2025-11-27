import 'package:knighthorse/base/api/services/basic_services.dart';
import 'package:flutter/material.dart';
import 'package:knighthorse/base/utils/basic_import.dart';
import 'package:google_fonts/google_fonts.dart';

class AppVersion extends StatelessWidget {
  const AppVersion({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextWidget(
          Strings.appName,
          style: CustomStyle.headlineLarge.copyWith(
            fontFamily: GoogleFonts.outfit().fontFamily,
            fontWeight: FontWeight.w700,
          ),
        ),
        TextWidget(
          BasicServices.siteTitle.value,
            style: CustomStyle.labelMedium.copyWith(
              fontWeight: FontWeight.w500,
              fontFamily: GoogleFonts.outfit().fontFamily,  
            
            ),
          maxLines: 3,
          textAlign: TextAlign.center,
          padding: Dimensions.horizontalSize.edgeHorizontal,
            color: CustomColor.tertiaryDark.withValues(alpha: 0.6)),
      ],
    );
  }
}
