import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:menuapp/add_page/form/main_form/additional_informaton_form.dart';
import 'package:menuapp/add_page/form/main_form/baner_form.dart';

class MainForm extends StatefulWidget {
  MainForm(
      {super.key,
      required this.pickImage,
      required this.fieldNameController,
      required this.maxNameLenght,
      required this.validatorNameField,
      required this.dishTypeFieldController,
      required this.maxDishTypeLenght,
      required this.validatorDishTypeField,
      required this.image});

  Uint8List? image;
  final Function(bool) pickImage;
  final TextEditingController fieldNameController;
  final int maxNameLenght;
  final String? Function(String?) validatorNameField;

  final TextEditingController dishTypeFieldController;
  final int maxDishTypeLenght;
  final String? Function(String?) validatorDishTypeField;
  @override
  State<MainForm> createState() => _MainFormState();
}

class _MainFormState extends State<MainForm> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            BannerForm(
              fieldController: widget.fieldNameController,
              image: widget.image,
              pickImage: widget.pickImage,
              maxLenght: widget.maxNameLenght,
              validator: widget.validatorNameField,
            ),
            const SizedBox(height: 20),
            AdditionalInformationForm(
              fieldController: widget.dishTypeFieldController,
              maxLenght: widget.maxDishTypeLenght,
              validator: widget.validatorDishTypeField,
            )
          ],
        ),
      ),
    );
  }
}
