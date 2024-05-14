// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:menuapp/pages/add_page/form_components/form_card_button.dart';
import 'package:menuapp/pages/add_page/form_components/instruction_edit/editing_components/instruction_step_card.dart';
import 'package:menuapp/global_variables/page_transition_animation.dart';
import 'package:menuapp/models/models.dart';

class InstuctionForm extends StatefulWidget {
  InstuctionForm({super.key, required this.stepList});

  late List<RecipeDescriptionElement> stepList;

  @override
  State<InstuctionForm> createState() => _InstuctionFormState();
}

class _InstuctionFormState extends State<InstuctionForm> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          widget.stepList.isEmpty
              ? const SizedBox()
              : ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: widget.stepList.map((step) {
                    final index = widget.stepList.indexOf(step);
                    final stepIndex = index + 1;

                    return Column(
                      children: [
                        StepCardWithButtons(
                          step: step,
                          stepIndex: stepIndex,
                          onPressedDeleteButton: () {
                            setState(() {
                              widget.stepList.removeAt(index);
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    );
                  }).toList(),
                ),
          FormCardButton(
            onPressed: () {
              setState(() {
                RecipeDescriptionElement newStep = RecipeDescriptionElement(
                  recipeDescriptionElementText: '',
                  recipeDescriptionImage: null,
                );

                Navigator.push(
                  context,
                  NavigationService.createEditStepPageRoute(
                    newStep,
                    widget.stepList.length + 1,
                  ),
                ).then((_) {
                  if (newStep.recipeDescriptionElementText.trim().isNotEmpty) {
                    setState(() {
                      widget.stepList.add(newStep);
                    });
                  }
                });
              });
            },
            icon: Icons.add,
            label: 'Add new instruction step',
            isColorMain: true,
          ),
        ],
      ),
    );
  }
}
