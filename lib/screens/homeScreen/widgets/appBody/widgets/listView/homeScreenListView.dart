import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../widgets/listTile/homeScreenListTile.dart';

import '../../../../../../data/homeScreenData/questionData/questionsData.dart';
import '../../../../../../data/homeScreenData/questionData/listTileData/buttonPressedBLoC/buttonPressedBLoC.dart';

class HomeScreenListView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return new StreamBuilder(
      stream: ButtonPressedBLoC().rebuildListViewStream,
      builder: (context, snapshot) {
        return new ListView.separated(
          itemCount: QuestionsList.questionsData.length,
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 9.0, bottom: 7.0),
          physics: ClampingScrollPhysics(),
          itemBuilder: (context, index) {
              return buildWidget(index);
          },
          separatorBuilder: (context, index) {
              return new Divider();
          },
        );
      },
    );
  }

  Widget buildWidget(int index) {
    return new HomeScreenListTile(
      index: index,
      question: QuestionsList.questionsData[index]['question'],
      description: QuestionsList.questionsData[index]['description'],
      widget: QuestionsList.questionsData[index]['type'],
      minVal: QuestionsList.questionsData[index].containsKey('min_value') ? QuestionsList.questionsData[index]['min_value'] : null,
      maxVal: QuestionsList.questionsData[index].containsKey('max_value') ? QuestionsList.questionsData[index]['max_value'] : null,
      placeholder: QuestionsList.questionsData[index].containsKey('placeholder') ? QuestionsList.questionsData[index]['placeholder'] : null,
    );
  }
}