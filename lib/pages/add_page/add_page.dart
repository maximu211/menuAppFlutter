// ignore_for_file: unused_field

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:menuapp/http/DTOs/DTOs.dart';
import 'package:menuapp/http/recipe_requests/recipe_requests.dart';
import 'package:menuapp/pages/add_page/form_components/dropdown_picker.dart';
import 'package:menuapp/pages/add_page/form_components/form_card_button.dart';
import 'package:menuapp/pages/common_components/form_input_field.dart';
import 'package:menuapp/pages/common_components/image_picker/image_picker.dart';
import 'package:menuapp/pages/add_page/form_components/instruction_edit/instruction_form.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/global_variables/dialog_utils.dart';
import 'package:menuapp/models/models.dart';

class AddPage extends StatefulWidget {
  AddPage(
      {super.key,
      required this.recipe,
      required this.isUpdate,
      required this.recipeId});

  String recipeId;
  bool isUpdate;
  RecipeNotifier recipe;

  @override
  State<StatefulWidget> createState() => _AddPage();
}

class FiledMaxLenght {
  static int maxLenghtrecipeName = 50;
  static int maxLenghtrecipeType = 30;
}

class _AddPage extends State<AddPage> {
  @override
  void initState() {
    _recipeTypeFieldController.text = widget.recipe.recipe.recipeType;
    _fieldNameController.text = widget.recipe.recipe.name;
    super.initState();
  }

  bool _isStepListEmpty = false;
  bool _isImageEmpty = false;
  bool _isIngredientListEmpty = false;

  final TextEditingController _fieldNameController = TextEditingController();
  final TextEditingController _recipeTypeFieldController =
      TextEditingController();
  final TextEditingController _ingredientFieldController =
      TextEditingController();

  final GlobalKey<FormState> _globalFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _ingredientFormKey = GlobalKey<FormState>();

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
            key: _globalFormKey,
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
                  image: widget.recipe.recipe.image != null
                      ? base64Decode(widget.recipe.recipe.image!)
                      : null,
                  onImageChanged: (image) {
                    setState(() {
                      if (image != null) {
                        widget.recipe.recipe.image = base64Encode(image);
                      } else {
                        widget.recipe.recipe.image = null;
                      }
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
                DropdownPicker<CookingDifficulty>(
                  isTime: false,
                  initialValue: widget.recipe.recipe.difficulty,
                  onChange: (CookingDifficulty? selectedValue) {
                    setState(() {
                      widget.recipe.recipe.difficulty = selectedValue!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                DropdownPicker<CookingTime>(
                  isTime: true,
                  initialValue:
                      widget.recipe.recipe.cookingTime, // Початкове значення
                  onChange: (CookingTime? selectedValue) {
                    setState(() {
                      widget.recipe.recipe.cookingTime = selectedValue!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                ExpansionTile(
                  title: const Text('Ingredients'),
                  children: [
                    ListView(
                      shrinkWrap: true,
                      children: [
                        for (var ingredient
                            in widget.recipe.recipe.recipeIngredients)
                          Row(
                            children: [
                              Text(ingredient),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  setState(() {
                                    widget.recipe.recipe.recipeIngredients
                                        .remove(ingredient);
                                  });
                                },
                              ),
                            ],
                          ),
                        Form(
                          key: _ingredientFormKey,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return "Please input ingredient";
                              } else {
                                return null;
                              }
                            },
                            controller: _ingredientFieldController,
                            decoration: const InputDecoration(
                                hintText: "Input ingredient and count"),
                          ),
                        ),
                        const SizedBox(height: 20),
                        FormCardButton(
                          onPressed: () {
                            if (_ingredientFormKey.currentState!.validate()) {
                              setState(() {
                                // Створення нового списку і додавання елементів зі старого списку
                                List<String> updatedIngredientsList = List.from(
                                    widget.recipe.recipe.recipeIngredients);
                                updatedIngredientsList
                                    .add(_ingredientFieldController.text);
                                widget.recipe.recipe.recipeIngredients =
                                    updatedIngredientsList;
                                _ingredientFieldController.text = "";
                              });
                            }
                          },
                          icon: Icons.add,
                          isColorMain: true,
                          label: "Add ingredient",
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ],
                ),
                _isIngredientListEmpty
                    ? const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 6),
                          Text(
                            "Please add at least one ingredient",
                            style: TextStyle(
                              color: Color.fromARGB(255, 180, 45, 12),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
                const SizedBox(height: 20),
                InstuctionForm(
                    stepList: widget.recipe.recipe.recipeDescElements),
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
              if (_globalFormKey.currentState!.validate() &&
                  widget.recipe.recipe.image != null &&
                  widget.recipe.recipe.recipeDescElements.isNotEmpty &&
                  widget.recipe.recipe.recipeIngredients.isNotEmpty) {
                setState(() {
                  widget.recipe.recipe.name = _fieldNameController.text.trim();
                  widget.recipe.recipe.recipeType =
                      _recipeTypeFieldController.text.trim();

                  widget.recipe.recipe.recipeDescElements;

                  if (widget.isUpdate) {
                    RecipeRequests.updateRecipe(
                        widget.recipeId, widget.recipe.recipe);
                  } else {
                    RecipeRequests.createRecipe(widget.recipe.recipe);
                  }

                  _isImageEmpty = false;
                  _isStepListEmpty = false;
                  _isIngredientListEmpty = false;
                });
              } else {
                setState(() {
                  if (widget.recipe.recipe.image == null) {
                    _isImageEmpty = true;
                  } else {
                    _isImageEmpty = false;
                  }

                  if (widget.recipe.recipe.recipeIngredients.isEmpty) {
                    _isIngredientListEmpty = true;
                  } else {
                    _isIngredientListEmpty = false;
                  }

                  if (widget.recipe.recipe.recipeDescElements.isEmpty) {
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
