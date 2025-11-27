import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final String firstText;
  final String secondText;
  final ValueChanged<bool> onChange;
  final bool selectedValue; // True for firstText, False for secondText

  const CustomSwitch({
    Key? key,
    required this.firstText,
    required this.secondText,
    required this.onChange,
    required this.selectedValue,
  }) : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  late bool isFirstSelected;

  @override
  void initState() {
    super.initState();
    // Initialize selected value from the widget parameter
    isFirstSelected = widget.selectedValue;
  }

  @override
  void didUpdateWidget(covariant CustomSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update the state if the parent changes selectedValue
    if (oldWidget.selectedValue != widget.selectedValue) {
      setState(() {
        isFirstSelected = widget.selectedValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Stack(
        children: [
          // Background animated alignment for the selected state
          AnimatedAlign(
            duration: const Duration(milliseconds: 300),
            alignment:
                isFirstSelected ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
              width: MediaQuery.sizeOf(context).width / 2.5,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Row(
            children: [
              // First text button
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (!isFirstSelected) {
                      setState(() {
                        isFirstSelected = true;
                        widget.onChange(true);
                      });
                    }
                  },
                  child: AnimatedPadding(
                    duration: const Duration(milliseconds: 300),
                    padding: isFirstSelected
                        ? const EdgeInsets.symmetric(horizontal: 0)
                        : const EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: Text(
                        widget.firstText,
                        style: TextStyle(
                          color: isFirstSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Second text button
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (isFirstSelected) {
                      setState(() {
                        isFirstSelected = false;
                        widget.onChange(false);
                      });
                    }
                  },
                  child: AnimatedPadding(
                    duration: const Duration(milliseconds: 300),
                    padding: isFirstSelected
                        ? const EdgeInsets.symmetric(horizontal: 10)
                        : const EdgeInsets.symmetric(horizontal: 0),
                    child: Center(
                      child: Text(
                        widget.secondText,
                        style: TextStyle(
                          color: !isFirstSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
