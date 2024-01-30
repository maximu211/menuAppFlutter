import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menuapp/add_page/form/main_form/main_form.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/global_variables/modal_dialog.dart';
import 'package:menuapp/models/models.dart';

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
  Uint8List? image;
  final String dishType = '';
  final CookingTime dishCookTime = CookingTime.hour1;
  final CookingDifficulty dishHardness = CookingDifficulty.easy;

  final TextEditingController _fieldNameController = TextEditingController();
  final TextEditingController _dishTypeFieldController =
      TextEditingController();

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
            child: MainForm(
              image: image,
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
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, bottom: 20, right: 20),
            width: double.maxFinite,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: ColorVariables.primaryColor),
              onPressed: () {},
              child: Text(
                "Submit",
                style: TextStyle(
                    color: ColorVariables.backgroundColor,
                    fontSize: FontSizeVariables.h2Size),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
