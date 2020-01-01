import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../../homeScreenData/questionData/questionsData.dart';
import '../textFieldControllers/textFieldControllers.dart';
import '../questionData/listTileData/buttonPressedBLoC/buttonPressedBLoC.dart';
import 'previousAnswer/previousAnswer.dart';

class AnswersList {
  static final AnswersList _answersList = AnswersList._internal();
  factory AnswersList() {
    return _answersList;
  }
  AnswersList._internal();

  static List _answers = [];
  static bool prescribedAntibiotics = false;

  static initAnswers(int index) {
    if(QuestionsList.questionsData[index]['autofill'] == false)
      return null;
    return QuestionsList.questionsData[index]['autofill_value'];
  }

  static initList() {
    for(int index = 0; index < QuestionsList.questionsData.length - 1; index++)
      _answers.add(QuestionsList.questionsData[index]['autofill_value']);
  }

  static resetList() {
    for(int index = 0; index < QuestionsList.questionsData.length - 1; index++) {
      _answers.removeAt(index);
      _answers.insert(index, QuestionsList.questionsData[index]['autofill_value']);
      TextFieldEditingControllers.resetController(index);
      if(QuestionsList.questionsData[index]['child_showing'] != null)
        QuestionsList.questionsData[index]['child_showing'] = _answers.elementAt(index);
    }

    ButtonPressedBLoC().buttonPressedSink.add('String');
  }

  static setAnswer(int index, dynamic value) {
    _answers.removeAt(index);
    _answers.insert(index, value);
  }

  static getAnswer(int index) {
    return _answers.elementAt(index);
  }

  static getAnswersLength() {
    return _answers.length;
  }

  savePreviousAnswers() async {
    PreviousAnswer().setPreviousAnswer(_answers); // save to file
    Directory appDir = await getApplicationDocumentsDirectory();
    String path = appDir.path + '/previousAnswer.txt';
    File _file = File(path);
    await _file.writeAsString(_answers.toString());
  }

  static getAllAnswers() {
    return _answers;
  }

  static setAllAnswers(List answers) {
    _answers = answers;
  }
}