import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/home_page/components/user_row.dart';
import 'package:menuapp/home_page/card/card_icons_info.dart';
import 'package:menuapp/home_page/receipt_page/list_of_ingredients/ingredient.dart';
import 'package:menuapp/home_page/receipt_page/list_of_ingredients/step_card.dart';
import 'package:menuapp/models/models.dart';

class IngredientList extends StatefulWidget {
  const IngredientList({super.key, required this.cardReceipt});

  final CardReceiptModel cardReceipt;

  @override
  State<StatefulWidget> createState() => _IngredientList();
}

class _IngredientList extends State<IngredientList> {
  ReceiptDetailModel receiptDetailModel = ReceiptDetailModel(
    receiptDescriptionElemens: [
      ReceiptDescriptionElement(
          receiptDescriptionElementText:
              "asd jasd asd gka guadsg da gasd gjka gsd jkasd kagjksd gjkasd gjk agjkasg jksad gjda gjkda gjkasd gjkasd  gjksad gjksad  gjksadsad gjsad gjads gjads gjksad gukas gkuas gjkasdgjk a jkgads gjk",
          receiptDescriptionPhoto: 'assets/images/dish_images/4.jpg'),
      ReceiptDescriptionElement(
          receiptDescriptionElementText:
              "asd jasd asd gka guadsg da gasd gjka gsd jkasd kagjksd gjkasd gjk agjkasg jksad gjda gjkda gjkasd gjkasd  gjksad gjksad  gjksadsad gjsad gjads gjads gjksad gukas gkuas gjkasdgjk a jkgads gjk",
          receiptDescriptionPhoto: 'assets/images/dish_images/2.jpg'),
      ReceiptDescriptionElement(
        receiptDescriptionElementText:
            "asd jasd asd gka guadsg da gasd gjka gsd jkasd kagjksd gjkasd gjk agjkasg jksad gjda gjkda gjkasd gjkasd  gjksad gjksad  gjksadsad gjsad gjads gjads gjksad gukas gkuas gjkasdgjk a jkgads gjk",
      ),
    ],
    receiptIngradient: [
      "qwe dllfffs s asdddsa, 121g",
      "qwesa sa sssaasas, 121g",
      "qwesda d sad as, 12g",
      "qwe asdsdas saas, 532g",
      "qwe fdg dfg dfdd , 421g",
    ],
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      primary: true,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Text(
                  widget.cardReceipt.dishName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: FontSizeVariables.h1Size,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UserRow(
                      userName: widget.cardReceipt.user.userName,
                      photoPath: widget.cardReceipt.user.userPhoto,
                      textColor: Colors.black,
                    )
                  ],
                ),
                CardIconsInfo(
                    textTime: widget.cardReceipt.cookTime,
                    textHardness: widget.cardReceipt.cookHardness,
                    textType: widget.cardReceipt.cookType,
                    iconColor: Colors.black)
              ],
            ),
          ),
          Text("Ingredients",
              style: TextStyle(
                  fontSize: FontSizeVariables.h2Size,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: ColorVariables.primaryColor,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 2,
                  )
                ]),
            child: ListView.builder(
              itemCount: receiptDetailModel.receiptIngradient.length,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final item = receiptDetailModel.receiptIngradient[index];
                return Ingredient(ingradient: item);
              },
            ),
          ),
          const SizedBox(height: 20),
          Text("Instruction",
              style: TextStyle(
                  fontSize: FontSizeVariables.h2Size,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: receiptDetailModel.receiptDescriptionElemens.length,
            itemBuilder: (context, index) {
              ReceiptDescriptionElement step =
                  receiptDetailModel.receiptDescriptionElemens[index];
              int stepIndex = index + 1;

              return StepCard(step: step, stepIndex: stepIndex);
            },
          )
        ],
      ),
    );
  }
}
