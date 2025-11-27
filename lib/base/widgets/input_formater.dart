import 'package:flutter/services.dart';

final cvvInputFormatter = LengthLimitingTextInputFormatter(4);

class InputFormatter {
  // CVV Input Formatter (limits to 3 digits)
  static TextInputFormatter cvv() {
    return LengthLimitingTextInputFormatter(4);
  }

  // Card Number Input Formatter (4 4 4 4 format)
  static TextInputFormatter cardNumber() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      String text = newValue.text.replaceAll(RegExp(r'\D'), '');

      // Limit the length of the input to a maximum of 20 characters
      if (text.length > 20) text = text.substring(0, 20);

      StringBuffer buffer = StringBuffer();
      for (int i = 0; i < text.length; i++) {
        buffer.write(text[i]);
        // Insert a space after every 4 digits, except possibly the last group
        if ((i + 1) % 4 == 0 && i + 1 != text.length && i + 1 < 16) {
          buffer.write(' ');
        } else if (i + 1 == 15 || i + 1 == 19) {
          buffer.write(' ');
        }
      }

      return TextEditingValue(
        text: buffer.toString(),
        selection: TextSelection.collapsed(offset: buffer.length),
      );
    });
  }

  // Expiry Date Input Formatter (MM/YY format)
  static TextInputFormatter expiryDate() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      String text = newValue.text.replaceAll(RegExp(r'\D'), '');

      if (text.length > 6) text = text.substring(0, 6);

      StringBuffer buffer = StringBuffer();
      if (text.length >= 2) {
        buffer.write(text.substring(0, 2)); // Month part
        if (text.length > 2) {
          buffer.write('/');
          if (text.length > 4) {
            buffer.write(text.substring(2, 6)); // Full year (YYYY)
          } else {
            buffer.write(text.substring(2, 4)); // Two-digit year (YY)
          }
        }
      } else {
        buffer.write(text);
      }

      return TextEditingValue(
        text: buffer.toString(),
        selection: TextSelection.collapsed(offset: buffer.length),
      );
    });
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {
  final int decimalRange;

  DecimalTextInputFormatter({this.decimalRange = 2});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text == '') {
      return newValue;
    }

    final TextEditingValue newText = newValue.copyWith(
      text: newValue.text.replaceAll(RegExp(r'[^0-9.]'), ''),
    );

    if (newText.text.contains('.') &&
        newText.text.indexOf('.') != newText.text.lastIndexOf('.')) {
      return oldValue;
    }

    if (newText.text.contains('.')) {
      final List<String> parts = newText.text.split('.');
      if (parts.length > 1 && parts[1].length > decimalRange) {
        return oldValue;
      }
    }

    return newText;
  }
}
