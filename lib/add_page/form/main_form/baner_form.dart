import "dart:typed_data";
import "package:flutter/material.dart";
import "package:image_editor_plus/image_editor_plus.dart";
import 'package:menuapp/add_page/form/form_components/from_input_field.dart';
import 'package:menuapp/add_page/form/form_components/image_picker/image_picker.dart';

class BannerForm extends StatefulWidget {
  BannerForm(
      {super.key,
      required this.image,
      required this.fieldController,
      required this.maxLenght,
      required this.validator});

  Uint8List? image;
  final TextEditingController fieldController;
  final int maxLenght;
  final String? Function(String?) validator;

  @override
  State<BannerForm> createState() => _BannerFormState();
}

class _BannerFormState extends State<BannerForm> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          FormInputField(
            inputLabel: 'Input dish name',
            filedController: widget.fieldController,
            maxLenght: widget.maxLenght,
            validator: widget.validator,
          ),
          const SizedBox(height: 15),
          ImagePickerContainer(
            image: widget.image,
            onImageChanged: (image) {
              widget.image = image;
            },
          ),
        ],
      ),
    );
  }
}
