import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../base/utils/basic_import.dart';

class DateSlotSelector extends StatefulWidget {
  final int delayDays;
  final Widget child;
  final void Function(DateTime date)? onSlotTap;

  const DateSlotSelector({
    super.key,
    required this.delayDays,
    required this.child,
    this.onSlotTap,
  });

  @override
  State<DateSlotSelector> createState() => _DateSlotSelectorState();
}

class _DateSlotSelectorState extends State<DateSlotSelector> {
  String? _selectedDate;

  void _showDateSlotDialog(BuildContext context) {
    final slots = _generateDateSlots(widget.delayDays);

    // if (slots.isNotEmpty && _selectedDate == null) {
    //   _selectedDate = slots.first;
    // }

    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.5,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.horizontalSize,
              vertical: Dimensions.verticalSize,
            ),
            itemCount: slots.length,
            itemBuilder: (context, index) {
              final date = slots[index];
              final isSelected = _selectedDate == date;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDate = date;
                  });
                  final parsedDate =
                      DateFormat('EEEE, MMM d, yyyy').parse(date);
                  widget.onSlotTap?.call(parsedDate);
                  Get.close(1);
                },
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: Dimensions.verticalSize * .5,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.horizontalSize * .5,
                    vertical: Dimensions.verticalSize * .3,
                  ),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(Dimensions.radius * 1.2),
                    border: Border.all(
                      color: isSelected
                          ? CustomColor.blueColor
                          : CustomColor.disableColor,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextWidget(
                        date,
                        color: isSelected ? CustomColor.blueColor : null,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  List<String> _generateDateSlots(int delayDays) {
    final startDate = DateTime.now().add(Duration(days: delayDays));

    return List.generate(7, (i) {
      final date = startDate.add(Duration(days: i));
      return _formatDate(date);
    });
  }

  String _formatDate(DateTime date) {
    return DateFormat('EEEE, MMM d, y')
        .format(date); // Ex: Monday, Jun 30, 2025
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDateSlotDialog(context),
      child: widget.child,
    );
  }
}
