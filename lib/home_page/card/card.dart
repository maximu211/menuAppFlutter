import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/home_page/card/booked_icon.dart';

import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/global_variables/icon_size_variables.dart';
import 'user_row.dart';
import 'card_icons_info.dart';

class MainPageCard extends StatefulWidget {
  MainPageCard(
      {super.key,
      required this.userPhoto,
      required this.userName,
      required this.dishPhoto,
      required this.dishName,
      required this.cookHardness,
      required this.cookTime,
      required this.cookType,
      required this.isDishSaved,
      required this.savedCount});

  final String userPhoto;
  final String userName;

  final String dishPhoto;
  final String dishName;

  final String cookHardness;
  final String cookTime;
  final String cookType;

  bool isDishSaved;
  int savedCount;
  @override
  State<MainPageCard> createState() => _MainPageCardState();
}

class _MainPageCardState extends State<MainPageCard> {
  final ColorPackage colors = ColorPackage();
  final FontSizeVariables fontSize = FontSizeVariables();
  final IconSizeVariables iconSize = IconSizeVariables();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [BoxShadow(color: Colors.black, blurRadius: 2)],
            color: colors.primary_color,
          ),
          child: Column(
            children: [
              UserRow(
                photoPath: widget.userPhoto,
                userName: widget.userName,
                textColor: colors.background_color,
              ),
              Image.asset(
                widget.dishPhoto,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.2,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10),
              Text(
                widget.dishName,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: fontSize.h1Size, color: colors.background_color),
              ),
              const SizedBox(height: 10),
              CardIconsInfo(
                  textHardness: widget.cookHardness,
                  textTime: widget.cookTime,
                  textType: widget.cookType,
                  iconColor: colors.background_color),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: CardButton(colors: colors)),
                    ButtonToggle(
                        bookedButtonColor: colors.background_color,
                        isDishSaved: widget.isDishSaved),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Icon(Icons.bookmark,
                        color: colors.background_color, size: iconSize.regularSize),
                    Text(
                      widget.savedCount.toString(),
                      style: TextStyle(color: colors.background_color),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
