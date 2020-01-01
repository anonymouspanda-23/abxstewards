import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../../services/validateUser/validateUser.dart';

class UserCredentials {

  static UserCredentials _instance = UserCredentials._internal();
  UserCredentials._internal();
  factory UserCredentials() {
    return _instance;
  }

  final String url = 'http://edurti.atspace.cc/authUser.php';

  ValidateUser _validateUser = new ValidateUser();

  Map<String, String> userCredentials = {
    'username': '',
    'password': '',
  };

  getUsername() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = dir.path + "/userInfo.txt";
    File file = File(path);
    String credentials = await file.readAsString();
    List info = credentials.split(',');
    return info[0].toString();
  }

  deleteUser() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = dir.path + "/userInfo.txt";
    File file = File(path);
    file.delete();
  }

  List<String> getUserCredentials() {
    return [userCredentials['username'], userCredentials['password']];
  }

  Future<int> checkUserCredentials() async {
    bool hasNetwork = await _validateUser.checkConnection();
    if(hasNetwork) {
      List response;
      response = await _validateUser.apiRequest(url, userCredentials);
      if(response[0] < 0) {
        return response[0];
      } else if(response[0] == 200) {
        if(json.decode(response[1])['response'] == 'valid') {
          return 1;
        } else {
          return 2;
        }
      } else {
        return 3;
      }
    } else {
      return 0;
    }
  }
}