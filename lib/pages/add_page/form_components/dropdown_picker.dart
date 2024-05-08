import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/models/mappers.dart';

import 'package:menuapp/models/models.dart';

class DropdownPicker<T> extends StatefulWidget {
  const DropdownPicker({Key? key, required this.onChange, required this.isTime})
      : super(key: key);

  final void Function(T?) onChange;
  final bool isTime;

  @override
  State<DropdownPicker<T>> createState() => _DropdownPickerState<T>();
}

class _DropdownPickerState<T> extends State<DropdownPicker<T>> {
  late T selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.isTime
        ? CookingTime.lessThan15min as T
        : CookingDifficulty.easy as T;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.isTime
            ? "How long to cook this recipe?"
            : "How difficult is it to cook?"),
        const SizedBox(height: 6),
        DropdownButtonFormField<T>(
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromARGB(30, 255, 115, 0),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: ColorVariables.backgroundColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: ColorVariables.primaryColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
          borderRadius: BorderRadius.circular(20),
          dropdownColor: const Color.fromARGB(255, 255, 115, 0),
          value: selectedValue,
          onChanged: (T? newValue) {
            setState(() {
              selectedValue = newValue ??
                  (widget.isTime
                      ? CookingTime.lessThan15min as T
                      : CookingDifficulty.easy as T);
            });
            widget.onChange(newValue);
          },
          items: widget.isTime
              ? CookingTime.values.map((CookingTime value) {
                  return DropdownMenuItem<T>(
                    value: value as T,
                    child: Text(
                      Mapper.mapTimeToText(value),
                      style: const TextStyle(color: Colors.black),
                    ),
                  );
                }).toList()
              : CookingDifficulty.values.map((CookingDifficulty value) {
                  return DropdownMenuItem<T>(
                    value: value as T,
                    child: Text(
                      Mapper.mapHardnessToText(value),
                      style: const TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
        ),
      ],
    );
  }
}
