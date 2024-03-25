
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/pages/home_page/card/card_icons_info.dart';
import 'package:menuapp/pages/home_page/components/user_row.dart';
import 'package:menuapp/pages/home_page/receipt_page/list_of_ingredients/ingredient.dart';
import 'package:menuapp/pages/home_page/receipt_page/list_of_ingredients/step_card.dart';
import 'package:menuapp/models/mappers.dart';
import 'package:menuapp/models/models.dart';

class IngredientList extends StatefulWidget {
  const IngredientList({Key? key, required this.cardReceipt}) : super(key: key);

  final CardReceiptModel cardReceipt;

  @override
  State<StatefulWidget> createState() => _IngredientListState();
}

class _IngredientListState extends State<IngredientList> {
  late BinaryFileReader binaryFileReader;
  late Uint8List binaryData;
  late Future<ReceiptDetailModel> receiptDetail;

  @override
  void initState() {
    super.initState();
    receiptDetail = loadData();
  }

  Future<ReceiptDetailModel> loadData() async {
    var data = await rootBundle.load('assets/images/dish_images/1.jpg');
    setState(() => binaryData = data.buffer.asUint8List());

    return ReceiptDetailModel(
      receiptDescriptionElements: [
        ReceiptDescriptionElement(
          receiptDescriptionElementText:
              "asd jasd asd gka guadsg da gasd gjka gsd jkasd kagjksd gjkasd gjk agjkasg jksad gjda gjkda gjkasd gjkasd  gjksad gjksad  gjksadsad gjsad gjads gjads gjksad gukas gkuas gjkasdgjk a jkgads gjk",
          receiptDescriptionPhoto: binaryData,
        ),
        ReceiptDescriptionElement(
          receiptDescriptionElementText:
              "asd jasd asd gka guadsg da gasd gjka gsd jkasd kagjksd gjkasd gjk agjkasg jksad gjda gjkda gjkasd gjkasd  gjksad gjksad  gjksadsad gjsad gjads gjads gjksad gukas gkuas gjkasdgjk a jkgads gjk",
          receiptDescriptionPhoto: binaryData,
        ),
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
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      primary: true,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.cardReceipt.dishName,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: FontSizeVariables.h1Size,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UserRow(
                  userName: widget.cardReceipt.user.userName,
                  image: widget.cardReceipt.user.userPhoto,
                  textColor: Colors.black,
                ),
              ],
            ),
            CardIconsInfo(
              textHardness:
                  Mapper.mapHardnessToText(widget.cardReceipt.cookDifficulty),
              textTime: Mapper.mapTimeToText(widget.cardReceipt.cookTime),
              textType: widget.cardReceipt.cookType,
              iconColor: Colors.black,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: FutureBuilder<ReceiptDetailModel>(
                future: receiptDetail,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          "Ingredients",
                          style: TextStyle(
                            fontSize: FontSizeVariables.h2Size,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: ColorVariables.primaryColor,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: ListView.builder(
                            itemCount: snapshot.data!.receiptIngradient.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final item =
                                  snapshot.data!.receiptIngradient[index];
                              return Ingredient(ingradient: item);
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Instruction",
                          style: TextStyle(
                            fontSize: FontSizeVariables.h2Size,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              snapshot.data!.receiptDescriptionElements.length,
                          itemBuilder: (context, index) {
                            final step = snapshot
                                .data!.receiptDescriptionElements[index];
                            int stepIndex = index + 1;

                            return StepCard(
                              step: step,
                              stepIndex: stepIndex,
                            );
                          },
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
