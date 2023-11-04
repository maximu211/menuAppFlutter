import 'package:flutter/material.dart';
import 'package:menuapp/home_page/card/card.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              MainPageCard(
                userName: "John_Lennon",
                userPhoto: "assets/images/test.jpg",
                cookHardness: "Easy",
                cookTime: "15 min",
                cookType: "Drink",
                dishName: 'Cocktail "Lol"',
                dishPhoto: "assets/images/dish_images/3.jpg",
                isDishSaved: true,
                savedCount: 140,
              ),
              MainPageCard(
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
              MainPageCard(
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
              MainPageCard(
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
            ],
          ),
        )
    );
  }
}