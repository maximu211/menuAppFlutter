import 'dart:typed_data';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:menuapp/pages/add_page/form_components/form_card_button.dart';
import 'package:menuapp/pages/common_components/form_input_field.dart';
import 'package:menuapp/pages/common_components/image_picker/image_picker.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/global_variables/dialog_utils.dart';
import 'package:menuapp/http/DTOs/models.dart';

class StepUpdatePage extends StatefulWidget {
  const StepUpdatePage({super.key, required this.step, required this.stepNum});

  final RecipeDescriptionElement step;
  final int stepNum;

  @override
  State<StepUpdatePage> createState() => _StepUpdatePageState();
}

class _StepUpdatePageState extends State<StepUpdatePage> {
  late Uint8List? _pickedImage;
  late RecipeDescriptionElement _editedStep;

  final TextEditingController _textEditingController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _editedStep = widget.step;
    _textEditingController.text = _editedStep.recipeDescriptionElementText;
    _pickedImage = widget.step.recipeDescriptionPhoto;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: ColorVariables.primaryColor,
      ),
      body: SingleChildScrollView(
        dragStartBehavior: DragStartBehavior.down,
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Step ${widget.stepNum}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: FontSizeVariables.h2Size,
                  ),
                ),
                const SizedBox(height: 20),
                ImagePickerContainer(
                  image: _pickedImage,
                  onImageChanged: (image) {
                    setState(() {
                      _pickedImage = image;
                    });
                  },
                ),
                const SizedBox(height: 30),
                FormInputField(
                  maxLenght: 600,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Instruction description is required";
                    }
                    return null;
                  },
                  inputLabel: "Instruction description",
                  filedController: _textEditingController,
                ),
              ],
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        Container(
          margin: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: FormCardButton(
                  icon: Icons.save,
                  label: "Save",
                  isColorMain: true,
                  onPressed: () {
                    setState(() {
                      if (_formKey.currentState!.validate()) {
                        _editedStep.recipeDescriptionElementText =
                            _textEditingController.text.trim();
                        widget.step.recipeDescriptionPhoto = _pickedImage;

                        widget.step.recipeDescriptionElementText =
                            _editedStep.recipeDescriptionElementText;
                        widget.step.recipeDescriptionPhoto =
                            _editedStep.recipeDescriptionPhoto;
                        Navigator.pop(context, widget.step);
                      }
                    });
                  },
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: FormCardButton(
                  icon: Icons.cancel,
                  label: "Cancel",
                  isColorMain: true,
                  onPressed: () => DialogUtils.showLeavePageDialog(
                    context: context,
                    cancelFunc: () {
                      Navigator.pop(context);
                    },
                    description:
                        "If you leave the page, the data will not be saved",
                    okFunc: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    title: "Do you want to leave the page?",
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
