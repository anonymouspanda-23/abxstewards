import 'package:flutter/services.dart';

class NoQuotesTextFieldFormatter extends TextInputFormatter {

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    TextSelection newSelection = newValue.selection; // get text selection info
    String truncated = newValue.text; // get updated text from textfield

    String newText = newValue.text; // get updated text from textfield

    if(newText.isNotEmpty) {
      if(newText.contains('\'') || newText.contains('\"')) {
        newSelection = oldValue.selection;
        truncated = oldValue.text;
      }
    }

    return TextEditingValue(
        text: truncated,
        selection: newSelection,
        composing: TextRange.empty
    );
  }
}