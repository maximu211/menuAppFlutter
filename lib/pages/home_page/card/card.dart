import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/page_transition_animation.dart';
import 'package:menuapp/pages/common_components/toggle_button.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/global_variables/icon_size_variables.dart';
import 'package:menuapp/models/mappers.dart';
import 'package:menuapp/models/models.dart';
import 'package:menuapp/pages/common_components/user_row.dart';
import 'package:menuapp/pages/home_page/card/card_icons_info.dart';

class MainPageCard extends StatefulWidget {
  const MainPageCard({Key? key, required this.cardRecipe}) : super(key: key);

  final CardRecipeModel cardRecipe;

  @override
  State<MainPageCard> createState() => _MainPageCardState();
}

class _MainPageCardState extends State<MainPageCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [BoxShadow(color: Colors.black, blurRadius: 2)],
          color: ColorVariables.primaryColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UserRow(
                  userId: "asd",
                  userName: widget.cardRecipe.user.userName,
                  textColor: ColorVariables.backgroundColor,
                  image: widget.cardRecipe.user.userImage,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 20), // Додайте відступ з правого боку
                  child: PopupMenuButton<String>(
                    color: ColorVariables.backgroundColor,
                    icon: Icon(
                      Icons.more_horiz,
                      size: IconSizeVariables.regularSize,
                      color: ColorVariables.backgroundColor,
                    ),
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'update',
                        child: Text('Update recipe'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'delete',
                        child: Text('Delete recipe'),
                      ),
                    ],
                    onSelected: (String value) {
                      // Додайте обробник події, який викликається при виборі пункту меню
                      switch (value) {
                        case 'update':
                          // Ваші дії для пункту меню 1
                          break;
                        case 'delete':
                          // Ваші дії для пункту меню 2
                          break;
                      }
                    },
                  ),
                ),
              ],
            ),
            Image.memory(
              widget.cardRecipe.recipeImage,
              width: double.infinity,
              //height: MediaQuery.of(context).size.height * 0.25,
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 10),
            Text(
              widget.cardRecipe.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: FontSizeVariables.h1Size,
                  fontWeight: FontWeight.bold,
                  color: ColorVariables.backgroundColor),
            ),
            const SizedBox(height: 10),
            CardIconsInfo(
                textHardness: Mapper.mapHardnessToText(
                    widget.cardRecipe.cookingDifficulty),
                textTime: Mapper.mapTimeToText(widget.cardRecipe.cookingTime),
                textType: widget.cardRecipe.recipeType,
                iconColor: ColorVariables.backgroundColor),
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(createRoute(
                          cardRecipe: widget.cardRecipe,
                          pageType: 'recipePage',
                        ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorVariables.backgroundColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                      ),
                      child: Text(
                        "Go to recipe!",
                        style: TextStyle(
                            fontSize: FontSizeVariables.regularSize,
                            fontWeight: FontWeight.bold,
                            color: ColorVariables.primaryColor),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LikeButton(
                      buttonToggledText: 'Liked 😍',
                      buttonUntoggledText: 'Disliked 😢',
                      isButtonToggled: widget.cardRecipe.isRecipeLiked,
                      onTap: (newState) {
                        setState(
                          () {
                            widget.cardRecipe.isRecipeLiked = newState;
                            if (newState) {
                              widget.cardRecipe.likesCount++;
                            } else {
                              widget.cardRecipe.likesCount--;
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(Icons.favorite,
                        color: ColorVariables.backgroundColor,
                        size: IconSizeVariables.bigSize),
                  ),
                  Text(
                    widget.cardRecipe.likesCount.toString(),
                    style: TextStyle(color: ColorVariables.backgroundColor),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
