import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class LocalStorage {
  String path;

  void filePath(Map map) async {
    final dir = await getApplicationDocumentsDirectory();
    final path = dir.path + "/ttsh.txt";
    bool exists = await File(path).exists();
    if (exists) {
      File file = File(path);
      String read = await file.readAsString();
      if (read == null || read == "") {
        String write = jsonEncode(map);
        file.writeAsString(write);
      } else {
        String write = read + ";" + jsonEncode(map);
        file.writeAsString(write);
      }
    } else {
      File file = File(path);
      String write = jsonEncode(map);
      file.writeAsString(write);
    }
  }
}