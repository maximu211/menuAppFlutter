import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';

class FormCardButton extends StatelessWidget {
  const FormCardButton(
      {super.key,
      required this.onPressed,
      required this.icon,
      required this.label,
      required this.isColorMain});

  final void Function()? onPressed;
  final IconData icon;
  final String label;
  final bool isColorMain;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: isColorMain
            ? ColorVariables.primaryColor
            : ColorVariables.backgroundColor,
      ),
      onPressed: onPressed,
      label: Text(
        label,
        style: TextStyle(
          color: isColorMain
              ? ColorVariables.backgroundColor
              : ColorVariables.primaryColor,
          fontSize: FontSizeVariables.h2Size,
        ),
      ),
      icon: Icon(
        icon,
        color: isColorMain
            ? ColorVariables.backgroundColor
            : ColorVariables.primaryColor,
      ),
    );
  }
}
