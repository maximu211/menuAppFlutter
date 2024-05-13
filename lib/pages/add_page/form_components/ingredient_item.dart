import 'package:flutter/material.dart';

class IngredientsExpansionTile extends StatefulWidget {
  @override
  _IngredientsExpansionTileState createState() =>
      _IngredientsExpansionTileState();
}

class _IngredientsExpansionTileState extends State<IngredientsExpansionTile> {
  List<IngredientItem> _ingredients = [];

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('Ingredients'),
      children: [
        Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: _ingredients.length,
              itemBuilder: (context, index) {
                final ingredient = _ingredients[index];
                return Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter ingredient',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          _ingredients.remove(_ingredients[index]);
                        });
                      },
                    ),
                  ],
                );
              },
            ),
            TextField(
              
            ),
          ],
        ),
      ],
    );
  }
}

class IngredientItem {}
