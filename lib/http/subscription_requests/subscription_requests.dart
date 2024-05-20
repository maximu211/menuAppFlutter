import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:menuapp/http/DTOs/dtos.dart';
import 'package:menuapp/http/DTOs/result.dart';
import 'package:menuapp/http/routes.dart';
import 'package:menuapp/utils/secure_storage.dart';

class SubscriptionRequests {
  static Future<ServiceResult> subscribeTo(String userId) async {
    final StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(BaseRoutes.baseUrl);
    stringBuffer.write(BaseRoutes.subscription);
    stringBuffer.write(SubscriptionRoutes.subscribeTo);
    stringBuffer.write("/$userId");

    final String? accessToken =
        await SecureStorage().storage.read(key: "AccessToken");

    final response = await http.post(
      Uri.parse(stringBuffer.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
    );

    return ServiceResult.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }

  static Future<ServiceResult> unsubscribeFrom(String userId) async {
    final StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(BaseRoutes.baseUrl);
    stringBuffer.write(BaseRoutes.subscription);
    stringBuffer.write(SubscriptionRoutes.unsubscribeFrom);
    stringBuffer.write("/$userId");

    final String? accessToken =
        await SecureStorage().storage.read(key: "AccessToken");

    final response = await http.post(
      Uri.parse(stringBuffer.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
    );

    return ServiceResult.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }

  static Future<UserDto> getSubscribers(String userId) async {
    final StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(BaseRoutes.baseUrl);
    stringBuffer.write(BaseRoutes.subscription);
    stringBuffer.write(SubscriptionRoutes.getSubscribers);
    stringBuffer.write("/$userId");

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

  static Future<UserDto> getSubsribedUsers(String userId) async {
    final StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(BaseRoutes.baseUrl);
    stringBuffer.write(BaseRoutes.subscription);
    stringBuffer.write(SubscriptionRoutes.getSbuscribedUsers);
    stringBuffer.write("/$userId");

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
