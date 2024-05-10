import 'package:flutter/material.dart';
import 'package:menuapp/pages/common_components/image_picker/photo_button.dart';
import 'package:menuapp/global_variables/color_variables.dart';

void showImageSelectionBottomSheet(
    BuildContext context, Function(bool) pickImage) {
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
            BottomModalButton(
              icon: Icons.camera_alt,
              onPressed: () {
                pickImage(false);
              },
              buttonText: "Create photo",
            ),
            BottomModalButton(
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
}
