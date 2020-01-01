import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../../../../data/homeScreenData/questionData/questionsData.dart';
import '../../../../../../../../data/homeScreenData/answerData/answersList.dart';
import '../../../../../../../../data/homeScreenData/answerData/updateAnswersBLoC.dart';

class ListTileDropDownMenu extends StatefulWidget {

  final int index;
  ListTileDropDownMenu ({Key key, @required this.index})
    : assert(index != null)
    , super(key: key);

  @override
  State<ListTileDropDownMenu> createState() => ListTileDropDownMenuState();
}

class ListTileDropDownMenuState extends State<ListTileDropDownMenu> {

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: UpdateAnswersBLoC().updateAnswersStream,
      builder: (context, snapshot) {
        return new Container(
          width: 150,
          child: new DropdownButton(
            isExpanded: true,
            value: AnswersList.getAnswer(widget.index),
            hint: new Text(QuestionsList.questionsData[widget.index]['hintText']),
            onChanged: (newValue) {
              AnswersList.setAnswer(widget.index, newValue);
              setState(() {});
            },
            items: getItems(),
          ),
        );
      },
    );
  }

  List<DropdownMenuItem<String>> getItems() {
    List<String> options = new List();
    for(String item in QuestionsList.questionsData[widget.index]['options']) {
      options.add(item.toString());
    }
    return options.map((months) {
      return DropdownMenuItem(
        child: new Text(
          months,
          style: new TextStyle(
            color: Color(0xff6e6e6e),
          ),
        ),
        value: months,
      );
    }).toList();
  }
}