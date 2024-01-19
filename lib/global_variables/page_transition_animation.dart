import 'package:flutter/material.dart';
import 'package:menuapp/add_page/add_page.dart';
import 'package:menuapp/home_page/receipt_page/receipt_page.dart';

Route createRoute({
  dynamic cardReceipt,
  required String pageType,
}) {
  late Widget destinationPage;

  if (pageType == 'receiptPage') {
    destinationPage = ReceiptPage(cardReceipt: cardReceipt);
  } else if (pageType == 'addPage') {
    destinationPage = const AddPage();
  }

  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => destinationPage,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}