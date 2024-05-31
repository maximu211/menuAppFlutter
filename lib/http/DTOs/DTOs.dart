
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:menuapp/http/dtos/result.dart';
import 'package:menuapp/models/mappers.dart';
import 'package:menuapp/models/models.dart';

class UserDto {
  final List<UserModel> usersList;

  UserDto({required this.usersList});

  factory UserDto.fromJson(Map<String, dynamic> json) {
    final List<dynamic> userJsonList = json['data']['subscribers'];
    final List<UserModel> usersList = userJsonList.map((userJson) {
      return UserModel(
        userName: userJson['username'],
        userImage: json['image'] != null ? base64Decode(json['image']) : null,
        userId: userJson['id'],
      );
    }).toList();

    return UserDto(usersList: usersList);
  }
}

class CardRecipeDto extends ServiceResult {
  List<CardRecipeModel> recipeList;

  CardRecipeDto(
      {required super.success,
      required super.message,
      required this.recipeList});

  factory CardRecipeDto.fromJson(Map<String, dynamic> json) {
    final bool success = json['success'] ?? false;
    final String message = json['message'] ?? '';
    final List<dynamic> recipeJsonList = json['data'];

    List<CardRecipeModel> recipeList;

    recipeList = recipeJsonList.map((recipeJson) {
      return CardRecipeModel.fromJson(recipeJson);
    }).toList();

    return CardRecipeDto(
      recipeList: recipeList,
      success: success,
      message: message,
    );
  }
}

class SearchResultDto {
  List<UserModel> usersList;
  List<CardRecipeModel> recipeList;
  bool success;
  String message;

  SearchResultDto({
    required this.usersList,
    required this.recipeList,
    required this.success,
    required this.message,
  });

  factory SearchResultDto.fromJson(Map<String, dynamic> json) {
    final bool success = json['success'] ?? false;
    final String message = json['message'] ?? '';
    final List<dynamic>? userJsonList = json['data']['userList'];
    final List<dynamic>? recipeJsonList = json['data']['recipeList'];

    List<UserModel>? usersList;

    usersList = userJsonList!.map((userJson) {
      return UserModel.fromJson(userJson);
    }).toList();

    List<CardRecipeModel> recipeList;

    recipeList = recipeJsonList!.map((recipeJson) {
      return CardRecipeModel.fromJson(recipeJson);
    }).toList();

    return SearchResultDto(
      usersList: usersList,
      recipeList: recipeList,
      success: success,
      message: message,
    );
  }
}

class CommentModelDto extends ServiceResult {
  List<CommentModel> commentList;
  CommentModelDto(
      {required super.success,
      required super.message,
      required this.commentList});

  factory CommentModelDto.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? commentJsonList = json['data'];

    List<CommentModel>? commentList;

    commentList = commentJsonList!.map((commentJson) {
      return CommentModel.fromJson(commentJson);
    }).toList();

    return CommentModelDto(
        success: json['success'],
        message: json['message'],
        commentList: commentList);
  }
}

class RecipeDescriptionElementsDto extends ServiceResult {
  List<RecipeDescriptionElement> recipeDescElements;
  List<String> recipeIngradients;
  RecipeDescriptionElementsDto(
      {required super.success,
      required super.message,
      required this.recipeDescElements,
      required this.recipeIngradients});

  factory RecipeDescriptionElementsDto.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? recipeDescJsonList =
        json['data']['recipeDescriptionElements'];
    final List<dynamic>? recipeIngradientsJsonList =
        json['data']['recipeIngradients'];

    List<RecipeDescriptionElement> recipeDescElementList;

    recipeDescElementList = recipeDescJsonList!.map((descJson) {
      return RecipeDescriptionElement.fromJson(descJson);
    }).toList();

    List<String> recipeIngradientsList;

    recipeIngradientsList = recipeIngradientsJsonList!.map((ingrJson) {
      return ingrJson.toString();
    }).toList();

    return RecipeDescriptionElementsDto(
        success: json['success'],
        message: json['message'],
        recipeDescElements: recipeDescElementList,
        recipeIngradients: recipeIngradientsList);
  }
}

class TokenFetchResult extends ServiceResult {
  String? accessToken;
  String? refreshToken;
  bool? isEmailSubmitted;

  TokenFetchResult({
    required bool success,
    required String message,
    this.accessToken,
    this.refreshToken,
    this.isEmailSubmitted,
  }) : super(success: success, message: message);

  factory TokenFetchResult.fromJson(Map<String, dynamic> json) {
    return TokenFetchResult(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      accessToken: json['data'] != null ? json['data']['accessToken'] : null,
      refreshToken: json['data'] != null ? json['data']['refreshToken'] : null,
      isEmailSubmitted:
          json['data'] != null ? json['data']['isEmailSubmited'] : null,
    );
  }
}

class AuthTokenFetch extends ServiceResult {
  String? authToken;

  AuthTokenFetch({
    required bool success,
    required String message,
    this.authToken,
  }) : super(success: success, message: message);

  factory AuthTokenFetch.fromJson(Map<String, dynamic> json) {
    return AuthTokenFetch(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      authToken: json['data'] != null ? json['data']['accessToken'] : null,
    );
  }
}

class UserImageDto extends ServiceResult {
  Uint8List? userImage;

  UserImageDto({
    required bool success,
    required String message,
    this.userImage,
  }) : super(success: success, message: message);

  factory UserImageDto.fromJson(Map<String, dynamic> json) {
    return UserImageDto(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      userImage: base64Decode(json['data']),
    );
  }
}

class FullRecipeDto {
  String name;
  CookingTime cookingTime;
  CookingDifficulty difficulty;
  String recipeType;
  String? image;
  List<RecipeDescriptionElement> recipeDescElements;
  List<String> recipeIngredients;

  FullRecipeDto(
      {required this.name,
      required this.image,
      required this.cookingTime,
      required this.difficulty,
      required this.recipeDescElements,
      required this.recipeIngredients,
      required this.recipeType});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'cookTime': cookingTime.index,
      'image': image,
      'cookingDifficulty': difficulty.index,
      'recipeType': recipeType,
      'recipeDescriptionElements':
          recipeDescElements.map((e) => e.toJson()).toList(),
      'recipeIngredients': recipeIngredients,
    };
  }

  factory FullRecipeDto.fromJson(Map<String, dynamic> json) {
    final List<dynamic> recipeDescJsonList =
        json['data']['recipeDescriptionElements'];
    final List<dynamic> recipeIngradientsJsonList =
        json['data']['recipeIngredients'];

    List<RecipeDescriptionElement> recipeDescElementList;
    recipeDescElementList = recipeDescJsonList.map((descJson) {
      return RecipeDescriptionElement.fromJson(descJson);
    }).toList();

    List<String> recipeIngradientsList;
    recipeIngradientsList =
        recipeIngradientsJsonList.map((recipeIngradientsJsonList) {
      return recipeIngradientsJsonList.toString();
    }).toList();

    return FullRecipeDto(
      name: json['data'] != null ? json['data']['name'] : null,
      cookingTime: Mapper.getCookingTimeByIndex(json['data']['cookTime']),
      difficulty:
          Mapper.getCookingDifficultyByIndex(json['data']['cookingDifficulty']),
      image: json['data'] != null ? json['data']['image'] : null,
      recipeDescElements: recipeDescElementList,
      recipeIngredients: recipeIngradientsList,
      recipeType: json['data'] != null ? json['data']['recipeType'] : null,
    );
  }
}

class RecipeNotifier extends ChangeNotifier {
  FullRecipeDto _recipe;

  RecipeNotifier(this._recipe);

  FullRecipeDto get recipe => _recipe;

  set recipe(FullRecipeDto newRecipe) {
    _recipe = newRecipe;
    notifyListeners();
  }
}

class UserPageDataDto extends ServiceResult {
  UserPageDataDto(
      {required super.success,
      required super.message,
      required this.isOwner,
      required this.isSubscribed,
      required this.recipes,
      required this.subscribedToCount,
      required this.subscribedUsersCount,
      required this.user});

  List<CardRecipeModel> recipes;
  bool isSubscribed;
  int subscribedUsersCount;
  int subscribedToCount;
  bool isOwner;
  UserModel user;

  factory UserPageDataDto.fromJson(Map<String, dynamic> json) {
    UserModel user = UserModel.fromJson(json['data']['user']);
    List<dynamic>? recipes = json['data']['cardRecipes'];
    int subscribedUsersCount = json['data']['subscribedUsersCount'];
    int subscribedToCount = json['data']['subscribedToCount'];
    dynamic isOwner = json['data']['isOwner'];
    dynamic isSubscribed = json['data']['isSubscribed'] ?? false;

    List<CardRecipeModel> recipeList;
    recipeList = recipes!.map((descJson) {
      return CardRecipeModel.fromJson(descJson);
    }).toList();

    return UserPageDataDto(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      isOwner: isOwner,
      isSubscribed: isSubscribed,
      recipes: recipeList,
      subscribedToCount: subscribedToCount,
      subscribedUsersCount: subscribedUsersCount,
      user: user,
    );
  }
}
