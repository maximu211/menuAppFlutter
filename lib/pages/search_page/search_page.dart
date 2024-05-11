import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/pages/common_components/user_card.dart';
import 'package:menuapp/pages/home_page/card/card.dart';
import 'package:menuapp/models/models.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();

  List<CardRecipeModel> _sortedrecipeList = [];
  List<UserModel> _sortedUserList = [];

  late BinaryFileReader binaryFileReader;
  late Uint8List binaryData;
  late List<CardRecipeModel> cardRecipeList;
  late List<UserModel> userList;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    var data = await rootBundle.load('assets/images/recipe_images/1.jpg');
    setState(() => binaryData = data.buffer.asUint8List());
    cardRecipeList = [
      CardRecipeModel(
        id: 'фів',
        user: UserModel(
            userName: "Name_Guttt", userImage: binaryData, userId: '12'),
        recipeId: "2",
        cookingDifficulty: CookingDifficulty.easy,
        cookingTime: CookingTime.min15,
        recipeType: "Drink",
        name: 'Cocktail "Cool guy"',
        recipeImage: binaryData,
        isRecipeSaved: false,
        likesCount: 140,
        isRecipeLiked: true,
        isOwner: false,
      ),
      CardRecipeModel(
        id: 'фів',
        user: UserModel(
            userName: "John_Lennon", userImage: binaryData, userId: '12'),
        cookingDifficulty: CookingDifficulty.medium,
        cookingTime: CookingTime.hour1,
        recipeType: "Drink",
        name: 'Name',
        recipeImage: binaryData,
        isRecipeSaved: true,
        likesCount: 140,
        isRecipeLiked: false,
        recipeId: '21',
        isOwner: false,
      ),
    ];

    userList = [
      UserModel(userName: "1", userImage: binaryData, userId: "userId"),
      UserModel(userName: "2", userImage: binaryData, userId: "userId"),
      UserModel(userName: "NAME", userImage: binaryData, userId: "userId"),
      UserModel(userName: "NAME", userImage: binaryData, userId: "userId"),
    ];
  }

  void listFiltering(String query) {
    setState(() {
      if (query.trim().isNotEmpty) {
        _sortedrecipeList = cardRecipeList
            .where((recipe) =>
                recipe.name.toLowerCase().contains(query.trim().toLowerCase()))
            .toList();

        _sortedUserList = userList
            .where((user) => user.userName
                .toLowerCase()
                .contains(query.trim().toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          foregroundColor: ColorVariables.backgroundColor,
          floating: true,
          pinned: true,
          snap: false,
          automaticallyImplyLeading: false,
          backgroundColor: ColorVariables.primaryColor,
          flexibleSpace: EasySearchBar(
            backgroundColor: ColorVariables.primaryColor,
            foregroundColor: ColorVariables.backgroundColor,
            elevation: 100,
            searchHintText: 'Soup, pizza e.t.c.',
            searchClearIconTheme: const IconThemeData(),
            searchCursorColor: ColorVariables.primaryColor,
            systemOverlayStyle: SystemUiOverlayStyle.light,
            onSearch: (query) {
              listFiltering(query);
              if (query.isEmpty) {
                _sortedrecipeList.clear();
                _sortedUserList.clear();
              }
            },
            title: Text(
              "What do you want to cook today?🤔",
              style: TextStyle(
                color: ColorVariables.backgroundColor,
                fontSize: FontSizeVariables.h1Size,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                _sortedUserList.isNotEmpty
                    ? Column(
                        children: [
                          Text(
                            "Users",
                            style: TextStyle(
                                color: ColorVariables.backgroundColor,
                                fontSize: FontSizeVariables.h2Size,
                                fontWeight: FontWeight.bold),
                          ),
                          ListView.builder(
                            itemCount: _sortedUserList.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final item = _sortedUserList[index];
                              return Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  UserCard(userModel: item),
                                ],
                              );
                            },
                          )
                        ],
                      )
                    : const SizedBox(),
                _sortedrecipeList.isNotEmpty
                    ? Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "recipes",
                            style: TextStyle(
                                color: ColorVariables.backgroundColor,
                                fontSize: FontSizeVariables.h2Size,
                                fontWeight: FontWeight.bold),
                          ),
                          ListView.builder(
                            itemCount: _sortedrecipeList.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final item = _sortedrecipeList[index];
                              return Column(
                                children: [
                                  MainPageCard(cardRecipe: item),
                                  const SizedBox(height: 20)
                                ],
                              );
                            },
                          ),
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
