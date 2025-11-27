
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../themes/token.dart';
import '../../utils/dimensions.dart';
import '../custom_snackbar.dart';

class VoiceToTextWidget extends StatefulWidget {
  const VoiceToTextWidget({super.key, required this.onVoiceSubmit});

  final Function(String) onVoiceSubmit;

  @override
  State<VoiceToTextWidget> createState() => _VoiceToTextWidgetState();
}

class _VoiceToTextWidgetState extends State<VoiceToTextWidget> {
  void _startVoiceInput() {
    const platform = MethodChannel('speech_to_text_channel');
    try {
      platform.invokeMethod('startVoiceInput').then((result) {
        setState(() {
          widget.onVoiceSubmit(result ?? "");
          // _controller.text = result ?? "";
        });
      });
    } catch (e) {
      CustomSnackBar.error(e.toString());
      print("Failed to start voice input: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // showModalBottomSheet(
        //   useSafeArea: true,
        //   showDragHandle: true,
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.vertical(
        //       top: Radius.circular(Dimensions.radius * 1.5),
        //     ),
        //   ),
        //   context: context,
        //   builder: (context) {
        //     return SizedBox();
        //   },
        // );
        // controller.toggleListening();
        _startVoiceInput();
      },
      child: Icon(
        Icons.mic,
        color: CustomColor.primary,
        size: Dimensions.iconSizeDefault * 1.3,
      ),
    );
  }
}
