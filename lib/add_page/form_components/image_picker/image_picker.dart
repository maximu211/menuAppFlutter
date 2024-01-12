import 'dart:io';
import 'package:flutter/material.dart';
import 'package:menuapp/add_page/form_components/image_picker/photo_button.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';

class ImagePickerContainer extends StatelessWidget {
  final File? image;
  final Function(bool) pickImage;
  final Function() clearImage;

  const ImagePickerContainer(
      {Key? key,
      required this.image,
      required this.pickImage,
      required this.clearImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: ColorVariables.primaryColor,
        boxShadow: const [
          BoxShadow(blurRadius: 5, color: Colors.black),
        ],
      ),
      child: Center(
        child: Column(
          children: [
            image == null
                ? const SizedBox()
                : ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 400),
                    child: Container(
                      margin:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Image.file(image!, fit: BoxFit.cover),
                    ),
                  ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorVariables.backgroundColor,
              ),
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: ColorVariables.primaryColor,
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.16,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PhotoIconButton(
                            icon: Icons.camera_alt,
                            onPressed: () {
                              pickImage(false);
                            },
                            buttonText: "Create photo",
                          ),
                          PhotoIconButton(
                            icon: Icons.image,
                            onPressed: () {
                              pickImage(true);
                            },
                            buttonText: "Choose image from gallery",
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Text(
                "Choose image",
                style: TextStyle(
                  color: ColorVariables.primaryColor,
                  fontSize: FontSizeVariables.h2Size,
                ),
              ),
            ),
            image != null
                ? ElevatedButton(
                    onPressed: () {
                      clearImage();
                    },
                    child: const Text(
                      'Clear image',
                      style: TextStyle(color: Colors.red),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
