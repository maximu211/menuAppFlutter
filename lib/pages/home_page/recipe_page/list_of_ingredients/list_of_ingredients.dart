import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/pages/home_page/card/card_icons_info.dart';
import 'package:menuapp/pages/common_components/user_row.dart';
import 'package:menuapp/pages/home_page/recipe_page/list_of_ingredients/ingredient.dart';
import 'package:menuapp/pages/home_page/recipe_page/list_of_ingredients/step_card.dart';
import 'package:menuapp/models/mappers.dart';
import 'package:menuapp/models/models.dart';

class IngredientList extends StatefulWidget {
  const IngredientList({Key? key, required this.cardRecipe}) : super(key: key);

  final CardRecipeModel cardRecipe;

  @override
  State<StatefulWidget> createState() => _IngredientListState();
}

class _IngredientListState extends State<IngredientList> {
  late BinaryFileReader binaryFileReader;
  late Uint8List binaryData;
  late Future<RecipeDescriptionElements> recipeDetail;

  @override
  void initState() {
    super.initState();
    recipeDetail = loadData();
  }

  Future<RecipeDescriptionElements> loadData() async {
    var data = await rootBundle.load('assets/images/recipe_images/1.jpg');
    setState(() => binaryData = data.buffer.asUint8List());

    return RecipeDescriptionElements(
      recipeDescriptionElements: [
        RecipeDescriptionElement(
          recipeDescriptionElementText:
              "asd jasd asd gka guadsg da gasd gjka gsd jkasd kagjksd gjkasd gjk agjkasg jksad gjda gjkda gjkasd gjkasd  gjksad gjksad  gjksadsad gjsad gjads gjads gjksad gukas gkuas gjkasdgjk a jkgads gjk",
          recipeDescriptionImage: binaryData,
        ),
        RecipeDescriptionElement(
          recipeDescriptionElementText:
              "asd jasd asd gka guadsg da gasd gjka gsd jkasd kagjksd gjkasd gjk agjkasg jksad gjda gjkda gjkasd gjkasd  gjksad gjksad  gjksadsad gjsad gjads gjads gjksad gukas gkuas gjkasdgjk a jkgads gjk",
          recipeDescriptionImage: binaryData,
        ),
        RecipeDescriptionElement(
          recipeDescriptionElementText:
              "asd jasd asd gka guadsg da gasd gjka gsd jkasd kagjksd gjkasd gjk agjkasg jksad gjda gjkda gjkasd gjkasd  gjksad gjksad  gjksadsad gjsad gjads gjads gjksad gukas gkuas gjkasdgjk a jkgads gjk",
        ),
      ],
      recipeIngradient: [
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
              widget.cardRecipe.name,
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
                  userName: widget.cardRecipe.user.userName,
                  image: widget.cardRecipe.user.userImage,
                  textColor: Colors.black,
                ),
              ],
            ),
            CardIconsInfo(
              textHardness:
                  Mapper.mapHardnessToText(widget.cardRecipe.cookingDifficulty),
              textTime: Mapper.mapTimeToText(widget.cardRecipe.cookingTime),
              textType: widget.cardRecipe.recipeType,
              iconColor: Colors.black,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: FutureBuilder<RecipeDescriptionElements>(
                future: recipeDetail,
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
                            itemCount: snapshot.data!.recipeIngradient.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final item =
                                  snapshot.data!.recipeIngradient[index];
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
                              snapshot.data!.recipeDescriptionElements.length,
                          itemBuilder: (context, index) {
                            final step =
                                snapshot.data!.recipeDescriptionElements[index];
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
