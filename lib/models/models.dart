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
  UserModel({required this.userName, required this.userPhoto});

  Uint8List userPhoto;
  String userName;
}

class IdUserModel extends UserModel {
  IdUserModel(
      {required super.userName,
      required super.userPhoto,
      required this.userId});

  String userId;
}

class CardReceiptModel {
  CardReceiptModel({
    required this.dishPhoto,
    required this.receiptId,
    required this.user,
    required this.userId,
    required this.dishName,
    required this.cookDifficulty,
    required this.cookTime,
    required this.cookType,
    required this.isDishSaved,
    required this.savedCount,
    required this.isDishLiked,
  });

  Uint8List dishPhoto;
  String receiptId;
  UserModel user;
  String dishName;
  CookingDifficulty cookDifficulty;
  CookingTime cookTime;
  String cookType;
  String userId;
  bool isDishSaved;
  bool isDishLiked;
  int savedCount;
}

class CommentModel {
  CommentModel(
      {required this.commentText,
      required this.commentDateTime,
      required this.userId,
      required this.user});

  String userId;
  UserModel user;
  String commentText;
  DateTime commentDateTime;
}

class ReceiptDetailModel {
  ReceiptDetailModel(
      {required this.receiptDescriptionElements,
      required this.receiptIngradient});

  List<String> receiptIngradient;
  List<ReceiptDescriptionElement> receiptDescriptionElements;
}

class ReceiptDescriptionElement {
  ReceiptDescriptionElement(
      {required this.receiptDescriptionElementText,
      this.receiptDescriptionPhoto});

  String receiptDescriptionElementText;
  Uint8List? receiptDescriptionPhoto;
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
