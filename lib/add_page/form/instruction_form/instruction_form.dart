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

  @override
  void initState() {
    super.initState();
    _loadBinaryData();
  }

  Future<void> _loadBinaryData() async {
    binaryFileReader = BinaryFileReader('assets/images/dish_images/image.bin');
    binaryData = await binaryFileReader.readBinaryFile();
    if (mounted) {
      setState(() {
        // Set the state with the loaded binary data
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            StepCardWithButtons(
              step: ReceiptDescriptionElement(
                receiptDescriptionElementText: "asdasda",
                receiptDescriptionPhoto: binaryData,
              ),
              stepIndex: 1,
            ),
            FormCardButton(
              onPressed: () {},
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
