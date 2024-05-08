import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:menuapp/http/DTOs/models.dart';
import 'package:menuapp/http/DTOs/result.dart';
import 'package:menuapp/http/routes.dart';
import 'package:menuapp/utils/secure_storage.dart';

class SubscriptionRequests {
  static Future<ServiceResult> subscribeTo(String userId) async {
    final StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(BaseRoutes.baseUrl);
    stringBuffer.write(BaseRoutes.subscription);
    stringBuffer.write(SubscriptionRoutes.subscribeTo);

    final String? accessToken =
        await SecureStorage().storage.read(key: "AccessToken");

    final response = await http.post(
      Uri.parse(stringBuffer.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(<String, String>{'id': userId}),
    );

    return ServiceResult.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }

  static Future<ServiceResult> unsubscribeFrom(String userId) async {
    final StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(BaseRoutes.baseUrl);
    stringBuffer.write(BaseRoutes.subscription);
    stringBuffer.write(SubscriptionRoutes.subscribeTo);

    final String? accessToken =
        await SecureStorage().storage.read(key: "AccessToken");

    final response = await http.post(
      Uri.parse(stringBuffer.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(<String, String>{'id': userId}),
    );

    return ServiceResult.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }

  static Future<UserDto> getSubscribers() async {
    final StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(BaseRoutes.baseUrl);
    stringBuffer.write(BaseRoutes.subscription);
    stringBuffer.write(SubscriptionRoutes.getSubscribers);

    final String? accessToken =
        await SecureStorage().storage.read(key: "AccessToken");

    final response = await http.get(
      Uri.parse(stringBuffer.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
    );

    return UserDto.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  static Future<UserDto> getSubsribedUsers() async {
    final StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(BaseRoutes.baseUrl);
    stringBuffer.write(BaseRoutes.subscription);
    stringBuffer.write(SubscriptionRoutes.getSbuscribedUsers);

    final String? accessToken =
        await SecureStorage().storage.read(key: "AccessToken");

    final response = await http.get(
      Uri.parse(stringBuffer.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
    );

    return UserDto.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }
}
