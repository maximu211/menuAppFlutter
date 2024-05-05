import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:menuapp/http/result.dart';
import 'package:menuapp/http/routes.dart';

class UserRequest {
  static Future<ServiceResult> _sendRequest(String route, Map<String, dynamic> data) async {
    StringBuffer url = StringBuffer();
    url.write(BaseRoutes.baseUrl);
    url.write(BaseRoutes.user);
    url.write(route);

    final body = jsonEncode(data);

    final response = await http.post(
      Uri.parse(url.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return ServiceResult.fromJson(jsonData);
    } else {
      return ServiceResult(
        success: false,
        message: 'Failed to send data: ${response.statusCode}',
      );
    }
  }

  static Future<ServiceResult> logIn(String username, String password) async {
    return _sendRequest(UserRoutes.logIn, {'username': username, 'password': password});
  }

  static Future<ServiceResult> logOut(String token) async {
    return _sendRequest(UserRoutes.logOut, {'token': token});
  }

  static Future<ServiceResult> refreshToken(String refreshToken) async {
    return _sendRequest(UserRoutes.refreshToken, {'refreshToken': refreshToken});
  }
}
