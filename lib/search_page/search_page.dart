import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/home_page/card/card.dart';
import 'package:menuapp/models/models.dart';
//import 'package:flutter/services.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>{

  final TextEditingController searchController = TextEditingController();
  var items = [];

  List<CardReceiptModel> _sortedList = [];
  final List<CardReceiptModel> cardReceiptList = [
    CardReceiptModel(
        receiptId: "21asd",
        userId: "asdsad1",
        user: UserModel(
            userName: "Name_asdasd", userPhoto: "assets/images/test.jpg"),
        cookHardness: "Easy",
        cookTime: "15 min",
        cookType: "Drink",
        dishName: 'Cocktail "Cool guy"',
        dishPhoto: "assets/images/dish_images/3.jpg",
        isDishSaved: false,
        savedCount: 140,
        isDishLiked: true),
    CardReceiptModel(
        receiptId: "12sa",
        userId: "asd2asdas",
        user: UserModel(
            userName: "Name_user", userPhoto: "assets/images/test.jpg"),
        cookHardness: "Easy",
        cookTime: "15 min",
        cookType: "Drink",
        dishName: 'aaaaaaa',
        dishPhoto: "assets/images/dish_images/1.jpg",
        isDishSaved: true,
        savedCount: 140,
        isDishLiked: false),
  ];

  //final

  void listFiltering(String query) {
    setState(() {
      if (query.trim().isNotEmpty) {
        _sortedList = cardReceiptList
            .where((receipt) => receipt.dishName
                .toLowerCase()
                .contains(query.trim().toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          foregroundColor: ColorVariables.backgroundColor,
          floating: true,
          pinned: true,
          snap: false,
          automaticallyImplyLeading: false,
          backgroundColor: ColorVariables.primaryColor,
          flexibleSpace: EasySearchBar(
            backgroundColor: ColorVariables.primaryColor,
            foregroundColor: ColorVariables.backgroundColor,
            elevation: 100,
            searchHintText: 'Soup, pizza e.t.c.',
            searchClearIconTheme: const IconThemeData(),
            searchCursorColor: ColorVariables.primaryColor,
            systemOverlayStyle: SystemUiOverlayStyle.light,
            onSearch: (query) {
              listFiltering(query);
              if (query.isEmpty) {
                _sortedList.clear();
              }
            },
            title: Text(
              "What do you want to cook today?🤔",
              style: TextStyle(
                color: ColorVariables.backgroundColor,
                fontSize: FontSizeVariables.h1Size,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                  itemCount: _sortedList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item = _sortedList[index];
                    return Column(
                      children: [
                        MainPageCard(cardReceipt: item),
                        const SizedBox(height: 20)
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
