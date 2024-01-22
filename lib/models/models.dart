class UserModel {
  UserModel({required this.userName, required this.userPhoto});

  String userPhoto;
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
    required this.cookHardness,
    required this.cookTime,
    required this.cookType,
    required this.isDishSaved,
    required this.savedCount,
    required this.isDishLiked,
  });

  String dishPhoto;
  String receiptId;
  UserModel user;
  String dishName;
  String cookHardness;
  String cookTime;
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
      {required this.receiptDescriptionElemens,
      required this.receiptIngradient});

  List<String> receiptIngradient;
  List<ReceiptDescriptionElement> receiptDescriptionElemens;
}

class ReceiptDescriptionElement {
  ReceiptDescriptionElement(
      {required this.receiptDescriptionElementText,
      this.receiptDescriptionPhoto});

  String receiptDescriptionElementText;
  String? receiptDescriptionPhoto;
}

enum DishHardness {
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