import 'dart:async';

import 'package:flutter/material.dart';
import 'package:knighthorse/base/utils/basic_import.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({
    super.key,
    required this.onResendCode,
  });

  final VoidCallback onResendCode;

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late int totalTimeInSeconds;
  Timer? _timer;
  bool showResend = false;

  @override
  void initState() {
    super.initState();
    totalTimeInSeconds = _parseTime('01:00');
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (totalTimeInSeconds > 0) {
        setState(() {
          totalTimeInSeconds--;
        });
      } else {
        setState(() {
          showResend = true; // Show "Resend" when the timer ends
        });
        timer.cancel();
      }
    });
  }

  void resetTimer() {
    setState(() {
      totalTimeInSeconds = _parseTime('01:00');
      showResend = false; // Hide "Resend" and show the timer again
    });
    startTimer();
  }

  // Parse the "mm:ss" format into total seconds
  int _parseTime(String time) {
    final parts = time.split(':');
    final minutes = int.parse(parts[0]);
    final seconds = int.parse(parts[1]);
    return minutes * 60 + seconds;
  }

  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$remainingSeconds';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: Dimensions.verticalSize,
      ),
      child: Row(
        children: [
          TextWidget(
            Strings.youCanResend,
            typographyStyle: TypographyStyle.labelMedium,
          ),
          Sizes.width.v5,
          TextWidget(
            showResend ? Strings.resend : formatTime(totalTimeInSeconds),
            typographyStyle: TypographyStyle.labelMedium,
            color: CustomColor.primary,
            onTap: () {
              if (showResend) {
                widget.onResendCode();
                resetTimer();
              }
            },
          ),
        ],
      ),
    );
  }
}
