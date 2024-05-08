import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/icon_size_variables.dart';
import 'package:menuapp/pages/common_components/toggle_button.dart';
import 'package:menuapp/pages/home_page/recipe_page/list_of_ingredients/list_of_ingredients.dart';
import 'package:menuapp/http/DTOs/models.dart';
import 'comments/comments_page.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key, required this.cardRecipe});

  final CardRecipeModel cardRecipe;

  @override
  State<StatefulWidget> createState() {
    return _RecipePage();
  }
}

class _RecipePage extends State<RecipePage> {
  int _currentIndex = 0;

  Widget renderScreen(int index) {
    switch (index) {
      case 0:
        return IngredientList(cardRecipe: widget.cardRecipe);
      case 1:
        return const CommentsPage();
      default:
        return const Text('Невідомий екран');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorVariables.backgroundColor,
      bottomNavigationBar: NavigationBar(
          backgroundColor: ColorVariables.backgroundColor,
          indicatorColor: ColorVariables.primaryColor,
          destinations: [
            NavigationDestination(
                icon: Icon(
                  Icons.format_list_bulleted,
                  size: IconSizeVariables.regularSize,
                ),
                label: ''),
            NavigationDestination(
                icon: Icon(
                  Icons.comment,
                  size: IconSizeVariables.regularSize,
                ),
                label: ''),
          ],
          selectedIndex: _currentIndex,
          onDestinationSelected: (int index) {
            setState(() {
              _currentIndex = index;
            });
          }),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: false,
                pinned: true,
                snap: false,
                automaticallyImplyLeading: true,
                expandedHeight: MediaQuery.of(context).size.height * 0.5,
                backgroundColor: ColorVariables.primaryColor,
                actions: [
                  Positioned(
                      right: 16,
                      top: 16,
                      child: SaveButton(
                        onTap: (newState) {
                          setState(
                            () {
                              widget.cardRecipe.isRecipeSaved = newState;
                            },
                          );
                        },
                        buttonToggledText: 'recipe saved to your galery 😀',
                        buttonUntoggledText:
                            'recipe deleted from your galery 😢',
                        isButtonToggled: widget.cardRecipe.isRecipeSaved,
                      ))
                ],
                leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: ColorVariables.backgroundColor,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.memory(widget.cardRecipe.recipeImage,
                      fit: BoxFit.cover),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: renderScreen(_currentIndex),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
