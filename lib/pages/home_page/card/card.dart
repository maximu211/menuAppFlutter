// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/dialog_utils.dart';
import 'package:menuapp/global_variables/page_transition_animation.dart';
import 'package:menuapp/http/DTOs/dtos.dart';
import 'package:menuapp/http/recipe_requests/recipe_requests.dart';
import 'package:menuapp/pages/common_components/toggle_icon_button.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/global_variables/icon_size_variables.dart';
import 'package:menuapp/models/mappers.dart';
import 'package:menuapp/models/models.dart';
import 'package:menuapp/pages/common_components/user_row.dart';
import 'package:menuapp/pages/home_page/card/card_icons_info.dart';

class MainPageCard extends StatefulWidget {
  const MainPageCard(
      {Key? key,
      required this.cardRecipe,
      this.onDeleteCallBack,
      this.onDeleteFromSaved})
      : super(key: key);

  final CardRecipeModel cardRecipe;
  final VoidCallback? onDeleteCallBack;
  final Function(Map<String, bool> deleteFromSavedMap)? onDeleteFromSaved;

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
                  userId: widget.cardRecipe.user.userId,
                  userName: widget.cardRecipe.user.userName,
                  textColor: ColorVariables.backgroundColor,
                  image: widget.cardRecipe.user.userImage,
                ),
                widget.cardRecipe.isOwner
                    ? Padding(
                        padding: const EdgeInsets.only(right: 20),
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
                          onSelected: (String value) async {
                            switch (value) {
                              case 'update':
                                var result = await RecipeRequests.getRecipeById(
                                    widget.cardRecipe.id);
                                Navigator.push(
                                  context,
                                  NavigationService.createAddPageRoute(
                                      RecipeNotifier(result),
                                      true,
                                      widget.cardRecipe.id),
                                ).then((value) {
                                  if (value != null && value is FullRecipeDto) {
                                    setState(() {
                                      widget.cardRecipe.name = value.name;
                                      widget.cardRecipe.cookingDifficulty =
                                          value.difficulty;
                                      widget.cardRecipe.cookingTime =
                                          value.cookingTime;
                                      if (value.image == null) {
                                        widget.cardRecipe.recipeImage =
                                            widget.cardRecipe.recipeImage;
                                      } else {
                                        widget.cardRecipe.recipeImage =
                                            value.image!;
                                      }

                                      widget.cardRecipe.recipeType =
                                          widget.cardRecipe.recipeType;
                                    });
                                  }
                                });
                                break;
                              case 'delete':
                                DialogUtils.showLeavePageDialog(
                                  context: context,
                                  title: "Delete recipe",
                                  description: "Do you want to delete recipe?",
                                  okFunc: () {
                                    RecipeRequests.deleteRecipe(
                                        widget.cardRecipe.id);
                                    Navigator.pop(context);
                                    widget.onDeleteCallBack!();
                                  },
                                  cancelFunc: () {
                                    Navigator.pop(context);
                                  },
                                );
                                break;
                            }
                          },
                        ),
                      )
                    : Container(),
              ],
            ),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.memory(
                base64Decode(widget.cardRecipe.recipeImage),
                fit: BoxFit.cover,
              ),
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
                        Navigator.of(context)
                            .push(NavigationService.createRecipePageRoute(
                          widget.cardRecipe,
                        ))
                            .then((value) {
                          if (value is Map<String, bool>) {
                            if (widget.onDeleteFromSaved == null) {
                              return;
                            } else {
                              widget.onDeleteFromSaved!(value);
                            }
                          }
                        });
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
                              RecipeRequests.likeRecipe(widget.cardRecipe.id);
                              widget.cardRecipe.likesCount++;
                            } else {
                              RecipeRequests.dislikeRecipe(
                                  widget.cardRecipe.id);
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
