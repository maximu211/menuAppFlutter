import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:menuapp/add_page/form/form_components/form_card_button.dart';
import 'package:menuapp/add_page/form/form_components/from_input_field.dart';
import 'package:menuapp/add_page/form/form_components/image_picker/image_picker.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/global_variables/modal_dialog.dart';
import 'package:menuapp/models/models.dart';

class StepUpdatePage extends StatelessWidget {
  StepUpdatePage({super.key, required this.step, required this.stepNum});

  final ReceiptDescriptionElement step;
  final int stepNum;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: ColorVariables.primaryColor,
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
                  onPressed: () {},
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
        )
      ],
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
                  "Step ${stepNum}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: FontSizeVariables.h2Size,
                  ),
                ),
                const SizedBox(height: 20),
                ImagePickerContainer(
                  image: step.receiptDescriptionPhoto,
                  onImageChanged: (image) {
                    step.receiptDescriptionPhoto = image;
                  },
                ),
                const SizedBox(height: 30),
                FormInputField(
                  maxLenght: 600,
                  validator: (value) {},
                  inputLabel: "Instruction description",
                  initTextfieldValue: step.receiptDescriptionElementText,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
