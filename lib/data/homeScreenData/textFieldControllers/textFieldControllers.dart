import 'package:flutter/cupertino.dart';

import '../../homeScreenData/questionData/questionsData.dart';

class TextFieldEditingControllers {
  static List textFieldControllers = [];

  static initList() {
    for(int index = 0; index < QuestionsList.questionsData.length - 1; index++)
      textFieldControllers.add(TextEditingController());
  }

  static getController(int index) {
    return textFieldControllers.elementAt(index);
  }

  static resetController(int index) {
    TextEditingController _controller = textFieldControllers.elementAt(index);
    _controller.clear();
  }
}