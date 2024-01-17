import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:menuapp/add_page/form_components/image_picker/image_picker.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<StatefulWidget> createState() => _AddPage();
}

class _AddPage extends State<AddPage> {
  File? image;
  Future pickImage(bool isGallery) async {
    try {
      final image = await ImagePicker().pickImage(
          source: isGallery ? ImageSource.gallery : ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: ColorVariables.primaryColor,
            title: Text(
              "Create new receipt 😍",
              style: TextStyle(
                color: ColorVariables.backgroundColor,
                fontSize: FontSizeVariables.h1Size,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    ImagePickerContainer(
                      image: image,
                      pickImage: pickImage,
                      clearImage: () {
                        setState(() {
                          image = null;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Additional Information',
                      style: TextStyle(
                          color: ColorVariables.backgroundColor,
                          fontSize: FontSizeVariables.h2Size,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
