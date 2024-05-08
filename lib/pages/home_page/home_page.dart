import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/pages/home_page/card/card.dart';
import 'package:menuapp/http/DTOs/models.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        recipeImage: binaryData,
        isRecipeSaved: true,
        likesCount: 140,
        isRecipeLiked: false,
        recipeId: '21',
        isOwner: false,
        id: 'фів',
      ),
      CardRecipeModel(
        user: UserModel(
            userName: "John_Lennon", userImage: binaryData, userId: '12'),
        cookingDifficulty: CookingDifficulty.medium,
        cookingTime: CookingTime.hour1,
        recipeType: "Drink",
        name: 'Cocktail "Cool guy"',
        recipeImage: binaryData,
        isRecipeSaved: true,
        likesCount: 140,
        isRecipeLiked: false,
        recipeId: '21',
        isOwner: false,
        id: 'фів',
      ),
      CardRecipeModel(
        id: 'фів',
        user: UserModel(
            userName: "John_Lennon", userImage: binaryData, userId: '12'),
        cookingDifficulty: CookingDifficulty.medium,
        cookingTime: CookingTime.hour1,
        recipeType: "Drink",
        name: 'Cocktail "Cool guy"',
        recipeImage: binaryData,
        isRecipeSaved: true,
        likesCount: 140,
        isRecipeLiked: false,
        recipeId: '21',
        isOwner: false,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: ColorVariables.primaryColor),
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
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
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
      ],
    );
  }
}
