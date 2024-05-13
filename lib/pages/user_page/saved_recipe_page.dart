import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/models/models.dart';
import 'package:menuapp/pages/home_page/card/card.dart';

class SavedRecipesPage extends StatefulWidget {
  const SavedRecipesPage({super.key});

  @override
  State<SavedRecipesPage> createState() => _SavedRecipesPageState();
}

class _SavedRecipesPageState extends State<SavedRecipesPage> {
  late BinaryFileReader binaryFileReader;
  late Uint8List binaryData;
  late Future<List<CardRecipeModel>> cardRecipesFuture;

  @override
  void initState() {
    super.initState();
    cardRecipesFuture = loadData();
  }

  Future<List<CardRecipeModel>> loadData() async {
    var data = await rootBundle.load('assets/images/recipe_images/1.jpg');
    setState(() => binaryData = data.buffer.asUint8List());
    return [
      CardRecipeModel(
        user: UserModel(
            userName: "John_Lennon", userImage: binaryData, userId: '12'),
        cookingDifficulty: CookingDifficulty.medium,
        cookingTime: CookingTime.hour1,
        recipeType: "Drink",
        name: 'Cocktail "Cool guy"',
        recipeImage: "binaryData",
        isRecipeSaved: true,
        likesCount: 140,
        isRecipeLiked: false,
        isOwner: true,
        id: 'фів',
      ),
    ];
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
          child: FutureBuilder<List<CardRecipeModel>>(
            future: cardRecipesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final cardRecipe = snapshot.data![index];
                    return Column(
                      children: [
                        MainPageCard(cardRecipe: cardRecipe),
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
