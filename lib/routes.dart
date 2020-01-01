import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import './screens/loginScreen/loginScreen.dart';
import './screens/homeScreen/homeScreen.dart';
import 'data/homeScreenData/answerData/answersList.dart';
import 'data/homeScreenData/textFieldControllers/textFieldControllers.dart';

class Routes {
  final routes = <String, WidgetBuilder> {
    '/loginScreen': (BuildContext context) => new LoginScreen(),
    '/edurtiScreen': (BuildContext context) => new HomeScreen(),
  };

  Routes() {
    startApp();
  }

  startApp() async {
    AnswersList.initList();
    TextFieldEditingControllers.initList();
    bool loggedIn = await checkFileExists();
    runApp(new MaterialApp(
      title: 'Edurti App',
      routes: routes,
      theme: new ThemeData.light(),
      home: loggedIn ? new HomeScreen() : new LoginScreen(),
      debugShowCheckedModeBanner: false,
    ));
  }

  Future<bool> checkFileExists() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = dir.path + "/userInfo.txt";
    bool exists = await File(path).exists();
    return exists;
  }
}