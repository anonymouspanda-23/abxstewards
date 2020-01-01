import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'widgets/button/listTileButton.dart';
import 'widgets/decimal_textfield/listTileDecimalTextField.dart';
import 'widgets/dropdown/listTileDropdownMenu.dart';
import 'widgets/integer_textfield/listTileIntegerTextField.dart';
import 'widgets/text/listTileTextField.dart';
import 'widgets/submitButton/listTileSubmitButton.dart';
import '../messageDialog/messageDialog.dart';

class HomeScreenListTile extends StatelessWidget {

  final int index;
  final String question;
  final String description;
  final String widget;
  final String placeholder;
  final minVal;
  final maxVal;
  static BuildContext buildContext;

  HomeScreenListTile({Key key, @required this.index, @required this.question, this.description, @required this.widget,
  @required this.minVal, @required this.maxVal, @required this.placeholder})
    : assert(index != null, question != null)
    , super(key: key);

  @override
  Widget build(BuildContext context) {
    return getTileType(widget, context);
  }

  Widget getTileType(String widgetType, BuildContext context) {
    buildContext = context;
    if(widgetType == 'submit') {
      return getTrailingWidget(widgetType);
    } else if (widgetType == 'text') {
      return ListTile(
        dense: true,
        title: new Row(
          children: <Widget>[
            new Text(question, style: TextStyle(fontSize: 14)),
            new IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: showPatientInfo
            )
          ]
        ),
        subtitle: getDescription(description),
        trailing: getTrailingWidget(widgetType),
      );
    } else {
      return new ListTile(
        dense: true,
        title: new Text(question, style: TextStyle(fontSize: 14)),
        subtitle: getDescription(description),
        trailing: getTrailingWidget(widgetType),
      );
    }
  }

  showPatientInfo() {
    MessageDialog().build(buildContext, 'Patient initials', "Please provide the first alphabet of each word in the patient's name");
  }

  Widget getDescription(String questionDescription) {
    if(questionDescription == null)
      return null;
    return new Text(questionDescription, style: TextStyle(fontSize: 12));
  }

  Widget getTrailingWidget(String widgetType) {
    Map widgetsList = {
      'binary': ListTileButton(index: index),
      'dropdown': ListTileDropDownMenu(index: index),
      'integer': ListTileIntegerTextField(index: index, minVal: minVal, maxVal: maxVal),
      'decimal': ListTileDecimalTextField(index: index, minVal: minVal, maxVal: maxVal),
      'text': ListTileTextField(index: index, placeholder: placeholder),
      'submit': ListTileSubmitButton(),
    };

    return widgetsList[widgetType];
  }
}