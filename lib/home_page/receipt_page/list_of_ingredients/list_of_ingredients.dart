import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/home_page/components/user_row.dart';
import 'package:menuapp/home_page/card/card_icons_info.dart';
import 'package:menuapp/home_page/receipt_page/list_of_ingredients/ingredient.dart';
import 'package:menuapp/models/models.dart';

class IngredientList extends StatefulWidget {
  const IngredientList({super.key, required this.cardReceipt});

  final CardReceiptModel cardReceipt;

  @override
  State<StatefulWidget> createState() => _IngredientList();
}

class _IngredientList extends State<IngredientList> {
  ReceiptDetailModel receiptDetailModel = ReceiptDetailModel(
    receiptDescription:
        "asd as aasasdass sdasasda asdasa saasda asdasdas a asdasda sadsas asasd assda asdasdadsa asaadsaasd sdqwasadasd",
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
    return Center(
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
                  fontSize: FontSizeVariables.h2Size, fontWeight: FontWeight.bold)),
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
                return Column(
                  children: [
                    Ingredient(ingradient: item),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Text("Instructions",
              style: TextStyle(
                  fontSize: FontSizeVariables.h2Size, fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 20,
          ),
          Text(
            receiptDetailModel.receiptDescription,
            textAlign: TextAlign.justify,
          )
        ],
      ),
    );
  }
}
