import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/global_variables/icon_size_variables.dart';
import 'package:menuapp/home_page/components/user_row.dart';
import 'package:menuapp/home_page/card/card_icons_info.dart';
import 'package:menuapp/home_page/receipt_page/list_of_ingredients/ingredient.dart';
import 'package:menuapp/models/card_model.dart';

class IngredientList extends StatefulWidget {
  const IngredientList({super.key, required this.cardReceipt});

  final CardReceipt cardReceipt;

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
                  widget.cardReceipt.dishName,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: fontSize.h1Size, color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UserRow(
                      userName: widget.cardReceipt.userName,
                      photoPath: widget.cardReceipt.userPhoto,
                      textColor: Colors.black,
                    )
                  ],
                ),
                CardIconsInfo(
                    textTime: widget.cardReceipt.cookTime,
                    textHardness: widget.cardReceipt.cookHardness,
                    textType: widget.cardReceipt.cookType,
                    iconColor: Colors.black)
              ],
            ),
          ),
          Text("Ingredients", style: TextStyle(fontSize: fontSize.h2Size, fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: colors.primary_color,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 2,
                  )
                ]),
            child: Column(
              children: [
                Ingredient(
                    ingradient:
                        'Item1 Item1 Item1 Item1Item1 Item1 Item1 Item1Item1 Item1 Item1 Item1, 300 g'),
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
          Text("Instructions", style: TextStyle(fontSize: fontSize.h2Size, fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 20,
          ),
          Text(
              textAlign: TextAlign.justify,
              "1. Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                  "Phase Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus et"
                  " ipsum malesuada diam ultrices euismod eu in dolor. Integer sollicit"
                  "udin nulla massa, vel commodo metus varius et. In et velit vehicula, placera"
                  "t lorem ac, vestibulum enim.\n\n 2. Donec semper purus vitae magna elementum pretium. "
                  "Nam commodo auctor est in ornare. Vivam\n\n3. us mollis ut turpis nec porta. Duis males"
                  "uada erat a odio iaculis pharetra. llus et ipsum malesuada diam ultrices euismod"
                  " eu in dolor. Integer sollicitudin nulla massa, vel commodo metus varius et. In e"
                  "t velit vehicula, placerat lorem ac, vestibulum enim. Donec semper purus vitae ma"
                  "gna elementum pretium. Nam commodo auctor est in ornare. Vivamus mollis ut turpis"
                  " nec porta. Duis malesuada erat a odio iacu\n\n 4. lis pharetra. Lorem ipsum dolor sit a"
                  "met, consectetur adipiscing elit. Phasellus et ipsum malesuada diam ultrices euis"
                  "mod eu in dolor. Integer sollicitudin nulla massa, vel commodo metus varius et. In"
                  " et velit vehicula, placerat 4. lorem ac, vestibulum enim. Donec semper purus vitae m"
                  "agna elementum pretium. Nam commodo auctor est in ornare. Vivamus mollis ut turpis"
                  " nec porta. Duis malesuada erat a odio iaculis pharetra.")
        ],
      ),
    );
  }
}
