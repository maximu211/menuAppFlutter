import 'package:flutter/material.dart';

class CardReceipt {
  CardReceipt(
      {required this.dishPhoto,
      required this.userPhoto,
      required this.userName,
      required this.dishName,
      required this.cookHardness,
      required this.cookTime,
      required this.cookType,
      required this.isDishSaved,
      required this.savedCount});

  String userPhoto;
  String userName;

  String dishPhoto;
  String dishName;

  String cookHardness;
  String cookTime;
  String cookType;

  bool isDishSaved;
  int savedCount;
}

class CardReceiptModel extends InheritedWidget {
  final CardReceipt cardReceipt;
  final Function(bool) updateSavedState;

  CardReceiptModel({
    required this.cardReceipt,
    required this.updateSavedState,
    required Widget child,
  }) : super(child: child);

  static CardReceiptModel? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CardReceiptModel>();
  }

  @override
  bool updateShouldNotify(CardReceiptModel oldWidget) {
    return cardReceipt != oldWidget.cardReceipt;
  }
}
