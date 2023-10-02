import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';

class TextFieldLogin extends StatefulWidget{
  const TextFieldLogin({super.key, required this.isPasswordField, required this.labelText});

  final bool isPasswordField;
  final String labelText;

  @override
  State<TextFieldLogin> createState() => _TextFieldsState();
}

class _TextFieldsState extends State<TextFieldLogin> {
  ColorPackage colors = ColorPackage();

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.isPasswordField,
      decoration: InputDecoration(
          icon: Icon(
            Icons.arrow_forward_ios_sharp,
            color: colors.primary_color,
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colors.primary_color),
              borderRadius: const BorderRadius.all(Radius.circular(40))),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(40))),
          labelText: widget.labelText,
          labelStyle: TextStyle(color: colors.primary_color)),
    );
  }
}