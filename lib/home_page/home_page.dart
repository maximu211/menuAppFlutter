import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/global_variables/icon_size_variables.dart';
import 'package:menuapp/home_page/card/card.dart';
import 'package:menuapp/models/models.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ColorPackage colors = ColorPackage();
  final FontSizeVariables fontSize = FontSizeVariables();
  final IconSizeVariables iconSize = IconSizeVariables();

  final List<CardReceiptModel> cardReceiptList = [
    CardReceiptModel(
        user: UserModel(
            userName: "Name_Guttt", userPhoto: "assets/images/test.jpg"),
        receiptId: "2",
        cookHardness: "Easy",
        cookTime: "15 min",
        cookType: "Drink",
        dishName: 'Cocktail "Cool guy"',
        dishPhoto: "assets/images/dish_images/3.jpg",
        isDishSaved: false,
        savedCount: 140,
        isDishLiked: true,
        userId: '12'),
    CardReceiptModel(
        user: UserModel(
            userName: "John_Lennon", userPhoto: "assets/images/test.jpg"),
        cookHardness: "Easy",
        cookTime: "15 min",
        cookType: "Drink",
        dishName: 'Cocktail "Cool guy"',
        dishPhoto: "assets/images/dish_images/1.jpg",
        isDishSaved: true,
        savedCount: 140,
        isDishLiked: false,
        receiptId: '21',
        userId: '12'),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          pinned: false,
          snap: true,
          automaticallyImplyLeading: false,
          backgroundColor: colors.primary_color,
          shadowColor: Colors.black,
          leading: Image.asset(
            "assets/images/logo.png",
            color: colors.pure_white,
          ),
          title: Text(
            'Cool App Name',
            style: TextStyle(
              color: colors.background_color,
              fontSize: fontSize.h1Size,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
              itemCount: cardReceiptList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final cardReceipt = cardReceiptList[index];
                return Column(
                  children: [
                    MainPageCard(cardReceipt: cardReceipt),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
