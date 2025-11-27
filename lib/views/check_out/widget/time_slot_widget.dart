import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../base/utils/basic_import.dart';

class TimeSlotSelector extends StatefulWidget {
  final String startTime;
  final String endTime;
  final String gap;
  final Widget child;
  final void Function(String start, String end)? onSlotTap;

  const TimeSlotSelector({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.gap,
    required this.child,
    this.onSlotTap,
  });

  @override
  State<TimeSlotSelector> createState() => _TimeSlotSelectorState();
}

class _TimeSlotSelectorState extends State<TimeSlotSelector> {
  Map<String, String>? _selectedSlot;

  void _showTimeSlotDialog(BuildContext context) {
    final slots =
        _generateTimeSlots(widget.startTime, widget.endTime, widget.gap);

    // if (slots.isNotEmpty && (_selectedSlot == null)) {
    //   _selectedSlot = slots.first;
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
              final slot = slots[index];
              final isSelected = _selectedSlot == slot;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedSlot = slot;
                  });

                  widget.onSlotTap?.call(slot['start']!, slot['end']!);
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
                            : CustomColor.disableColor),
                  ),
                  child: Row(
                    mainAxisAlignment: mainCenter,
                    mainAxisSize: mainMin,
                    children: [
                      TextWidget(
                        '${slot["start"]} - ${slot["end"]}',
                        color: isSelected ? CustomColor.blueColor : null,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                      // isSelected ? const Icon(Icons.check_circle, color: CustomColor.blueColor) : null,
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

  List<Map<String, String>> _generateTimeSlots(
      String startStr, String endStr, String gapStr) {
    final start = _parseTimeOfDay(startStr);
    final end = _parseTimeOfDay(endStr);
    final gap = Duration(hours: int.tryParse(gapStr) ?? 1);

    final slots = <Map<String, String>>[];

    DateTime current = DateTime(2023, 1, 1, start.hour, start.minute);
    final endDateTime = DateTime(2023, 1, 1, end.hour, end.minute);

    while (current.isBefore(endDateTime)) {
      final next = current.add(gap);
      if (next.isAfter(endDateTime)) break;

      slots.add({
        "start": _formatTime(current),
        "end": _formatTime(next),
      });

      current = next;
    }

    return slots;
  }

  TimeOfDay _parseTimeOfDay(String timeString) {
    final parts = timeString.split(':');
    final hour = int.tryParse(parts[0]) ?? 0;
    final minute = int.tryParse(parts[1]) ?? 0;
    return TimeOfDay(hour: hour, minute: minute);
  }

  String _formatTime(DateTime time) {
    String hour = time.hour.toString().padLeft(2, '0');
    String minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showTimeSlotDialog(context),
      child: widget.child,
    );
  }
}
