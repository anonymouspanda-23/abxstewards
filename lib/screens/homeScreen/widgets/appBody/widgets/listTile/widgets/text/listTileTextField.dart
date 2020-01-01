import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../../../../../../../data/homeScreenData/questionData/questionsData.dart';
import '../../../../../../../../data/homeScreenData/answerData/answersList.dart';
import '../../../../../../../../data/homeScreenData/textFieldControllers/textFieldControllers.dart';

class ListTileTextField extends StatelessWidget {

  final int index;
  final String placeholder;
  ListTileTextField({Key key, @required this.index, @required this.placeholder})
    : assert(index != null)
    , super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: 150,
      child: new TextField(
        autocorrect: false,
        style: new TextStyle(
          color: Color(0xffa83c31),
        ),
        maxLength: QuestionsList.questionsData[index]['max_length'],
        maxLines: 1,
        textCapitalization: TextCapitalization.characters,
        keyboardType: TextInputType.text,
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.center,
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter(RegExp('[a-zA-Z]')),
        ],
        decoration: InputDecoration(
          counterText: '',
          hintText: placeholder.toString()
        ),
        onChanged: (newValue) {
          if(newValue.isEmpty)
            newValue = null;
          AnswersList.setAnswer(index, newValue);
        },
        controller: TextFieldEditingControllers.getController(index),
      ),
    );
  }
}