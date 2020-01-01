import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../../data/homeScreenData/answerData/answersList.dart';

class MessageDialog {

  build(BuildContext context, String title, String message) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: new Text(title),
          content: new Text(message), // add question and toggle button
          actions: buildSelector(context, false),
        );
      },
    );
  }

  showInfo(BuildContext context, String title_1, String message_1, String title_2, String message_2, options) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(4.0),
                width: MediaQuery.of(context).size.width,
                child: new Text(
                  title_1,
                  style: TextStyle(color: Colors.white),
                ),
                color: new Color(0xffa81c31),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                child: new Text(message_1))
              ,
              Container(
                padding: EdgeInsets.all(4.0),
                width: MediaQuery.of(context).size.width,
                child: new Text(
                  title_2,
                  style: TextStyle(color: Colors.white),
                ),
                color: new Color(0xffa81c31),
              ),
              Container(
                  padding: EdgeInsets.all(8.0),
                  child: new Text(message_2)
              ),
            ],
          ),
          actions: buildSelector(context, options),
        );
      }
    );
  }

  showResult(BuildContext context, String title_1, Widget message_1, String title_2, String message_2, options) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            content: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(4.0),
                  width: MediaQuery.of(context).size.width,
                  child: new Text(
                    title_1,
                    style: TextStyle(color: Colors.white),
                  ),
                  color: new Color(0xffa81c31),
                ),
                Container(
                    padding: EdgeInsets.all(8.0),
                    child: message_1)
                ,
                Container(
                  padding: EdgeInsets.all(4.0),
                  width: MediaQuery.of(context).size.width,
                  child: new Text(
                    title_2,
                    style: TextStyle(color: Colors.white),
                  ),
                  color: new Color(0xffa81c31),
                ),
                Container(
                    padding: EdgeInsets.all(8.0),
                    child: new Text(message_2)
                ),
              ],
            ),
            actions: buildSelector(context, options),
          );
        }
    );
  }

  showFinalDecision(BuildContext context, String title, String message, bool showSelector) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: new Text(title),
          content: new Text(message), // add question and toggle button
          actions: buildSelector(context, showSelector),
        );
      },
    );
  }

  buildSelector(BuildContext context, bool showSelector) {
    if(showSelector) {
      return <Widget>[
        new FlatButton(
          child: new Text('No'),
          onPressed: () {
            AnswersList.prescribedAntibiotics = false;
            Navigator.of(context).pop();
          },
        ),
        new FlatButton(
          child: new Text('Yes'),
          onPressed: () {
            AnswersList.prescribedAntibiotics = true;
            Navigator.of(context).pop();
          },
        ),
      ];
    } else {
      return <Widget>[
        new FlatButton(
          child: new Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ];
    }
  }
}