import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../../../../../../../data/homeScreenData/questionData/questionsData.dart';
import '../../../../../../../../data/homeScreenData/answerData/answersList.dart';
import '../../../../../../../../data/homeScreenData/textFieldControllers/textFieldControllers.dart';
import '../../../../../../../../data/homeScreenData/textFieldInputFormatters/decimalTextFieldInputFormatter.dart';

class ListTileDecimalTextField extends StatefulWidget {
  final int index;
  final minVal;
  final maxVal;

  ListTileDecimalTextField({Key key, @required this.index, @required this.minVal, @required this.maxVal})
    : assert(index != null)
    , super(key: key);

  @override
  State<ListTileDecimalTextField> createState() => ListTileDecimalTextFieldState();
}

class ListTileDecimalTextFieldState extends State<ListTileDecimalTextField> {

  String warningText = '';

  @override
  Widget build(BuildContext context) {
    if(AnswersList.getAnswer(widget.index) != null)
      setWarningText(checkValueRange());
    return new Container(
      width: 150,
      child: new TextField(
        autocorrect: false,
        style: new TextStyle(
          color: Color(0xffa83c31),
        ),
        maxLength: QuestionsList.questionsData[widget.index]['max_length'],
        maxLines: 1,
        textCapitalization: TextCapitalization.none,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.center,
        inputFormatters: <TextInputFormatter>[
          DecimalTextInputFormatter(decimalRange: 1, index: widget.index),
          //WhitelistingTextInputFormatter(RegExp('^[0-9]{0,2}\.[0.9]{0,1}')),
        ],
        decoration: InputDecoration(
          counterText: warningText,
          counterStyle: new TextStyle(
            color: Colors.red,
          ),
          hintText: widget.minVal.toString() + ' to ' + widget.maxVal.toString(),
        ),
        onChanged: (newValue) {
          if(newValue.isEmpty)
            newValue = null;
          AnswersList.setAnswer(widget.index, newValue);
          if(AnswersList.getAnswer(widget.index) == null) {
            setWarningText(true);
          } else {
            setWarningText(checkValueRange());
          }
        },
        controller: TextFieldEditingControllers.getController(widget.index),
      ),
    );
  }

  checkValueRange() {
    if(double.tryParse(AnswersList.getAnswer(widget.index)) < QuestionsList.questionsData[widget.index]['min_value']
        || double.tryParse(AnswersList.getAnswer(widget.index)) > QuestionsList.questionsData[widget.index]['max_value']) {
      return false;
    } else {
      return true;
    }
  }

  setWarningText(bool inRange) {
    if(inRange)
      warningText = '';
    else warningText = QuestionsList.questionsData[widget.index]['warning'].toString();
    setState(() {});
  }
}