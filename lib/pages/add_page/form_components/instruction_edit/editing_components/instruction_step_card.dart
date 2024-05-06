import 'package:flutter/material.dart';

import 'package:menuapp/pages/add_page/form_components/form_card_button.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/page_transition_animation.dart';
import 'package:menuapp/pages/home_page/recipe_page/list_of_ingredients/step_card.dart';
import 'package:menuapp/http/DTOs/models.dart';

class StepCardWithButtons extends StatefulWidget {
  const StepCardWithButtons({
    super.key,
    required this.step,
    required this.stepIndex,
    this.onPressedDeleteButton,
  });

  final RecipeDescriptionElement step;
  final int stepIndex;
  final void Function()? onPressedDeleteButton;

  @override
  State<StepCardWithButtons> createState() => _StepCardWithButtonsState();
}

class _StepCardWithButtonsState extends State<StepCardWithButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: ColorVariables.primaryColor,
            boxShadow: const [BoxShadow(color: Colors.black, blurRadius: 2)],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StepCard(step: widget.step, stepIndex: widget.stepIndex),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: FormCardButton(
                        isColorMain: false,
                        icon: Icons.create,
                        label: "Edit",
                        onPressed: () {
                          Navigator.push(
                            context,
                            createRoute(
                              pageType: 'editStepPage',
                              step: widget.step,
                              stepNum: widget.stepIndex,
                            ),
                          ).then((_) {
                            setState(() {});
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: FormCardButton(
                        isColorMain: false,
                        icon: Icons.delete,
                        label: "Delete",
                        onPressed: widget.onPressedDeleteButton,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
