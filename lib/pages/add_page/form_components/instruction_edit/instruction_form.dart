import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:menuapp/pages/add_page/form_components/form_card_button.dart';
import 'package:menuapp/pages/add_page/form_components/instruction_edit/editing_components/instruction_step_card.dart';
import 'package:menuapp/global_variables/page_transition_animation.dart';
import 'package:menuapp/http/DTOs/models.dart';

class InstuctionForm extends StatefulWidget {
  const InstuctionForm({super.key, required this.stepList});

  final List<RecipeDescriptionElement> stepList;

  @override
  State<InstuctionForm> createState() => _InstuctionFormState();
}

class _InstuctionFormState extends State<InstuctionForm> {
  late BinaryFileReader binaryFileReader;
  late Uint8List binaryData;

  @override
  void initState() {
    super.initState();
    _loadBinaryData();
  }

  Future<void> _loadBinaryData() async {
    binaryFileReader =
        BinaryFileReader('assets/images/recipe_images/image.bin');
    binaryData = await binaryFileReader.readBinaryFile();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          widget.stepList.isEmpty
              ? const SizedBox()
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.stepList.length,
                  itemBuilder: (context, index) {
                    final step = widget.stepList[index];
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
                  },
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
                  createRoute(
                    pageType: 'editStepPage',
                    step: newStep,
                    stepNum: widget.stepList.length + 1,
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
