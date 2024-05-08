import 'package:flutter/services.dart';
import 'package:menuapp/http/DTOs/result.dart';

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

class UserDto {
  final List<UserModel> usersList;

  UserDto({required this.usersList});

  factory UserDto.fromJson(Map<String, dynamic> json) {
    final List<dynamic> userJsonList = json['data']['subscribers'];
    final List<UserModel> usersList = userJsonList.map((userJson) {
      return UserModel(
        userName: userJson['userName'],
        userImage: userJson['userPhotoUrl'],
        userId: userJson['userId'],
      );
    }).toList();

    return UserDto(usersList: usersList);
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

class CardRecipeDto extends ServiceResult {
  List<CardRecipeModel>? recipeList;

  CardRecipeDto(
      {required super.success,
      required super.message,
      required this.recipeList});

  factory CardRecipeDto.fromJson(Map<String, dynamic> json) {
    final bool success = json['success'] ?? false;
    final String message = json['message'] ?? '';
    final List<dynamic>? recipeJsonList = json['data'];

    List<CardRecipeModel>? recipeList;
    if (recipeJsonList != null) {
      recipeList = recipeJsonList.map((recipeJson) {
        return CardRecipeModel.fromJson(recipeJson);
      }).toList();
    }

    return CardRecipeDto(
      recipeList: recipeList,
      success: success,
      message: message,
    );
  }
}

class SearchResultDto {
  List<UserModel>? usersList;
  List<CardRecipeModel>? recipeList;
  bool success;
  String message;

  SearchResultDto({
    this.usersList,
    this.recipeList,
    required this.success,
    required this.message,
  });

  factory SearchResultDto.fromJson(Map<String, dynamic> json) {
    final bool success = json['success'] ?? false;
    final String message = json['message'] ?? '';
    final List<dynamic>? userJsonList = json['data']['userList'];
    final List<dynamic>? recipeJsonList = json['data']['recipeList'];

    List<UserModel>? usersList;
    if (userJsonList != null) {
      usersList = userJsonList.map((userJson) {
        return UserModel.fromJson(userJson);
      }).toList();
    }

    List<CardRecipeModel>? recipeList;
    if (recipeJsonList != null) {
      recipeList = recipeJsonList.map((recipeJson) {
        return CardRecipeModel.fromJson(recipeJson);
      }).toList();
    }

    return SearchResultDto(
      usersList: usersList,
      recipeList: recipeList,
      success: success,
      message: message,
    );
  }
}

class CommentModel {
  CommentModel(
      {required this.commentText,
      required this.commentDateTime,
      required this.user,
      required this.isOwner});

  UserModel user;
  String commentText;
  DateTime commentDateTime;
  bool isOwner;

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
        commentDateTime: json['createdAt'],
        commentText: json['comment'],
        user: UserModel.fromJson(json['user']),
        isOwner: json['isOwner']);
  }
}

class CommentModelDto extends ServiceResult {
  List<CommentModel>? commentList;
  CommentModelDto(
      {required super.success,
      required super.message,
      required this.commentList});

  factory CommentModelDto.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? commentJsonList = json['data'];

    List<CommentModel>? commentList;
    if (commentJsonList != null) {
      commentList = commentJsonList.map((commentJson) {
        return CommentModel.fromJson(commentJson);
      }).toList();
    }

    return CommentModelDto(
        success: json['success'],
        message: json['message'],
        commentList: commentList);
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
}

class RecipeDescriptionElementsDto extends ServiceResult {
  List<RecipeDescriptionElement>? recipeDescElements;
  List<String>? recipeIngradients;
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

    List<RecipeDescriptionElement>? recipeDescElementList;
    if (recipeDescJsonList != null) {
      recipeDescElementList = recipeDescJsonList.map((descJson) {
        return RecipeDescriptionElement.fromJson(descJson);
      }).toList();
    }

    List<String>? recipeIngradientsList;
    if (recipeIngradientsJsonList != null) {
      recipeIngradientsList = recipeIngradientsJsonList.map((ingrJson) {
        return ingrJson.toString();
      }).toList();
    }

    return RecipeDescriptionElementsDto(
        success: json['success'],
        message: json['message'],
        recipeDescElements: recipeDescElementList,
        recipeIngradients: recipeIngradientsList);
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

class FetchUserImage extends ServiceResult {
  String? userImage;

  FetchUserImage({
    required bool success,
    required String message,
    this.userImage,
  }) : super(success: success, message: message);

  factory FetchUserImage.fromJson(Map<String, dynamic> json) {
    return FetchUserImage(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      userImage: json['data'] != null ? json['data']['userImage'] : null,
    );
  }
}
