import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/global_variables/icon_size_variables.dart';
import 'package:menuapp/home_page/card/user_row.dart';
import 'package:menuapp/home_page/card/card_icons_info.dart';
import 'package:menuapp/home_page/receipt_page/list_of_ingredients/ingredient.dart';

class IngredientList extends StatefulWidget {
  const IngredientList({super.key});

  @override
  State<StatefulWidget> createState() => _IngredientList();
}

class _IngredientList extends State<IngredientList> {
  final ColorPackage colors = ColorPackage();
  final FontSizeVariables fontSize = FontSizeVariables();
  final IconSizeVariables iconSize = IconSizeVariables();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Text(
                  "Any dish name just imagine anything sad sa asd sdas dsasa",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: fontSize.h1Size, color: Colors.black),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                  UserRow(userName: "userName", photoPath: "assets/images/test.jpg", textColor: Colors.black,)
                ],),
                CardIconsInfo(
                    textTime: ">15 min",
                    textHardness: "Easy",
                    textType: "Drink",
                    iconColor: Colors.black)
              ],
            ),
          ),
          Text("Ingredients", style: TextStyle(fontSize: fontSize.h2Size)),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: colors.primary_color,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 2,
                  )
                ]),
            child: Column(
              children: [
                Ingredient(ingradient: 'Item1 Item1 Item1 Item1Item1 Item1 Item1 Item1Item1 Item1 Item1 Item1, 300 g'),
                Ingredient(ingradient: 'Item2, 500 g'),
                Ingredient(ingradient: 'Item3, 500 g'),
                Ingredient(ingradient: 'Item4, 500 g'),
                Ingredient(ingradient: 'Item5, 500 g'),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text("Instructions", style: TextStyle(fontSize: fontSize.h2Size)),
          const SizedBox(
            height: 20,
          ),
          Text(
            textAlign: TextAlign.justify,
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phase Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus et ipsum malesuada diam ultrices euismod eu in dolor. Integer sollicitudin nulla massa, vel commodo metus varius et. In et velit vehicula, placerat lorem ac, vestibulum enim. Donec semper purus vitae magna elementum pretium. Nam commodo auctor est in ornare. Vivamus mollis ut turpis nec porta. Duis malesuada erat a odio iaculis pharetra. llus et ipsum malesuada diam ultrices euismod eu in dolor. Integer sollicitudin nulla massa, vel commodo metus varius et. In et velit vehicula, placerat lorem ac, vestibulum enim. Donec semper purus vitae magna elementum pretium. Nam commodo auctor est in ornare. Vivamus mollis ut turpis nec porta. Duis malesuada erat a odio iaculis pharetra. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus et ipsum malesuada diam ultrices euismod eu in dolor. Integer sollicitudin nulla massa, vel commodo metus varius et. In et velit vehicula, placerat lorem ac, vestibulum enim. Donec semper purus vitae magna elementum pretium. Nam commodo auctor est in ornare. Vivamus mollis ut turpis nec porta. Duis malesuada erat a odio iaculis pharetra.")
        ],
      ),
    );
  }
}
