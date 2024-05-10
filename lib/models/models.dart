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
  final String userName;
  final Uint8List userImage;
  final String userId;

  UserModel({
    required this.userName,
    required this.userImage,
    required this.userId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userName: json['username'],
      userImage: json['image'],
      userId: json['id'],
    );
  }
}

class CardRecipeModel {
  String id;
  Uint8List recipeImage;
  String recipeId;
  UserModel user;
  String name;
  CookingDifficulty cookingDifficulty;
  CookingTime cookingTime;
  String recipeType;
  bool isRecipeSaved;
  bool isRecipeLiked;
  int likesCount;
  bool isOwner;

  CardRecipeModel(
      {required this.recipeImage,
      required this.recipeId,
      required this.user,
      required this.name,
      required this.cookingDifficulty,
      required this.cookingTime,
      required this.recipeType,
      required this.isRecipeSaved,
      required this.likesCount,
      required this.isRecipeLiked,
      required this.isOwner,
      required this.id});

  factory CardRecipeModel.fromJson(Map<String, dynamic> json) {
    return CardRecipeModel(
      id: json['id'],
      recipeImage: json['recipeImage'],
      recipeId: json['recipeId'],
      user: UserModel.fromJson(json['user']),
      name: json['name'],
      cookingDifficulty: json['cookingDifficulty'],
      cookingTime: json['cookingTime'],
      recipeType: json['recipeType'],
      isRecipeSaved: json['isRecipeSaved'],
      isRecipeLiked: json['isRecipeLiked'],
      likesCount: json['likesCount'],
      isOwner: json['isOwner'],
    );
  }
}

class CommentModel {
  CommentModel(
      {required this.id,
      required this.commentText,
      required this.commentDateTime,
      required this.user,
      required this.isOwner});

  UserModel user;
  String id;
  String commentText;
  DateTime commentDateTime;
  bool isOwner;

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
        commentDateTime: json['createdAt'],
        commentText: json['comment'],
        user: UserModel.fromJson(json['user']),
        isOwner: json['isOwner'],
        id: json['id']);
  }
}

class RecipeDescriptionElements {
  RecipeDescriptionElements(
      {required this.recipeDescriptionElements,
      required this.recipeIngradient});

  List<String> recipeIngradient;
  List<RecipeDescriptionElement> recipeDescriptionElements;
}

class RecipeDescriptionElement {
  RecipeDescriptionElement(
      {required this.recipeDescriptionElementText,
      this.recipeDescriptionImage});

  String recipeDescriptionElementText;
  Uint8List? recipeDescriptionImage;

  factory RecipeDescriptionElement.fromJson(Map<String, dynamic> json) {
    return RecipeDescriptionElement(
        recipeDescriptionElementText: json['recipeDescriptionElementText'],
        recipeDescriptionImage: json['recipeDescriptionElementImage']);
  }

  Map<String, dynamic> toJson() {
    return {
      'recipeDescriptionElementText': recipeDescriptionElementText,
      'recipeDescriptionElementImage': recipeDescriptionImage,
    };
  }
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
