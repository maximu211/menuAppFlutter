import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';

class FromInputField extends StatelessWidget {
  const FromInputField({
    super.key,
    required this.filedController,
    required this.maxLenght,
    required this.validator,
  });

  final TextEditingController filedController;
  final int? maxLenght;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: filedController,
      maxLength: maxLenght,
      maxLines: null,
      cursorColor: ColorVariables.primaryColor,
      decoration: InputDecoration(
        filled: true,
        labelText: 'Input dish name',
        focusColor: ColorVariables.primaryColor,
        labelStyle: const TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: ColorVariables.primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: ColorVariables.primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
      keyboardType: TextInputType.text,
      validator: validator,
    );
  }
}
