import 'package:flutter/material.dart';
import 'package:menuapp/home_page/card/card.dart';
import 'package:menuapp/models/card_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {

  CardReceipt cardReceipt = new CardReceipt(
    userName: "John_Lennon",
    userPhoto: "assets/images/test.jpg",
    cookHardness: "Easy",
    cookTime: "15 min",
    cookType: "Drink",
    dishName: 'Cocktail "Cool guy"',
    dishPhoto: "assets/images/dish_images/3.jpg",
    isDishSaved: true,
    savedCount: 140,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CardReceiptModel(
                  cardReceipt: cardReceipt,
                  updateSavedState: (bool newState){
                    cardReceipt.isDishSaved = newState;
                  },
                child: MainPageCard(cardReceipt: cardReceipt),
              ),
              MainPageCard(
                cardReceipt: CardReceipt(
                  userName: "QWE_QWE-QWe",
                  userPhoto: "assets/images/test.jpg",
                  cookHardness: "Hard",
                  cookTime: "45 min",
                  cookType: "Cold dishes",
                  dishName: 'Rolls Filadelfia',
                  dishPhoto: "assets/images/dish_images/2.jpg",
                  isDishSaved: false,
                  savedCount: 10,
                ),
              ),
              MainPageCard(
                cardReceipt: CardReceipt(
                  userName: "Nastya_kek",
                  userPhoto: "assets/images/test.jpg",
                  cookHardness: "Medium",
                  cookTime: "30 min",
                  cookType: "Salad",
                  dishName: 'Greek salad',
                  dishPhoto: "assets/images/dish_images/1.jpg",
                  isDishSaved: false,
                  savedCount: 140,
                ),
              ),
              MainPageCard(
                cardReceipt: CardReceipt(
                  userName: "Miles_Davis",
                  userPhoto: "assets/images/test.jpg",
                  cookHardness: "Easy",
                  cookTime: "1 hour",
                  cookType: "Soup",
                  dishName: 'Soup with beans and chicken',
                  dishPhoto: "assets/images/dish_images/4.jpg",
                  isDishSaved: true,
                  savedCount: 200,
                ),
              ),
            ],
          ),
        ));
  }
}
