import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/global_variables/icon_size_variables.dart';

class TextFieldLogin extends StatefulWidget {
  const TextFieldLogin(
      {super.key,
      required this.isPasswordField,
      required this.labelText,
      required this.loginFieldController,
      required this.validator,
  });

  final bool isPasswordField;
  final String labelText;
  final TextEditingController loginFieldController;
  final String? Function(String?) validator;

  @override
  State<TextFieldLogin> createState() => _TextFieldsState();
}

class _TextFieldsState extends State<TextFieldLogin> {
  final ColorPackage colors = ColorPackage();
  final FontSizeVariables fontSize = FontSizeVariables();
  final IconSizeVariables iconSize = IconSizeVariables();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      controller: widget.loginFieldController,
      obscureText: widget.isPasswordField,
      validator: widget.validator,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(40))),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(40))),
        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(40))),
        labelText: widget.labelText,
        labelStyle: const TextStyle(color: Colors.white),
      ),
    );
  }
}
