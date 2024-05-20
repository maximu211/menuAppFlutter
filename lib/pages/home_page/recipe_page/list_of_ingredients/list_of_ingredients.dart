import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/http/DTOs/dtos.dart';
import 'package:menuapp/http/recipe_requests/recipe_requests.dart';
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
  late Future<RecipeDescriptionElementsDto> _recipeDetailsFuture;

  @override
  void initState() {
    super.initState();
    _recipeDetailsFuture =
        RecipeRequests.getRecipeDetails(widget.cardRecipe.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RecipeDescriptionElementsDto>(
      future: _recipeDetailsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No data available'));
        } else {
          final recipeDetail = snapshot.data!.recipeDescElements;
          final recipeIngredients = snapshot.data!.recipeIngradients;

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
                        userId: widget.cardRecipe.user.userId,
                        userName: widget.cardRecipe.user.userName,
                        image: widget.cardRecipe.user.userImage,
                        textColor: Colors.black,
                      ),
                    ],
                  ),
                  CardIconsInfo(
                    textHardness: Mapper.mapHardnessToText(
                        widget.cardRecipe.cookingDifficulty),
                    textTime:
                        Mapper.mapTimeToText(widget.cardRecipe.cookingTime),
                    textType: widget.cardRecipe.recipeType,
                    iconColor: Colors.black,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
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
                            itemCount: recipeIngredients.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final item = recipeIngredients[index];
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
                          itemCount: recipeDetail.length,
                          itemBuilder: (context, index) {
                            final step = recipeDetail[index];
                            int stepIndex = index + 1;

                            return StepCard(
                              step: step,
                              stepIndex: stepIndex,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
