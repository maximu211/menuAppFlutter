import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/global_variables/icon_size_variables.dart';
import 'package:menuapp/home_page/card/card.dart';
import 'package:menuapp/models/card_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key});

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final ColorPackage colors = ColorPackage();
  final FontSizeVariables fontSize = FontSizeVariables();
  final IconSizeVariables iconSize = IconSizeVariables();

  final List<CardReceipt> receiptList = [
    CardReceipt(
        dishPhoto: "dishPhoto",
        userPhoto: "userPhoto",
        userName: "userName",
        dishName: "111",
        cookHardness: "cookHardness",
        cookTime: "cookTime",
        cookType: "cookType",
        isDishSaved: false,
        savedCount: 100),
    CardReceipt(
        dishPhoto: "dishPhoto",
        userPhoto: "userPhoto",
        userName: "userName",
        dishName: "222",
        cookHardness: "cookHardness",
        cookTime: "cookTime",
        cookType: "cookType",
        isDishSaved: false,
        savedCount: 100),
    CardReceipt(
        dishPhoto: "dishPhoto",
        userPhoto: "userPhoto",
        userName: "userName",
        dishName: "333",
        cookHardness: "cookHardness",
        cookTime: "cookTime",
        cookType: "cookType",
        isDishSaved: false,
        savedCount: 100),
  ];
  List<CardReceipt> filtredReceiptList = [];
  var searchHistory = [];

  final SearchController controller = SearchController();

  void search(String query){
    if(query.isEmpty) {
      setState(() {
        filtredReceiptList.clear();
      });
    }
    else{
      filtredReceiptList = receiptList.where((e) =>
          e.dishName.toLowerCase().contains(query.toLowerCase())).toList();
    }
  }


  void queryListener(){
    search(controller.text);
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(queryListener);
  }

  @override
  void dispose() {
    controller.removeListener(queryListener);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          SearchAnchor(
            //searchController: controller,
            viewHintText: "Input dish name",
            viewTrailing: [
              IconButton(onPressed: (){
                searchHistory.add(controller.text);
                controller.closeView(controller.text);
                print(searchHistory.length);
              },
                  icon: Icon(Icons.search))
            ],
            builder: (context, controller) {
              return SearchBar(
                leading: Icon(Icons.search),
                hintText: "Input dish name",
                onTap: () {
                  controller.openView();
                  print(searchHistory.last);
                },
              );
            },
            suggestionsBuilder: (context, controller) {
              return  [
                Wrap(
                  children: List.generate(searchHistory.length, (index) {
                    final item = searchHistory[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: ChoiceChip(
                        label: Text(item), selected: item == controller.text,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        onSelected: (value){
                          search(item);
                          controller.closeView(item);
                        },
                      ),
                    );
                  })
                )
              ];
            }
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Or try our hourly recommendation",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: fontSize.h1Size, color: colors.pure_white),
          ),
          const SizedBox(
            height: 20,
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
    );
  }
}
