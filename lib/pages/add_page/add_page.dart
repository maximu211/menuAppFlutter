// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menuapp/pages/add_page/form_components/dropdown_picker.dart';
import 'package:menuapp/pages/common_components/form_input_field.dart';
import 'package:menuapp/pages/common_components/image_picker/image_picker.dart';
import 'package:menuapp/pages/add_page/form_components/instruction_edit/instruction_form.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/global_variables/dialog_utils.dart';
import 'package:menuapp/models/models.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<StatefulWidget> createState() => _AddPage();
}

class FiledMaxLenght {
  static int maxLenghtrecipeName = 50;
  static int maxLenghtrecipeType = 30;
}

class _AddPage extends State<AddPage> {
  Uint8List? _mainImage;
  late String _recipeType;
  late String _recipeName;
  late CookingTime? _recipeCookTime;
  late CookingDifficulty? _recipeHardness;
  late final List<RecipeDescriptionElement> _stepList = [];

  bool _isStepListEmpty = false;
  bool _isImageEmpty = false;

  final TextEditingController _fieldNameController = TextEditingController();
  final TextEditingController _recipeTypeFieldController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                FormInputField(
                  inputLabel: 'Input recipe name',
                  filedController: _fieldNameController,
                  maxLenght: 50,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Please input recipe name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                ImagePickerContainer(
                  image: _mainImage,
                  onImageChanged: (image) {
                    setState(() {
                      _mainImage = image;
                    });
                  },
                ),
                _isImageEmpty
                    ? const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 6),
                          Text(
                            "Please choose image",
                            style: TextStyle(
                                color: Color.fromARGB(255, 180, 45, 12),
                                fontSize: 13),
                          ),
                        ],
                      )
                    : const SizedBox(),
                const SizedBox(height: 20),
                FormInputField(
                  filedController: _recipeTypeFieldController,
                  inputLabel: 'Input recipe type (salad, drink, etc.)',
                  maxLenght: FiledMaxLenght.maxLenghtrecipeType,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please input recipe type";
                    }
                    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                      return "Invalid characters. Only letters and spaces are allowed.";
                    }
                    return null;
                  },
                ),
                DropdownPicker<CookingTime>(
                  isTime: true,
                  onChange: (CookingTime? selectedValue) {
                    setState(() {
                      _recipeCookTime = selectedValue;
                    });
                  },
                ),
                const SizedBox(height: 20),
                DropdownPicker<CookingDifficulty>(
                  isTime: false,
                  onChange: (CookingDifficulty? selectedValue) {
                    setState(() {
                      _recipeHardness = selectedValue;
                    });
                  },
                ),
                const SizedBox(height: 20),
                InstuctionForm(stepList: _stepList),
                _isStepListEmpty
                    ? const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 6),
                          Text(
                            "Please add at least one instruction step",
                            style: TextStyle(
                              color: Color.fromARGB(255, 180, 45, 12),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          width: double.maxFinite,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorVariables.primaryColor,
            ),
            onPressed: () {
              if (_formKey.currentState!.validate() &&
                  _mainImage != null &&
                  _stepList.isNotEmpty) {
                setState(() {
                  _recipeName = _fieldNameController.text.trim();
                  _recipeType = _recipeTypeFieldController.text.trim();
                  _isImageEmpty = false;
                  _isStepListEmpty = false;
                });
              } else {
                setState(() {
                  if (_mainImage == null) {
                    _isImageEmpty = true;
                  } else {
                    _isImageEmpty = false;
                  }

                  if (_stepList.isEmpty) {
                    _isStepListEmpty = true;
                  } else {
                    _isStepListEmpty = false;
                  }
                });
              }
            },
            child: Text(
              "Submit",
              style: TextStyle(
                color: ColorVariables.backgroundColor,
                fontSize: FontSizeVariables.h2Size,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
