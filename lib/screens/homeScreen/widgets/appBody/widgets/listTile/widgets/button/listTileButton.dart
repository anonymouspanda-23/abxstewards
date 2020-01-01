import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../../../../data/homeScreenData/questionData/questionsData.dart';
import '../../../../../../../../data/homeScreenData/answerData/answersList.dart';
import '../../../../../../../../data/homeScreenData/answerData/updateAnswersBLoC.dart';
import '../../../../../../../../data/homeScreenData/answerData/previousAnswer/previousAnswerController.dart';

class ListTileButton extends StatefulWidget {

  final int index;
  ListTileButton ({Key key, @required this.index})
    : assert(index != null)
    , super(key: key);

  @override
  State<ListTileButton> createState() => ListTileButtonState();
}

class ListTileButtonState extends State<ListTileButton> {

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: UpdateAnswersBLoC().updateAnswersStream,
      builder: (context, snapshot) {
        return new Container(
          width: 150,
          child: new FlatButton(
            child: new Text(
              getButtonText(AnswersList.getAnswer(widget.index), widget.index),
              style: new TextStyle(
                color: getTextColour(AnswersList.getAnswer(widget.index)),
              ),
            ),
            color: getButtonColour(AnswersList.getAnswer(widget.index)),
            onPressed: () {
              _updateButtonState();
            },
          ),
        );
      },
    );
  }

  void _updateButtonState() async {
    AnswersList.setAnswer(widget.index, !AnswersList.getAnswer(widget.index));
    if(widget.index == 10) {
      await PreviousAnswerController().checkPatientButtonState(AnswersList.getAnswer(widget.index));
    }
    setState(() {});
  }

  String getButtonText(bool isTrue, int index) {
    return QuestionsList.questionsData[index][isTrue];
  }

  Color getTextColour(bool isTrue) {
    if(isTrue)
      return Color(0xffffffff);
    else return Color(0xff6e6e6e);
  }

  Color getButtonColour(bool isTrue) {
    if(isTrue)
      return Color(0xffa83c31);
    else return Color(0xffe2e2e2);
  }
}