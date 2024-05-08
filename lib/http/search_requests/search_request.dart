import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:menuapp/http/DTOs/models.dart';
import 'package:menuapp/http/routes.dart';
import 'package:menuapp/utils/secure_storage.dart';

class SubscriptionRequests {
  static Future<SearchResultDto> getSearchResult() async {
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

    return SearchResultDto.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }
}
