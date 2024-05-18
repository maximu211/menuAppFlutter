import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/global_variables/icon_size_variables.dart';
import 'package:menuapp/models/models.dart';
import 'package:menuapp/pages/authorization/log_in_page/log_in_page.dart';
import 'package:menuapp/pages/common_components/image_picker/photo_button.dart';
import 'package:menuapp/pages/common_components/toggle_icon_button.dart';
import 'package:menuapp/pages/home_page/card/card.dart';
import 'package:menuapp/pages/user_page/saved_recipe_page.dart';
import 'package:menuapp/pages/user_page/subs_list_page.dart';
import 'package:menuapp/utils/secure_storage.dart';

class UserPage extends StatefulWidget {
  final bool isCurrentUser = true;
  final String userName = "asdasdasdsasadsad";
  final int subsCount = 100;
  final int subsToCount = 20;
  final int postCount = 12;

  const UserPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _UserPageState();
  }
}

class _UserPageState extends State<UserPage> {
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
        recipeImage: "binaryData",
        isRecipeSaved: true,
        likesCount: 140,
        isRecipeLiked: false,
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
        recipeImage: "",
        isRecipeSaved: true,
        likesCount: 140,
        isRecipeLiked: false,
        isOwner: false,
      ),
    ];
  }

  Future<void> refreshData() async {
    // Виконати оновлення даних тут
    // Повернути майбутнє, яке вказує на завершення оновлення
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refreshData,
      child: CustomScrollView(
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
            title: widget.isCurrentUser
                ? GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: ColorVariables.primaryColor,
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BottomModalButton(
                                  icon: Icons.person,
                                  onPressed: () {
                                    print("object");
                                  },
                                  buttonText: "Update profile",
                                ),
                                BottomModalButton(
                                  icon: Icons.bookmark_rounded,
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SavedRecipesPage(userId: ,)));
                                  },
                                  buttonText: "Gallery",
                                ),
                                BottomModalButton(
                                  icon: Icons.exit_to_app,
                                  onPressed: () {
                                    SecureStorage().storage.deleteAll();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginPage()));
                                  },
                                  buttonText: "Log out",
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          widget.userName,
                          style: TextStyle(
                            color: ColorVariables.backgroundColor,
                            fontSize: FontSizeVariables.h1Size,
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down_sharp,
                          size: IconSizeVariables.bigSize,
                          color: ColorVariables.backgroundColor,
                        )
                      ],
                    ),
                  )
                : Text(
                    widget.userName,
                    style: TextStyle(color: ColorVariables.backgroundColor),
                  ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorVariables.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(color: Colors.black, blurRadius: 5)
                    ],
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipOval(
                                    child: Image.memory(
                                      binaryData,
                                      fit: BoxFit.cover,
                                      width: 75,
                                      height: 75,
                                    ),
                                  ),
                                  Text(
                                    widget.userName,
                                    softWrap: true,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      color: ColorVariables.backgroundColor,
                                      fontSize: FontSizeVariables.h1Size,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              flex: 6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Post count: ${widget.postCount}",
                                    style: TextStyle(
                                      color: ColorVariables.backgroundColor,
                                      fontSize: FontSizeVariables.h1Size,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SubsListPage(
                                            isSubscribersPage: true,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Subscribers: ${widget.subsCount}",
                                      style: TextStyle(
                                        color: ColorVariables.backgroundColor,
                                        fontSize: FontSizeVariables.h1Size,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SubsListPage(
                                            isSubscribersPage: false,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Subscribed to: ${widget.subsToCount}",
                                      style: TextStyle(
                                        color: ColorVariables.backgroundColor,
                                        fontSize: FontSizeVariables.h1Size,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        !widget.isCurrentUser
                            ? ElevatedToggleButton(
                                buttonToggledText: "Unsubscribe",
                                buttonUntoggledText: "Subscribe",
                                isButtonToggled: true,
                                onTap: (newState) {},
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
                Container(
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
