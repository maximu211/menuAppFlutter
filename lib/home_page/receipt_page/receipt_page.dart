import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/global_variables/icon_size_variables.dart';
import 'package:menuapp/home_page/card/card.dart';
import 'package:menuapp/home_page/components/booked_icon.dart';
import 'package:menuapp/home_page/receipt_page/list_of_ingredients/list_of_ingredients.dart';
import 'package:menuapp/models/card_model.dart';
import 'comments/comments_page.dart';

class ReceiptPage extends StatefulWidget {
  const ReceiptPage({Key? key, required this.cardReceipt});

  final CardReceipt cardReceipt;

  @override
  State<StatefulWidget> createState() {
    return _ReceiptPage();
  }
}

class _ReceiptPage extends State<ReceiptPage> {
  final ColorPackage colors = ColorPackage();
  final FontSizeVariables fontSize = FontSizeVariables();
  final IconSizeVariables iconSize = IconSizeVariables();

  int _currentIndex = 0;

  Widget renderScreen(int index) {
    switch (index) {
      case 0:
        return IngredientList(cardReceipt: widget.cardReceipt);
      case 1:
        return const CommentsPage();
      default:
        return const Text('Невідомий екран');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.background_color,
      bottomNavigationBar: NavigationBar(
          //height: MediaQuery.of(context).size.height * 0.07,
          backgroundColor: colors.background_color,
          indicatorColor: colors.primary_color,
          destinations: [
            NavigationDestination(
                icon: Icon(
                  Icons.format_list_bulleted,
                  size: iconSize.regularSize,
                ),
                label: ''),
            NavigationDestination(
                icon: Icon(
                  Icons.comment,
                  size: iconSize.regularSize,
                ),
                label: ''),
          ],
          selectedIndex: _currentIndex,
          onDestinationSelected: (int index) {
            setState(() {
              _currentIndex = index;
            });
          }),
      body: Stack(children: [
        // Container(
        //   decoration: BoxDecoration(
        //       image: DecorationImage(
        //           image: AssetImage("assets/images/background_image.png"),
        //           fit: BoxFit.fill
        //       )
        //   ),
        // ),
        CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: false,
              pinned: true,
              snap: false,
              automaticallyImplyLeading: true,
              expandedHeight: MediaQuery.of(context).size.height * 0.5,
              backgroundColor: colors.primary_color,
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(widget.cardReceipt.dishPhoto, fit: BoxFit.cover),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: renderScreen(_currentIndex),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
