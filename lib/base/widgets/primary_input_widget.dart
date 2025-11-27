// ignore_for_file: unreachable_switch_default, deprecated_member_use

import 'package:dynamic_languages/dynamic_languages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../utils/basic_import.dart';

/// >>> Border Side Style
enum BSS {
  enabledBorder,
  b,
  disableBorder,
  focusedBorder,
  errorBorder,
  focusedErrorBorder,
}

enum BorderStyle { outline, underline, none }

class PrimaryInputWidget extends StatefulWidget {
  final String hintText, phoneCode;
  final String? label;
  final String? optionalText;
  final String? prefixIconPath;
  final int maxLines;
  final bool isValidator;
  final bool isPasswordField;
  final bool autoFocus;
  final bool readOnly;
  final bool isOptional;
  final bool removeLabelEnter;
  final bool outerLabel;
  final bool isFilled;
  final bool showBorderSide;
  final bool validator;
  final bool showShape;
  final bool skipEnterText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? padding;
  final double? radius;
  final double borderWidth;
  final Color? fillColor;
  final Color? shadowColor;
  final Function(String)? onChanged;
  final Decoration? customShapeDecoration;
  final EdgeInsetsGeometry? customPadding;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final AlignmentGeometry? alignment;
  final EdgeInsets? suffixIconPadding;
  final BorderStyle borderStyle;
  final TextStyle? labelTextStyle;
  final TextStyle? fontStyle;
  final String? Function(String?)? validatorFunction;
  const PrimaryInputWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIconPath = "",
    this.phoneCode = "",
    this.isValidator = true,
    this.isPasswordField = false,
    this.isFilled = false,
    this.validator = false,
    this.autoFocus = false,
    this.readOnly = false,
    this.isOptional = false,
    this.removeLabelEnter = false,
    this.skipEnterText = false,
    this.showShape = true,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.borderWidth = 0.5,
    this.radius,
    this.customPadding,
    this.padding,
    this.label,
    this.optionalText,
    this.textInputType,
    this.inputFormatters,
    this.alignment,
    this.shadowColor,
    this.borderStyle = BorderStyle.outline,
    this.fillColor,
    this.validatorFunction,
    this.showBorderSide = true,
    this.customShapeDecoration,
    this.onChanged,
    this.suffixIconPadding,
    this.labelTextStyle,
    this.outerLabel = false,
    this.fontStyle,
  });

  @override
  State<PrimaryInputWidget> createState() => _PrimaryInputWidgetState();
}

class _PrimaryInputWidgetState extends State<PrimaryInputWidget> {
  FocusNode? focusNode;
  bool isVisibility = true;
  @override
  Widget build(BuildContext context) {
    return widget.alignment != null
        ? Align(
            alignment: widget.alignment ?? Alignment.center,
            child: _buildTextFormFieldWidget(context),
          )
        : _buildTextFormFieldWidget(context);
  }

  @override
  void dispose() {
    focusNode!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();

    focusNode!.addListener(() {
      setState(() {});
    });
  }

  _buildDecoration() {
    return InputDecoration(
      hintText: DynamicLanguage.isLoading
          ? ""
          : "${DynamicLanguage.key(Strings.enter)} ${DynamicLanguage.key(widget.hintText)}",
      hintStyle: CustomStyle.bodyMedium.copyWith(
          fontWeight: FontWeight.w400,
          color: Color(0xff6C6E7C),
          overflow: TextOverflow.ellipsis),

      label: _buildLabel(),
      alignLabelWithHint: true,
      border: _setBorderStyle(BSS.b),
      enabledBorder: _setBorderStyle(BSS.enabledBorder),
      focusedBorder: _setBorderStyle(BSS.focusedBorder),
      disabledBorder: _setBorderStyle(BSS.disableBorder),
      errorBorder: _setBorderStyle(BSS.errorBorder),
      focusedErrorBorder: _setBorderStyle(BSS.focusedErrorBorder),
      prefixIcon: _setPrefixIcon(),
      fillColor: _setFillColor(context),
      filled: _setFilled(),
      isDense: true,
      contentPadding: _setPadding(),
      suffixIcon: _setSuffixIcon(),
      // suffix: _setSuffixIcon(),
    );
  }

  _buildTextFormFieldWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: crossStart,
      children: [
        if (widget.outerLabel) _buildTitle(),

        TextSelectionTheme(
          data: TextSelectionThemeData(
            selectionHandleColor: CustomColor.primary,
            selectionColor: CustomColor.primaryShade.lowTwenty,
          ),
          child: TextFormField(
            readOnly: widget.readOnly,
            controller: widget.controller,
            focusNode: focusNode,
            autofocus: widget.autoFocus,
            style: _setFontStyle(),
            inputFormatters: widget.inputFormatters,
            obscureText: widget.isPasswordField ? isVisibility : false,
            textInputAction: TextInputAction.next,
            keyboardType: widget.textInputType,
            maxLines: widget.maxLines,
            decoration: _buildDecoration(),
            validator: widget.validatorFunction ?? _setValidator(),
            cursorColor:
                Get.isDarkMode ? CustomColor.primary : CustomColor.blackColor,
            onChanged: widget.onChanged,
            onTap: () {
              if (!widget.readOnly) {
                // if (!focusNode!.hasFocus) {
                //   FocusScope.of(context).requestFocus(focusNode);
                // }
                setState(() {});
              }
            },
            onFieldSubmitted: (value) {
              if (!widget.readOnly) {
                setState(() {
                  focusNode!.unfocus();
                });
              }
            },
            onEditingComplete: () {
              if (!widget.readOnly) {
                setState(() {
                  focusNode!.unfocus();
                });
              }
            },
            onTapOutside: (value) {
              if (!widget.readOnly) {
                setState(() {
                  focusNode!.unfocus();
                });
              }
            },
          ),
        ),
        // Sizes.height.v5,
      ],
    );
  }

  _buildLabel() {
    return widget.outerLabel == false
        ? Row(
            mainAxisSize: mainMin,
            children: [
              Flexible(
                child: TextWidget(
                  focusNode!.hasFocus
                      ? (widget.label ?? "")
                      : widget.readOnly
                          ? widget.label ?? ""
                          : widget.removeLabelEnter
                              ? widget.hintText
                              : DynamicLanguage.isLoading
                                  ? ""
                                  : "${DynamicLanguage.key(Strings.enter)} ${DynamicLanguage.key(widget.hintText)}",
                  style: focusNode!.hasFocus
                      ? widget.labelTextStyle ??
                          CustomStyle.labelMedium.copyWith(
                            fontWeight: FontWeight.w400,
                            color: CustomColor.primary,
                          )
                      : CustomStyle.titleMedium.copyWith(
                          fontSize: Dimensions.titleMedium,
                        ),
                  textOverflow: TextOverflow.ellipsis,
                  color: focusNode!.hasFocus
                      ? CustomColor.primary
                      : widget.controller.text.isEmpty
                          ? Color(0xff949595)
                          : Color(0xff949595),
                ),
              ),
              if (widget.isOptional)
                TextWidget(
                  " (${DynamicLanguage.key(Strings.optional)})",
                  style: focusNode!.hasFocus
                      ? widget.labelTextStyle ??
                          CustomStyle.labelMedium.copyWith(
                            fontWeight: FontWeight.w400,
                            color: CustomColor.primary,
                          )
                      : CustomStyle.titleMedium.copyWith(
                          fontSize: Dimensions.titleMedium * 1.125,
                        ),
                  color: CustomColor.primary,
                ),
            ],
          )
        : null;
  }

  _buildTitle() {
    return widget.label != null
        ? Padding(
            padding: EdgeInsets.only(
              bottom: Dimensions.spaceBetweenInputTitleAndBox * 0.8,
            ),
            child: Row(
              mainAxisSize: mainMin,
              children: [
                TextWidget(
                  widget.label!,
                  style: widget.labelTextStyle ??
                      CustomStyle.labelSmall.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                  color: focusNode!.hasFocus
                      ? Color(0xff1D1D1D)
                      : widget.controller.text.isEmpty
                          ? Color(0xff949595)
                          : Color(0xff1D1D1D),
                ),
                if (widget.optionalText != '')
                  Row(
                    children: [
                      Sizes.width.v5,
                      TextWidget(
                        widget.optionalText ?? '',
                        style: CustomStyle.labelSmall.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                        color: focusNode!.hasFocus
                            ? Color(0xff1D1D1D)
                            : Color(0xff949595),
                      ),
                    ],
                  ),
              ],
            ),
          )
        : Container();
  }

  _setBorderSide(borderSideStyle) {
    switch (borderSideStyle) {
      case BSS.enabledBorder:
        return BorderSide(
          width: widget.borderWidth,
          color: CustomColor.disableColor,
        );
      case BSS.b:
        return BorderSide(width: widget.borderWidth, color: Colors.transparent);
      case BSS.disableBorder:
        return BorderSide(width: widget.borderWidth, color: Colors.transparent);
      case BSS.focusedBorder:
        return BorderSide(
          width: widget.borderWidth,
          color: CustomColor.primary,
        );
      case BSS.errorBorder:
        return BorderSide(
          width: widget.borderWidth,
          color: CustomColor.redColor,
        );
      case BSS.focusedErrorBorder:
        return BorderSide(
          width: widget.borderWidth,
          color: CustomColor.redColor,
        );
      default:
        return BorderSide(width: widget.borderWidth, color: Colors.transparent);
    }
  }

  _setBorderStyle(borderSideStyle) {
    switch (widget.borderStyle) {
      case BorderStyle.outline:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: widget.showBorderSide
              ? _setBorderSide(borderSideStyle)
              : BorderSide.none,
        );
      case BorderStyle.underline:
        return UnderlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: widget.showBorderSide
              ? _setBorderSide(borderSideStyle)
              : BorderSide.none,
        );

      case BorderStyle.none:
        return InputBorder.none;
      default:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: widget.showBorderSide
              ? _setBorderSide(borderSideStyle)
              : BorderSide.none,
        );
    }
  }

  _setFillColor(BuildContext context) {
    return widget.fillColor ?? Theme.of(context).colorScheme.tertiary;
  }

  _setFilled() {
    return widget.isFilled;
  }

  _setFontStyle() {
    return widget.fontStyle ??
        CustomStyle.bodyLarge.copyWith(
          fontSize: Dimensions.bodyLarge * 1.2,
          fontWeight: FontWeight.w100,
        );
  }

  _setOutlineBorderRadius() {
    return BorderRadius.circular(widget.radius ?? Dimensions.radius * 1.2);
  }

  _setPadding() {
    return EdgeInsets.symmetric(
      horizontal: Dimensions.horizontalSize * 0.6,
      vertical: Dimensions.verticalSize * 0.45,
    );
  }

  _setPrefixIcon() {
    return widget.prefixIcon ??
        (widget.prefixIconPath != ''
            ? Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSize * 0.4,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomImageWidget(
                      path: widget.prefixIconPath!,
                      color: focusNode!.hasFocus ||
                              widget.controller.text.isNotEmpty
                          ? CustomColor.typography
                          : Get.isDarkMode
                              ? CustomColor.whiteColor
                              : CustomColor.disableColor,
                    ),
                    Visibility(
                      visible: widget.phoneCode != '',
                      child: Row(
                        children: [
                          TextWidget(
                            widget.phoneCode,
                            style: TextStyle(
                              fontSize: Dimensions.headlineSmall,
                              fontWeight: FontWeight.w500,
                              color: focusNode!.hasFocus
                                  ? CustomColor.primary
                                  : CustomColor.typography.withOpacity(0.2),
                            ),
                          ).marginOnly(left: Dimensions.horizontalSize * 0.3),
                          Container(
                            margin: EdgeInsets.only(
                              left: Dimensions.horizontalSize * 0.3,
                            ),
                            height: Dimensions.heightSize * 1.5,
                            width: 1,
                            color: focusNode!.hasFocus
                                ? CustomColor.primary
                                : CustomColor.typography.withOpacity(0.2),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : null);
  }

  _setSuffixIcon() {
    return widget.suffixIcon == null && widget.isPasswordField
        ? GestureDetector(
            onTap: () {
              setState(() {
                isVisibility = !isVisibility;
              });
            },
            child: Icon(
              isVisibility ? Icons.visibility_off : Icons.visibility,
              color: focusNode!.hasFocus
                  ? CustomColor.typography
                  : Get.isDarkMode
                      ? CustomColor.typographyDark.withOpacity(0.50)
                      : CustomColor.disableColor,
              size: Dimensions.iconSizeLarge * .9,
            ),
          )
        : widget.suffixIcon;
  }

  _setValidator() {
    return widget.isValidator == false
        ? null
        : (String? value) {
            if (value!.isEmpty) {
              return Strings.pleaseFillOutTheField;
            } else {
              return null;
            }
          };
  }
}
