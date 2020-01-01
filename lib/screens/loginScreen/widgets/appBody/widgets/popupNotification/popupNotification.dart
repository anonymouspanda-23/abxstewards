import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PopUpNotification {

  popup(BuildContext context, String text, int code) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: code == 1 ? new Text("Success") : new Text("Error"),
          content: new Text(text),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                  "Dismiss",
                style: new TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.normal,
                ),
              ),
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