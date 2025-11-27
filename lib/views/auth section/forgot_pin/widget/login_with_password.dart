import 'package:flutter/material.dart';

import '../../../../base/utils/basic_import.dart';
import '../../../../routes/routes.dart';

class LoginWithPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Row(
          mainAxisAlignment: mainCenter,
          children: [
            TextWidget(
              Strings.logInWith,
              colorShade: ColorShade.mediumForty,
              padding: Dimensions.horizontalSize.edgeHorizontal * 0.08,
              typographyStyle: TypographyStyle.labelMedium,
              fontWeight: FontWeight.w400,
            ),
            TextWidget(
              "${Strings.password}?",
              colorShade: ColorShade.mediumForty,
              fontWeight: FontWeight.w400,
              color: CustomColor.primary,
              typographyStyle: TypographyStyle.labelMedium,
              onTap: () {
                Routes.loginScreen.toNamed;
              },
            ),
          ],
        ),
      ],
    );
  }
}