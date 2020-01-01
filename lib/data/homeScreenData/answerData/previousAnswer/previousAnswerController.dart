import 'package:flutter/material.dart';

import 'previousAnswer.dart';
import '../answersList.dart';
import '../../textFieldControllers/textFieldControllers.dart';
import '../../questionData/questionsData.dart';
import '../updateAnswersBLoC.dart';

class PreviousAnswerController {
  static PreviousAnswerController _previousAnswerController = PreviousAnswerController._internal();
  factory PreviousAnswerController() => _previousAnswerController;
  PreviousAnswerController._internal();

  static List<dynamic> _currentAnswers;

  Future<void> checkPatientButtonState(var state) async {
    List _list = await PreviousAnswer().getPreviousAnswer();
    if(await PreviousAnswer().getPreviousAnswer() != null) {
      if(state) {
        _currentAnswers = AnswersList.getAllAnswers();
        AnswersList.setAllAnswers(_list);
        for(int i = 0; i < AnswersList.getAllAnswers().length; i++) {
          if(QuestionsList.questionsData[i]['type'] == 'integer'
              || QuestionsList.questionsData[i]['type'] == 'decimal'
              || QuestionsList.questionsData[i]['type'] == 'text') {
            TextEditingController _cont = TextFieldEditingControllers.getController(i);
            if(AnswersList.getAnswer(i) != null)
              _cont.text = AnswersList.getAnswer(i);
            else
              _cont.text = '';
          }
        }
        UpdateAnswersBLoC().updateAnswersSink.add(true);
        AnswersList.setAnswer(10, state);
        _currentAnswers[10] = !state;
      } else {
        AnswersList.setAllAnswers(_currentAnswers);
        for(int i = 0; i < AnswersList.getAllAnswers().length; i++) {
          if(QuestionsList.questionsData[i]['type'] == 'integer'
              || QuestionsList.questionsData[i]['type'] == 'decimal'
              || QuestionsList.questionsData[i]['type'] == 'text') {
            TextEditingController _cont = TextFieldEditingControllers.getController(i);
            if(AnswersList.getAnswer(i) != null)
              _cont.text = AnswersList.getAnswer(i);
            else
              _cont.text = '';
          }
        }
        UpdateAnswersBLoC().updateAnswersSink.add(true);
      }
    }
  }
}