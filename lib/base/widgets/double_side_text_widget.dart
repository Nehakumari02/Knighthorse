import 'package:flutter/material.dart';

import '../utils/basic_import.dart';

class DoubleSideTextWidget extends StatelessWidget {
  const DoubleSideTextWidget({
    super.key,
    this.keys,
    this.value,
    this.rightWidget,
    this.image = '',
    this.keyStyle = TypographyStyle.labelMedium,
    this.valueStyle = TypographyStyle.labelMedium,
    this.fontWeight,
    this.leftWidget,
    this.showVertical = true,
    this.keyTextStyle,
  });
  final String? keys, value;
  final TypographyStyle keyStyle;
  final TextStyle? keyTextStyle;
  final TypographyStyle valueStyle;
  final FontWeight? fontWeight;
  final String image;
  final Widget? rightWidget;
  final Widget? leftWidget;
  final bool showVertical;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: Dimensions.verticalSize * 0.16),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: mainSpaceBet,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerLeft,
                child: leftWidget ??
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: crossStart,
                      children: [
                        if (image != '')
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(
                                  Dimensions.paddingSize * 0.45,
                                ),
                                decoration: BoxDecoration(
                                  color: CustomColor.background,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(image),
                                  ),
                                ),
                              ),
                              Sizes.width.v5,
                            ],
                          ),
                        FittedBox(
                          child: TextWidget(
                            keys!,
                            typographyStyle: keyStyle,
                            style: keyTextStyle,
                            fontWeight: fontWeight,
                          ),
                        ),
                      ],
                    ),
              ),
            ),

            // RIGHT SIDE - aligned to end
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerRight,
                child: rightWidget ??
                    TextWidget(
                      value!,
                      typographyStyle: valueStyle,
                      fontWeight: fontWeight,
                      textAlign: TextAlign.end,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
