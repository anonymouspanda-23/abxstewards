import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../../data/loginScreenData/userInfo.dart';
import '../popupNotification/popupNotification.dart';

class LoginButton extends StatefulWidget {
  @override
  State<LoginButton> createState() => LoginButtonState();
}

class LoginButtonState extends State<LoginButton> {

  static final UserCredentials _credentials = new UserCredentials();
  static final PopUpNotification _notification = new PopUpNotification();
  static bool loggingIn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: getButtonFunction(loggingIn),
        padding: EdgeInsets.all(12),
        color: Color(0xffa81c31),
        child: Text(getLoginButtonValue(loggingIn), style: TextStyle(color: Colors.white)), // add loading style here
      ),
    );
  }

  getButtonFunction(bool signIn) {
    if(signIn) {
      return null;
    }
    return () async {
      logIn();
      List credentials = _credentials.getUserCredentials();
      if(credentials[0] == '' && credentials[1] == '') {
        stopLogIn();
        _notification.popup(context, "Fields cannot be empty!", 0);
      } else if(credentials[0] == '') {
        stopLogIn();
        _notification.popup(context, "Username cannot be empty!", 0);
      } else if(credentials[1] == '') {
        stopLogIn();
        _notification.popup(context, "Password cannot be empty!", 0);
      } else {
        int response = await _credentials.checkUserCredentials();
        switch (response) {
          case -2: // add function on atspace to check if logout is user or admin
            stopLogIn();
            _notification.popup(context, "Socket Exception", response);
            break;
          case -1:
            stopLogIn();
            _notification.popup(context, "Timeout Exception", response);
            break;
          case 0:
            stopLogIn();
            _notification.popup(context, "You are offline!", response);
            break;
          case 1:
            stopLogIn();
            saveUser(credentials[0], credentials[1]);
            Navigator.pushReplacementNamed(context, '/edurtiScreen');
            break;
          case 2:
            stopLogIn();
            _notification.popup(context, "Invalid credentials", response);
            break;
          default:
            stopLogIn();
            _notification.popup(context, "An unknown error has occured", response);
        }
      }
    };
  }

  logIn() {
    loggingIn = true;
    setState(() {});
  }

  stopLogIn() {
    loggingIn = false;
    setState(() {});
  }

  String getLoginButtonValue(bool signIn) {
    if(signIn)
      return 'Logging In...';
    return 'Log In';
  }

  void saveUser(String username, String password) async {
    final dir = await getApplicationDocumentsDirectory();
    final path = dir.path + "/userInfo.txt";
    File file = File(path);
    String write = username + "," + password;
    file.writeAsString(write);
  }
}