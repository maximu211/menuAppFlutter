import 'package:flutter/services.dart';

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

class cardRecipeModel {
  cardRecipeModel({
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
      {required this.RecipeDescriptionElements,
      required this.recipeIngradient});

  List<String> recipeIngradient;
  List<RecipeDescriptionElement> RecipeDescriptionElements;
}

class RecipeDescriptionElement {
  RecipeDescriptionElement(
      {required this.RecipeDescriptionElementText,
      this.recipeDescriptionPhoto});

  String RecipeDescriptionElementText;
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
