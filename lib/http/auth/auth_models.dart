import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:menuapp/http/result.dart';

class UserRequest {
  static Future<ServiceResult> sendDataToBackend(
      String username, String password) async {
    String url = 'https://10.0.2.2:5001/api/User/log_in';
    final body = jsonEncode({'username': username, 'password': password});

    final response = await http.post(
      Uri.parse(url),
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
}
