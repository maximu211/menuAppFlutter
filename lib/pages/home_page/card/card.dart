import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/page_transition_animation.dart';
import 'package:menuapp/pages/home_page/components/toggle_button.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/global_variables/icon_size_variables.dart';
import 'package:menuapp/models/mappers.dart';
import 'package:menuapp/models/models.dart';
import 'package:menuapp/pages/home_page/components/user_row.dart';
import 'package:menuapp/pages/home_page/card/card_icons_info.dart';

class MainPageCard extends StatefulWidget {
  const MainPageCard({Key? key, required this.cardReceipt}) : super(key: key);

  final CardReceiptModel cardReceipt;

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
            UserRow(
              image: widget.cardReceipt.user.userPhoto,
              userName: widget.cardReceipt.user.userName,
              textColor: ColorVariables.backgroundColor,
            ),
            Image.memory(
              widget.cardReceipt.dishPhoto,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.25,
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 10),
            Text(
              widget.cardReceipt.dishName,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: FontSizeVariables.h1Size,
                  fontWeight: FontWeight.bold,
                  color: ColorVariables.backgroundColor),
            ),
            const SizedBox(height: 10),
            CardIconsInfo(
                textHardness:
                    Mapper.mapHardnessToText(widget.cardReceipt.cookDifficulty),
                textTime: Mapper.mapTimeToText(widget.cardReceipt.cookTime),
                textType: widget.cardReceipt.cookType,
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
                          cardReceipt: widget.cardReceipt,
                          pageType: 'receiptPage',
                        ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorVariables.backgroundColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                      ),
                      child: Text(
                        "Go to receipt!",
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
                      isButtonToggled: widget.cardReceipt.isDishLiked,
                      onTap: (newState) {
                        setState(
                          () {
                            widget.cardReceipt.isDishLiked = newState;
                            if (newState) {
                              widget.cardReceipt.savedCount++;
                            } else {
                              widget.cardReceipt.savedCount--;
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
                    widget.cardReceipt.savedCount.toString(),
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
