import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/http/recipe_requests/recipe_requests.dart';
import 'package:menuapp/pages/home_page/card/card.dart';
import 'package:menuapp/models/models.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CardRecipeModel>? cardRecipes;

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    try {
      var result = await RecipeRequests.getRecipesBySubs();
      setState(() {
        cardRecipes = result.recipeList;
      });
    } catch (error) {
      print('Error loading recipes: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: ColorVariables.primaryColor),
            floating: true,
            pinned: false,
            snap: true,
            automaticallyImplyLeading: false,
            backgroundColor: ColorVariables.primaryColor,
            shadowColor: Colors.black,
            leading: Image.asset(
              "assets/images/logo.png",
              color: ColorVariables.backgroundColor,
            ),
            title: Text(
              'Cool App Name',
              style: TextStyle(
                color: ColorVariables.backgroundColor,
                fontSize: FontSizeVariables.h1Size,
              ),
            ),
          ),
          cardRecipes == null
              ? const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      final cardRecipe = cardRecipes![index];
                      return Container(
                        margin: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            MainPageCard(cardRecipe: cardRecipe),
                            const SizedBox(height: 20),
                          ],
                        ),
                      );
                    },
                    childCount: cardRecipes!.length,
                  ),
                ),
        ],
      ),
    );
  }
}
