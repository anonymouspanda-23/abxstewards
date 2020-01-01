import 'dart:convert';
import 'dart:io';
import 'dart:async';

class ValidateUser {

  static ValidateUser _instance = ValidateUser._internal();
  ValidateUser._internal();
  factory ValidateUser() {
    return _instance;
  }

  Future<List> apiRequest(String url, Map userCredentials) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request;
    try {
      request = await httpClient.postUrl(Uri.parse(url)).timeout(const Duration(seconds: 10));
    } on TimeoutException catch (_) {
      return [-1, null];
    } on SocketException catch (_) {
      return [-2, null];
    }
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(userCredentials)));
    HttpClientResponse response;
    try {
      response = await request.close().timeout(const Duration(seconds: 5));
    } on TimeoutException catch (_) {
      return [-1, null];
    } on SocketException catch (_) {
      return [-2, null];
    }
    String body = '';
    body = await response.transform(utf8.decoder).join();
    httpClient.close();
    return [response.statusCode, body];
  }

  Future<bool> checkConnection() async{
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }
}