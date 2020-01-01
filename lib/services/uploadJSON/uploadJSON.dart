import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:path_provider/path_provider.dart';
import '../../data/homeScreenData/answerData/localDataStorage/localDataStorage.dart';

class Upload {

  Future<int> upload(Map json) async {
    String url = "http://edurti.atspace.cc/upload.php";
    int hasInternetConnection = await checkConnection();
    if (hasInternetConnection == 1) {
      List<String> strings = await prepUpload();
      if (strings != null) {
        for (int i = 0; i < strings.length; i++) {
          print(i);
          Map map = jsonDecode(strings[i]);
          await apiRequest(url, map);
        }
      }
      int responseCode = await apiRequest(url, json);
      return responseCode;
    } else {
      LocalStorage().filePath(json);
      return 20001;
    }
  }

  Future<void> uploadLocal() async {
    String url = "http://edurti.atspace.cc/upload.php";
    int hasInternetConnection = await checkConnection();
    if (hasInternetConnection == 1) {
      List<String> strings = await prepUpload();
      if (strings != null) {
        for (int i = 0; i < strings.length; i++) {
          print(i);
          Map map = jsonDecode(strings[i]);
          await apiRequest(url, map);
        }
      }
    }
  }

  Future<List<String>> prepUpload() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = dir.path + "/ttsh.txt";
    bool exists = await File(path).exists();
    if (exists) {
      File file = File(path);
      String read = await file.readAsString();
      if (read == null || read == "") {
        return null;
      } else {
        List<String> substrings = read.split(';');
        file.writeAsString("");
        return substrings;
      }
    } else {
      return null;
    }
  }

  Future<int> apiRequest(String url, Map jsonMap) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request;
    try {
      request = await httpClient.postUrl(Uri.parse(url)).timeout(const Duration(seconds: 10));
    } on TimeoutException catch (_) {
      LocalStorage().filePath(jsonMap);
      return 3;
    } on SocketException catch (_) {
      LocalStorage().filePath(jsonMap);
      return 5;
    }
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response;
    try {
      response = await request.close().timeout(const Duration(seconds: 5));
    } on TimeoutException catch (_) {
      return 3;
    } on SocketException catch (_) {
      return 5;
    }
    var resp = await response.transform(utf8.decoder).join();
    httpClient.close();
    print(resp);
    int code = response.statusCode;
    if (resp is String && resp == 'NoSuchUserError')
      code = -999;
    return code;
  }

  Future<int> checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return 1;
      }
    } on SocketException catch (_) {
      return 0;
    }
    return 0;
  }
}