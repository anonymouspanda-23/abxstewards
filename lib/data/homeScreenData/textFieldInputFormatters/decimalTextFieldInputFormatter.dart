import 'package:flutter/services.dart';
//import 'dart:math' as math;

//import '../questionData/questionsData.dart';

class DecimalTextInputFormatter extends TextInputFormatter {

  DecimalTextInputFormatter({this.decimalRange, this.index})
      : assert((decimalRange == null || decimalRange > 0) && index != null);

  final int decimalRange;
  final int index;

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    if(decimalRange != null) {
      String value = newValue.text;

      if(value.isNotEmpty) {
        if(!isNumeric(value) || value == ".") { // replace with regexp
          truncated = oldValue.text;
          newSelection = oldValue.selection;
        } else if(value.contains(" ")) {
          newSelection = oldValue.selection;
          truncated = oldValue.text;
        } else {
          /*if(!value.contains(".") && value.length > 1 && value.length > oldValue.text.length
              && double.tryParse(value) >= QuestionsList.questionsData[index]['min']
              && double.tryParse(value) <= QuestionsList.questionsData[index]["max"]) {
            truncated = value + ".";

            newSelection = newValue.selection.copyWith(
              baseOffset: math.min(truncated.length, truncated.length + 1),
              extentOffset: math.min(truncated.length, truncated.length + 1),
            );
          } else*/ if (value.contains('.') && value.substring(value.indexOf('.') + 1).length > decimalRange) {
            truncated = oldValue.text;
            newSelection = oldValue.selection;
          }
        }

        return TextEditingValue(
          text: truncated,
          selection: newSelection,
          composing: TextRange.empty,
        );
      }
    }
    return newValue;
  }

  bool isNumeric(String value) {
    if(value == null)
      return false;

    return double.parse(value, (e) => null) != null;
  }
}