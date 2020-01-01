import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PopUpNotification {

  popup(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: new Text('Admin Contact Info'),
          content: new  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new GestureDetector(
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Text('Email: '),
                    new SelectableText('weixiang_lian@ttsh.com.sg'),
                  ],
                )
              )
            ],
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Dismiss'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}