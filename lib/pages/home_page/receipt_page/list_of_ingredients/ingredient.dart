import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';

class Ingredient extends StatefulWidget {
  const Ingredient({super.key, required this.ingradient});

  final String ingradient;

  @override
  State<Ingredient> createState() => _IngredientState();
}

class _IngredientState extends State<Ingredient> {
  late bool isCrossedText = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: isCrossedText,
            activeColor: ColorVariables.primaryColor,
            checkColor: ColorVariables.backgroundColor,
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
                decorationColor: ColorVariables.backgroundColor,
                decorationThickness: 2,
                color: ColorVariables.backgroundColor),
          ),
        ),
      ],
    );
  }
}
