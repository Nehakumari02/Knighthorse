import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../utils/basic_import.dart';

class OtpInputField extends StatelessWidget {
  const OtpInputField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      controller: controller,
      appContext: context,
      cursorColor: CustomColor.typographyShade.lowTwenty,
      length: 6,
      obscureText: false,
      keyboardType: TextInputType.number,
      textStyle: TextStyle(color: CustomColor.disableColor),
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        fieldHeight: Dimensions.inputBoxHeight * 0.9,
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(Dimensions.radius * 1.2),
        selectedColor: CustomColor.typographyShade.zero,
        activeColor: CustomColor.primary,
        inactiveColor: CustomColor.disableColor,
        // fieldOuterPadding: EdgeInsets.only(right: Dimensions.widthSize),
        fieldWidth: Dimensions.verticalSize * 1.8,
        inactiveBorderWidth: 1,
        activeFillColor: CustomColor.primary,
        borderWidth: .5,
        activeBorderWidth: .5,
      ),
      onChanged: (String value) {},
    );
  }
}
