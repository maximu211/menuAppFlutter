import 'package:flutter/material.dart';
import 'package:menuapp/add_page/form/form_components/form_card_button.dart';
import 'package:menuapp/add_page/form/form_components/image_picker/image_picker.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/home_page/receipt_page/list_of_ingredients/step_card.dart';
import 'package:menuapp/models/models.dart';

class StepCardWithButtons extends StepCard {
  const StepCardWithButtons({
    Key? key,
    required ReceiptDescriptionElement step,
    required int stepIndex,
  }) : super(key: key, step: step, stepIndex: stepIndex);

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
              super.build(context),
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
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                child: Column(
                                  children: [
                                    ImagePickerContainer(
                                      image: step.receiptDescriptionPhoto,
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: FormCardButton(
                        isColorMain: false,
                        icon: Icons.delete,
                        label: "Delete",
                        onPressed: () {},
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
