import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:menuapp/http/DTOs/DTOs.dart';
import 'package:menuapp/http/DTOs/result.dart';
import 'package:menuapp/http/routes.dart';
import 'package:menuapp/utils/secure_storage.dart';

class CommentRequests {
  static Future<ServiceResult> leaveComment(
      String recipeId, String comment) async {
    final StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(BaseRoutes.baseUrl);
    stringBuffer.write(BaseRoutes.comment);
    stringBuffer.write(CommentRoutes.leaveComment);
    stringBuffer.write("/$recipeId");

    final String? accessToken =
        await SecureStorage().storage.read(key: "AccessToken");

    final response = await http.post(
      Uri.parse(stringBuffer.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(comment),
    );

    return ServiceResult.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }

  static Future<CommentModelDto> getCommentsByRecipeId(String recipeId) async {
    final StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(BaseRoutes.baseUrl);
    stringBuffer.write(BaseRoutes.comment);
    stringBuffer.write(CommentRoutes.getCommentsByRecipeId);
    stringBuffer.write("/$recipeId");

    final String? accessToken =
        await SecureStorage().storage.read(key: "AccessToken");

    final response = await http.get(
      Uri.parse(stringBuffer.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
    );

    return CommentModelDto.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }

  static Future<ServiceResult> deleteComment(String commentId) async {
    final StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(BaseRoutes.baseUrl);
    stringBuffer.write(BaseRoutes.comment);
    stringBuffer.write(CommentRoutes.deleteComment);
    stringBuffer.write("/$commentId");

    final String? accessToken =
        await SecureStorage().storage.read(key: "AccessToken");

    final response = await http.delete(
      Uri.parse(stringBuffer.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
    );

    return ServiceResult.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }

  static Future<ServiceResult> updateComment(
      String commentId, String commentText) async {
    final StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(BaseRoutes.baseUrl);
    stringBuffer.write(BaseRoutes.comment);
    stringBuffer.write(CommentRoutes.updateComment);
    stringBuffer.write("/$commentId");

    final String? accessToken =
        await SecureStorage().storage.read(key: "AccessToken");

    final response = await http.patch(
      Uri.parse(stringBuffer.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(commentText),
    );

    return ServiceResult.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }
}
