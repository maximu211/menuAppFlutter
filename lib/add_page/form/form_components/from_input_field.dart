import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';

class FormInputField extends StatelessWidget {
  const FormInputField({
    super.key,
    required this.filedController,
    required this.maxLenght,
    required this.validator,
    required this.inputLabel,
  });

  final TextEditingController filedController;
  final int? maxLenght;
  final String? Function(String?) validator;
  final String inputLabel;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: filedController,
      maxLength: maxLenght,
      maxLines: null,
      cursorColor: ColorVariables.primaryColor,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(30, 255, 115, 0),
        labelText: inputLabel,
        focusColor: ColorVariables.primaryColor,
        labelStyle: const TextStyle(color: Colors.black),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: ColorVariables.backgroundColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: ColorVariables.primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
      keyboardType: TextInputType.text,
      validator: validator,
    );
  }
}
