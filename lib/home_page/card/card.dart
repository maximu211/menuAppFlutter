import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/home_page/components/booked_icon.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/global_variables/icon_size_variables.dart';
import 'package:menuapp/home_page/receipt_page/receipt_page.dart';
import 'package:menuapp/models/card_model.dart';
import '../components/user_row.dart';
import 'card_icons_info.dart';

class MainPageCard extends StatefulWidget {
  MainPageCard({Key? key, required this.cardReceipt}) : super(key: key);

  final CardReceipt cardReceipt;

  @override
  State<MainPageCard> createState() => _MainPageCardState();
}

class _MainPageCardState extends State<MainPageCard> {
  final ColorPackage colors = ColorPackage();
  final FontSizeVariables fontSize = FontSizeVariables();
  final IconSizeVariables iconSize = IconSizeVariables();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [BoxShadow(color: Colors.black, blurRadius: 2)],
          color: colors.primary_color,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            UserRow(
              photoPath: widget.cardReceipt.userPhoto,
              userName: widget.cardReceipt.userName,
              textColor: colors.background_color,
            ),
            Image.asset(
              widget.cardReceipt.dishPhoto,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.25,
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 10),
            Text(
              widget.cardReceipt.dishName,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: fontSize.h1Size,
                  fontWeight: FontWeight.bold,
                  color: colors.background_color),
            ),
            const SizedBox(height: 10),
            CardIconsInfo(
                textHardness: widget.cardReceipt.cookHardness,
                textTime: widget.cardReceipt.cookTime,
                textType: widget.cardReceipt.cookType,
                iconColor: colors.background_color),
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(_createRoute(
                          cardReceipt: widget.cardReceipt,
                        ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.background_color,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                      ),
                      child: Text(
                        "Go to receipt!",
                        style: TextStyle(
                            fontSize: fontSize.regularSize,
                            fontWeight: FontWeight.bold,
                            color: colors.primary_color),
                      ),
                    ),
                  ),
                  ButtonToggle(
                      bookedButtonColor: colors.pure_white,
                      isDishSaved: widget.cardReceipt.isDishSaved,
                      onTap: (newState) {
                        setState(() {
                          widget.cardReceipt.isDishSaved = newState;
                          if (newState) {
                            widget.cardReceipt.savedCount++;
                          } else {
                            widget.cardReceipt.savedCount--;
                          }
                        });
                      }),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Icon(Icons.bookmark, color: colors.background_color, size: iconSize.regularSize),
                  Text(
                    widget.cardReceipt.savedCount.toString(),
                    style: TextStyle(color: colors.background_color),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Route _createRoute({
  required dynamic cardReceipt,
}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => ReceiptPage(
      cardReceipt: cardReceipt,
    ),
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
