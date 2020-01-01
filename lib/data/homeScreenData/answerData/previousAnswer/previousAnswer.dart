import 'dart:io';

import 'package:path_provider/path_provider.dart';

class PreviousAnswer {
  static PreviousAnswer _previousAnswer = PreviousAnswer._internal();
  factory PreviousAnswer() => _previousAnswer;
  PreviousAnswer._internal();

  static List _previousAnswersList;

  void setPreviousAnswer(List answer) {
    _previousAnswersList = answer;
  }

  clearPreviousAnswer() async {
    Directory _appDir = await getApplicationDocumentsDirectory();
    String path = _appDir.path + '/previousAnswer.txt';
    File _file = File(path);
    _file.delete();
  }

  Future<List> getPreviousAnswer() async {
    Directory _appDir = await getApplicationDocumentsDirectory();
    String path = _appDir.path + '/previousAnswer.txt';
    File _file = File(path);
    if(await _file.exists()) {
      String contents = await _file.readAsString();
      contents = contents.replaceAll('[', '');
      contents = contents.replaceAll(']', '');
      List _list = contents.split(', ');
      List<dynamic> _answer = List.generate(_list.length, (index) {
        if(_list[index] == 'true' || _list[index] == 'false')
          return _list[index] == 'true';
        else
          return _list[index];
      }, growable: true);
      return _answer;
    } else {
      return _previousAnswersList;
    }
  }
}