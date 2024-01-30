import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menuapp/add_page/form_components/dropdown_picker.dart';
import 'package:menuapp/add_page/form_components/form_input_field.dart';
import 'package:menuapp/add_page/form_components/image_picker/image_picker.dart';
import 'package:menuapp/add_page/form_components/instruction_edit/instruction_form.dart';
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
  static int maxLenghtDishType = 30;
}

class _AddPage extends State<AddPage> {
  late Uint8List? mainImage = null;
  late String dishType;
  late CookingTime? dishCookTime;
  late CookingDifficulty? dishHardness;
  late List<ReceiptDescriptionElement> stepList = [];

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
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              FormInputField(
                inputLabel: 'Input dish name',
                filedController: _fieldNameController,
                maxLenght: 50,
                validator: (value) {
                  return;
                },
              ),
              const SizedBox(height: 15),
              ImagePickerContainer(
                image: mainImage,
                onImageChanged: (image) {
                  setState(() {
                    mainImage = image;
                  });
                },
              ),
              const SizedBox(height: 20),
              FormInputField(
                filedController: _dishTypeFieldController,
                inputLabel: 'Input dish type',
                maxLenght: FiledMaxLenght.maxLenghtDishType,
                validator: (value) {
                  return;
                },
              ),
              DropdownPicker<CookingTime>(
                isTime: true,
                onChange: (CookingTime? selectedValue) {
                  setState(() {
                    dishCookTime = selectedValue;
                  });
                },
              ),
              const SizedBox(height: 20),
              DropdownPicker<CookingDifficulty>(
                isTime: false,
                onChange: (CookingDifficulty? selectedValue) {
                  setState(() {
                    dishHardness = selectedValue;
                  });
                },
              ),
              const SizedBox(height: 20),
              InstuctionForm(stepList: stepList)
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
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
    );
  }
}
