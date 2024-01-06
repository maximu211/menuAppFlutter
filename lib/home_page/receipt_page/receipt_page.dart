import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/icon_size_variables.dart';
import 'package:menuapp/home_page/components/toggle_button.dart';
import 'package:menuapp/home_page/receipt_page/list_of_ingredients/list_of_ingredients.dart';
import 'package:menuapp/models/models.dart';
import 'comments/comments_page.dart';

class ReceiptPage extends StatefulWidget {
  const ReceiptPage({super.key, required this.cardReceipt});

  final CardReceiptModel cardReceipt;

  @override
  State<StatefulWidget> createState() {
    return _ReceiptPage();
  }
}

class _ReceiptPage extends State<ReceiptPage> {
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
      backgroundColor: ColorVariables.backgroundColor,
      bottomNavigationBar: NavigationBar(
          backgroundColor: ColorVariables.backgroundColor,
          indicatorColor: ColorVariables. primaryColor,
          destinations: [
            NavigationDestination(
                icon: Icon(
                  Icons.format_list_bulleted,
                  size: IconSizeVariables.regularSize,
                ),
                label: ''),
            NavigationDestination(
                icon: Icon(
                  Icons.comment,
                  size: IconSizeVariables.regularSize,
                ),
                label: ''),
          ],
          selectedIndex: _currentIndex,
          onDestinationSelected: (int index) {
            setState(() {
              _currentIndex = index;
            });
          }),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: false,
                pinned: true,
                snap: false,
                automaticallyImplyLeading: true,
                expandedHeight: MediaQuery.of(context).size.height * 0.5,
                backgroundColor: ColorVariables.primaryColor,
                actions: [
                  Positioned(
                      right: 16,
                      top: 16,
                      child: SaveButton(
                        onTap: (newState) {
                          setState(
                            () {
                              widget.cardReceipt.isDishSaved = newState;
                            },
                          );
                        },
                        buttonToggledText: 'Receipt saved to your galery 😀',
                        buttonUntoggledText:
                            'Receipt deleted from your galery 😢',
                        isButtonToggled: widget.cardReceipt.isDishSaved,
                      ))
                ],
                leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: ColorVariables.backgroundColor,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(widget.cardReceipt.dishPhoto,
                      fit: BoxFit.cover),
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
        ],
      ),
    );
  }
}
