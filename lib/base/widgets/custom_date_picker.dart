import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/basic_import.dart';

class CustomDatePicker extends StatefulWidget {
  final RxString selectedDate; // Observable date string
  final String label;
  final String subtitle;
  final Decoration? decoration;
  final Color? labelColor;
  final double? inputBoxHeight;
  final Color? calendarIconColor;
  final Widget? leading;
  final EdgeInsets? fieldPadding;

  const CustomDatePicker({
    required this.selectedDate,
    this.label = '',
    this.subtitle = '',
    this.decoration,
    this.labelColor,
    this.inputBoxHeight,
    this.calendarIconColor,
    this.leading,
    this.fieldPadding,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker>
    with SingleTickerProviderStateMixin {
  bool isDatePickerOpened = false;

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogBackgroundColor: CustomColor.whiteColor,
            colorScheme: ColorScheme.light(
              primary: CustomColor.primary,
              onPrimary: Colors.white,
              surface: CustomColor.whiteColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: CustomColor.primary, // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        widget.selectedDate.value = _formatDate(pickedDate);
      });
    }
  }

  String _formatDate(DateTime date) {
    return "${date.day}-${date.month}-${date.year}"; // Customize format if needed
  }

  Widget _buildDatePickerButton(BuildContext context) {
    return GestureDetector(
      onTap: _selectDate,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label.isNotEmpty)
            Column(
              children: [
                Sizes.height.btnInputTitleAndBox,
                TextWidget(
                  widget.label,
                  typographyStyle: TypographyStyle.labelSmall,
                ),
                Sizes.height.btnInputTitleAndBox,
              ],
            ),
          Container(
            height: widget.inputBoxHeight ?? Dimensions.inputBoxHeight * 0.75,
            decoration: widget.decoration ??
                BoxDecoration(
                  border: Border.all(
                    color:
                        isDatePickerOpened ? CustomColor.primary : Colors.grey,
                    width: isDatePickerOpened ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(Dimensions.radius),
                ),
            child: Padding(
              padding: widget.fieldPadding ??
                  const EdgeInsets.only(left: 5, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        if (widget.leading != null) widget.leading!,
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: widget.leading == null
                                  ? Dimensions.paddingSize * 0.4
                                  : Dimensions.paddingSize * 0.4,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextWidget(
                                  widget.selectedDate.value.isEmpty
                                      ? 'Select a date'
                                      : widget.selectedDate.value,
                                  typographyStyle: TypographyStyle.titleMedium,
                                  style: CustomStyle.titleMedium.copyWith(
                                    color: widget.labelColor ??
                                        (isDatePickerOpened
                                            ? CustomColor.primary
                                            : null),
                                  ),
                                ),
                                if (widget.subtitle != '')
                                  TextWidget(
                                    widget.subtitle,
                                    fontSize: Dimensions.labelSmall * 0.9,
                                    fontWeight: FontWeight.w400,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.calendar_today,
                    color: widget.calendarIconColor ??
                        (isDatePickerOpened
                            ? CustomColor.primary
                            : CustomColor.disableColor),
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildDatePickerButton(context);
  }
}
