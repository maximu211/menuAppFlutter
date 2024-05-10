import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:menuapp/http/DTOs/DTOs.dart';
import 'package:menuapp/http/routes.dart';
import 'package:menuapp/utils/secure_storage.dart';

class SubscriptionRequests {
  static Future<SearchResultDto> getSearchResult(String query) async {
    final StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(BaseRoutes.baseUrl);
    stringBuffer.write(BaseRoutes.search);
    stringBuffer.write(SearchRoutes.search);
    stringBuffer.write("/$query");

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
