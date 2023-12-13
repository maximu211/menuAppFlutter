import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';

import '../../global_variables/font_size_variables.dart';
import '../../global_variables/icon_size_variables.dart';

class CardIconsInfo extends StatelessWidget {
  final String textTime;
  final String textHardness;
  final String textType;
  final Color iconColor;

  const CardIconsInfo({
    required this.textTime,
    required this.textHardness,
    required this.textType,
    required this.iconColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    IconSizeVariables iconSizeVariables = IconSizeVariables();
    ColorPackage colors = ColorPackage();
    FontSizeVariables fontSize = FontSizeVariables();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.access_time_filled, color: iconColor, size: iconSizeVariables.regularSize,),
              Text(textTime, style: TextStyle(color: iconColor, fontSize: fontSize.regularSize))
            ],
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.star, color: iconColor, size: iconSizeVariables.regularSize,),
              Text(textHardness, style: TextStyle(color: iconColor, fontSize: fontSize.regularSize))
            ],
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.restaurant, color: iconColor, size: iconSizeVariables.regularSize,),
              Text(textType, style: TextStyle(color: iconColor, fontSize: fontSize.regularSize))
            ],
          ),
        ),
      ],
    );
  }
}