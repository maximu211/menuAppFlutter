import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:menuapp/add_page/form/form_components/image_bottom_modal.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';

class ImagePickerContainer extends StatefulWidget {
  Uint8List? image;
  final Function(Uint8List?)? onImageChanged;

  ImagePickerContainer({
    Key? key,
    required this.image,
    this.onImageChanged,
  }) : super(key: key);

  @override
  State<ImagePickerContainer> createState() => _ImagePickerContainerState();
}

class _ImagePickerContainerState extends State<ImagePickerContainer> {
  Future<Uint8List?> fileToUint8List(File? file) async {
    if (file == null) {
      return null;
    }

    Uint8List bytes = await file.readAsBytes();
    return Uint8List.fromList(bytes);
  }

  Future pickImage(bool isGallery) async {
    final image = await ImagePicker().pickImage(
      source: isGallery ? ImageSource.gallery : ImageSource.camera,
    );
    if (image == null) return;

    final imageBytes = await fileToUint8List(File(image.path));

    widget.onImageChanged?.call(imageBytes);

    setState(() => widget.image = imageBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: ColorVariables.primaryColor,
        boxShadow: const [BoxShadow(blurRadius: 5, color: Colors.black)],
      ),
      child: Center(
        child: Column(
          children: [
            widget.image == null
                ? const SizedBox()
                : ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 400),
                    child: Container(
                      margin:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Image.memory(widget.image!, fit: BoxFit.cover),
                    ),
                  ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorVariables.backgroundColor,
              ),
              onPressed: () {
                showImageSelectionBottomSheet(context, pickImage);
              },
              child: Text(
                "Choose image",
                style: TextStyle(
                  color: ColorVariables.primaryColor,
                  fontSize: FontSizeVariables.h2Size,
                ),
              ),
            ),
            widget.image != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          var editedImage = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ImageCropper(
                                image: widget.image as Uint8List,
                              ),
                            ),
                          );

                          if (editedImage != null) {
                            setState(() {
                              widget.image = editedImage;
                            });
                          }
                        },
                        child: const Text('Edit Image'),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            widget.image = null;
                          });
                        },
                        child: const Text(
                          'Clear image',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
