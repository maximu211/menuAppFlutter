import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/global_variables/icon_size_variables.dart';

class BottomModalButton extends StatelessWidget {
  const BottomModalButton(
      {super.key,
      required this.icon,
      required this.onPressed,
      required this.buttonText});

  final IconData icon;
  final Function() onPressed;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton.icon(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: ColorVariables.backgroundColor,
          size: IconSizeVariables.regularSize,
        ),
        label: Text(
          buttonText,
          style: TextStyle(
              fontSize: FontSizeVariables.h2Size,
              color: ColorVariables.backgroundColor),
        ),
      ),
    );
  }
}
