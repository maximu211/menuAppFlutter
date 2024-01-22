import 'package:flutter/material.dart';
import 'package:menuapp/add_page/form/form_components/dropdown_picker.dart';
import 'package:menuapp/add_page/form/form_components/from_input_field.dart';
import 'package:menuapp/models/models.dart';

class AdditionalInformationForm extends StatefulWidget {
  const AdditionalInformationForm({
    super.key,
    required this.fieldController,
    required this.maxLenght,
    required this.validator,
  });

  final TextEditingController fieldController;
  final int maxLenght;
  final String? Function(String?) validator;

  @override
  State<AdditionalInformationForm> createState() =>
      _AdditionalInformationFormState();
}

class _AdditionalInformationFormState extends State<AdditionalInformationForm> {
  CookingTime? selectedCookingTime;
  CookingDifficulty? selectedDishHardness;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          FormInputField(
            filedController: widget.fieldController,
            inputLabel: 'Input dish type',
            maxLenght: widget.maxLenght,
            validator: widget.validator,
          ),
          Column(
            children: [
              DropDownPicker<CookingTime>(
                isTime: true,
                onChange: (CookingTime? selectedValue) {
                  setState(() {
                    selectedCookingTime = selectedValue;
                  });
                },
              ),
              const SizedBox(height: 20),
              DropDownPicker<CookingDifficulty>(
                isTime: false,
                onChange: (CookingDifficulty? selectedValue) {
                  setState(() {
                    selectedDishHardness = selectedValue;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
