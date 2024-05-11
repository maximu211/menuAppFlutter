import 'package:flutter/material.dart';

class TextFieldLogin extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.black),
      controller: loginFieldController,
      obscureText: isPasswordField,
      validator: validator,
      decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(40))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(40))),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(40))),
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.black),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 250, 4, 0)),
              borderRadius: BorderRadius.all(Radius.circular(40))),
          focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 250, 4, 0)),
              borderRadius: BorderRadius.all(Radius.circular(40))),
          errorStyle: const TextStyle(color: Color.fromARGB(255, 250, 4, 0))),
    );
  }
}
