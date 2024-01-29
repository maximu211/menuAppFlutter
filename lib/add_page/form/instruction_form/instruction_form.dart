import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:menuapp/add_page/form/form_components/form_card_button.dart';
import 'package:menuapp/add_page/form/form_components/instruction_step_card/instruction_step_card.dart';
import 'package:menuapp/models/models.dart';

class InstuctionForm extends StatefulWidget {
  const InstuctionForm({super.key});

  @override
  State<InstuctionForm> createState() => _InstuctionFormState();
}

class _InstuctionFormState extends State<InstuctionForm> {
  late BinaryFileReader binaryFileReader;
  late Uint8List binaryData;
  late List<ReceiptDescriptionElement> stepList = [];

  @override
  void initState() {
    super.initState();
    _loadBinaryData();
  }

  Future<void> _loadBinaryData() async {
    binaryFileReader = BinaryFileReader('assets/images/dish_images/image.bin');
    binaryData = await binaryFileReader.readBinaryFile();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            stepList.isEmpty
                ? const SizedBox()
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: stepList.length,
                    itemBuilder: (context, index) {
                      final step = stepList[index];
                      final stepIndex = index + 1;

                      return Column(
                        children: [
                          StepCardWithButtons(
                            step: step,
                            stepIndex: stepIndex,
                            onPressedDeleteButton: () {
                              setState(() {
                                stepList.removeAt(index);
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
                  stepList.add(
                    ReceiptDescriptionElement(
                      receiptDescriptionElementText: "",
                      receiptDescriptionPhoto: null,
                    ),
                  );
                });
              },
              icon: Icons.add,
              label: 'Add new instruction step',
              isColorMain: true,
            ),
          ],
        ),
      ),
    );
  }
}
