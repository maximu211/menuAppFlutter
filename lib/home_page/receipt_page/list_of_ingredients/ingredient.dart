import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/global_variables/icon_size_variables.dart';

class Ingredient extends StatefulWidget {
  Ingredient({super.key, required this.ingradient});

  String ingradient;

  @override
  State<Ingredient> createState() => _IngredientState();
}

class _IngredientState extends State<Ingredient> {
  late bool isCrossedText = false;

  final ColorPackage colors = ColorPackage();
  final FontSizeVariables fontSize = FontSizeVariables();
  final IconSizeVariables iconSize = IconSizeVariables();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: isCrossedText,
            activeColor: colors.primary_color,
            checkColor: colors.pure_white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            onChanged: (value) {
              setState(() {
                isCrossedText = value ?? false;
              });
            }),
        Flexible(
          child: Text(
            widget.ingradient,
            style: TextStyle(
                decoration: isCrossedText ? TextDecoration.lineThrough : null,
                decorationColor: colors.background_color,
                decorationThickness: 2,
                color: colors.background_color),
          ),
        ),
      ],
    );
  }
}
