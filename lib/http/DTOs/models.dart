import 'package:flutter/services.dart';
import 'package:menuapp/http/DTOs/result.dart';
import 'package:http/http.dart' as http;

class BinaryFileReader {
  final String filePath;

  BinaryFileReader(this.filePath);

  Future<Uint8List> readBinaryFile() async {
    final ByteData data = await rootBundle.load(filePath);

    return data.buffer.asUint8List();
  }
}

class UserModel {
  UserModel(
      {required this.userName, required this.userPhoto, required this.userId});

  Uint8List userPhoto;
  String userName;
  String userId;
}

class CardRecipeModel {
  CardRecipeModel({
    required this.recipePhoto,
    required this.recipeId,
    required this.user,
    required this.name,
    required this.cookingDifficulty,
    required this.cookingTime,
    required this.recipeType,
    required this.isRecipeSaved,
    required this.likesCount,
    required this.isRecipeLiked,
  });

  Uint8List recipePhoto;
  String recipeId;
  UserModel user;
  String name;
  CookingDifficulty cookingDifficulty;
  CookingTime cookingTime;
  String recipeType;
  bool isRecipeSaved;
  bool isRecipeLiked;
  int likesCount;
}

class CommentModel {
  CommentModel(
      {required this.commentText,
      required this.commentDateTime,
      required this.user});

  UserModel user;
  String commentText;
  DateTime commentDateTime;
}

class RecipeDetailModel {
  RecipeDetailModel(
      {required this.recipeDescriptionElements,
      required this.recipeIngradient});

  List<String> recipeIngradient;
  List<RecipeDescriptionElement> recipeDescriptionElements;
}

class RecipeDescriptionElement {
  RecipeDescriptionElement(
      {required this.recipeDescriptionElementText,
      this.recipeDescriptionPhoto});

  String recipeDescriptionElementText;
  Uint8List? recipeDescriptionPhoto;
}

enum CookingDifficulty {
  easy,
  medium,
  hard,
  veryHard,
}

enum CookingTime {
  lessThan15min,
  min15,
  min30,
  min45,
  hour1,
  moreThanHour1,
}

class TokenFetchResult extends ServiceResult {
  TokenFetchResult(
      {required this.accessToken,
      required this.refreshToken,
      required super.success,
      required super.message});

  String accessToken;
  String refreshToken;

  factory TokenFetchResult.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'accessToken': String accessToken,
        'refreshToken': String refreshToken,
        'success': bool success,
        'message': String message
      } =>
        TokenFetchResult(
            accessToken: accessToken,
            refreshToken: refreshToken,
            success: success,
            message: message),
      _ => throw const FormatException(),
    };
  }
}
