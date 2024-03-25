import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';

class TextFieldLogin extends StatefulWidget {
  const TextFieldLogin({
    super.key,
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
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: ColorVariables.backgroundColor),
      controller: widget.loginFieldController,
      obscureText: widget.isPasswordField,
      validator: widget.validator,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorVariables.backgroundColor),
            borderRadius: const BorderRadius.all(Radius.circular(40))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorVariables.backgroundColor),
            borderRadius: const BorderRadius.all(Radius.circular(40))),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(40))),
        labelText: widget.labelText,
        labelStyle: TextStyle(color: ColorVariables.backgroundColor),
      ),
    );
  }
}
