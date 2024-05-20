import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/http/DTOs/dtos.dart';
import 'package:menuapp/http/recipe_requests/recipe_requests.dart';
import 'package:menuapp/pages/home_page/card/card.dart';

class SavedRecipesPage extends StatefulWidget {
  const SavedRecipesPage({super.key, required this.userId});

  final String userId;

  @override
  State<SavedRecipesPage> createState() => _SavedRecipesPageState();
}

class _SavedRecipesPageState extends State<SavedRecipesPage> {
  late Future<CardRecipeDto> _savedRecipesFuture;

  @override
  void initState() {
    super.initState();
    _savedRecipesFuture = _loadSavedRecipes();
  }

  Future<CardRecipeDto> _loadSavedRecipes() async {
    return await RecipeRequests.getSavedRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: ColorVariables.backgroundColor,
        ),
        backgroundColor: ColorVariables.primaryColor,
        title: Text(
          "Your saved recipes",
          style: TextStyle(color: ColorVariables.backgroundColor),
        ),
      ),
      backgroundColor: ColorVariables.backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: FutureBuilder<CardRecipeDto>(
            future: _savedRecipesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.data!.recipeList.isEmpty) {
                return Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: ColorVariables.primaryColor,
                      boxShadow: const [
                        BoxShadow(color: Colors.black, blurRadius: 2)
                      ],
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      textAlign: TextAlign.center,
                      "You have no saved posts yet 😐",
                      style: TextStyle(
                        color: ColorVariables.backgroundColor,
                        fontSize: FontSizeVariables.h2Size,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.recipeList.length,
                  itemBuilder: (context, index) {
                    final cardRecipe = snapshot.data!.recipeList[index];
                    return Column(
                      children: [
                        MainPageCard(
                          cardRecipe: cardRecipe,
                          onDeleteFromSaved: (deleteFromSavedMap) {
                            if (!deleteFromSavedMap.values.first) {
                              setState(() {
                                snapshot.data!.recipeList.removeWhere(
                                    (recipe) =>
                                        recipe.id ==
                                        deleteFromSavedMap.keys.first);
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
