import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:menuapp/http/DTOs/models.dart';
import 'package:menuapp/http/DTOs/result.dart';
import 'package:menuapp/http/routes.dart';
import 'package:menuapp/utils/secure_storage.dart';

class UserRequest {
  static Future<TokenFetchResult> logIn(
      String password, String username) async {
    final StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(BaseRoutes.baseUrl);
    stringBuffer.write(BaseRoutes.user);
    stringBuffer.write(UserRoutes.logIn);

    final response = await http.post(
      Uri.parse(stringBuffer.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'password': password, 'username': username}),
    );

    if (response.statusCode == 200) {
      return TokenFetchResult.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception();
    }
  }

  static Future<ServiceResult> logOut() async {
    final StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(BaseRoutes.baseUrl);
    stringBuffer.write(BaseRoutes.user);
    stringBuffer.write(UserRoutes.logOut);

    final String? accessToken =
        await SecureStorage().storage.read(key: "accessToken");

    final response = await http.post(
      Uri.parse(stringBuffer.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      return TokenFetchResult.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception();
    }
  }

  static Future<TokenFetchResult> refreshToken(String refreshToken) async {
    final StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(BaseRoutes.baseUrl);
    stringBuffer.write(BaseRoutes.user);
    stringBuffer.write(UserRoutes.refreshToken);

    final response = await http.post(
      Uri.parse(stringBuffer.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'refreshToken': refreshToken,
      }),
    );

    if (response.statusCode == 200) {
      return TokenFetchResult.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception();
    }
  }
}
