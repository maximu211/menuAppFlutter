import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:menuapp/add_page/form/main_form/main_form.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/global_variables/modal_dialog.dart';
import 'package:menuapp/models/models.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<StatefulWidget> createState() => _AddPage();
}

class FiledMaxLenght {
  static int maxLenghtDishName = 50;
  static int maxLenghtDishType = 10;
}

class _AddPage extends State<AddPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  Uint8List? image;
  final String dishType = '';
  final CookingTime dishCookTime = CookingTime.hour1;
  final CookingDifficulty dishHardness = CookingDifficulty.easy;

  final TextEditingController _fieldNameController = TextEditingController();
  final TextEditingController _dishTypeFieldController =
      TextEditingController();

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
    setState(() => this.image = imageBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorVariables.primaryColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: ColorVariables.backgroundColor,
          ),
          onPressed: () => DialogUtils.showLeavePageDialog(
            context: context,
            cancelFunc: () {
              Navigator.pop(context);
            },
            description: "If you leave the page, the data will not be saved",
            okFunc: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            title: "Do you want to leave the page?",
          ),
        ),
        title: Text(
          'Create your masterpiece 😍',
          style: TextStyle(
            fontSize: FontSizeVariables.h1Size,
            color: ColorVariables.backgroundColor,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: [
                MainForm(
                  image: image,
                  pickImage: pickImage,
                  fieldNameController: _fieldNameController,
                  maxNameLenght: FiledMaxLenght.maxLenghtDishName,
                  validatorNameField: (value) {
                    return;
                  },
                  dishTypeFieldController: _dishTypeFieldController,
                  maxDishTypeLenght: FiledMaxLenght.maxLenghtDishType,
                  validatorDishTypeField: (value) {
                    return;
                  },
                ),
                Container(
                  color: Colors.orange,
                  child: const Center(
                    child: Text('Page 3'),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SmoothPageIndicator(
                  controller: _pageController,
                  count: 2,
                  effect: ExpandingDotsEffect(
                    activeDotColor: ColorVariables.primaryColor,
                    dotColor: Colors.grey,
                    dotWidth: 20,
                    dotHeight: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
