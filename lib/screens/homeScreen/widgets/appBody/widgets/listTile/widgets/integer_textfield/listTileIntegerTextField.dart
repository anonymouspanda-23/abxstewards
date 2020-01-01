import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../../../../../../../data/homeScreenData/questionData/questionsData.dart';
import '../../../../../../../../data/homeScreenData/answerData/answersList.dart';
import 'package:flutter_test_app/data/homeScreenData/textFieldControllers/textFieldControllers.dart';

class ListTileIntegerTextField extends StatefulWidget {
  final int index;
  final minVal;
  final maxVal;

  ListTileIntegerTextField({Key key, @required this.index, @required this.minVal, @required this.maxVal})
    : assert(index != null)
    , super(key: key);

  @override
  State<ListTileIntegerTextField> createState() => ListTileIntegerTextFieldState();
}

class ListTileIntegerTextFieldState extends State<ListTileIntegerTextField> {

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
        keyboardType: TextInputType.number,
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.center,
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter(RegExp('[0-9]')),
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
            setWarningText(true); // check value when disabled and re enabled
          } else {
            setWarningText(checkValueRange());
          }
        },
        controller: TextFieldEditingControllers.getController(widget.index),
      ),
    );
  }

  checkValueRange() {
    if(int.tryParse(AnswersList.getAnswer(widget.index)) < QuestionsList.questionsData[widget.index]['min_value']
        || int.tryParse(AnswersList.getAnswer(widget.index)) > QuestionsList.questionsData[widget.index]['max_value']) {
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