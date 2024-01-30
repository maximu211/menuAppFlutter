import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/home_page/card/card.dart';
import 'package:menuapp/home_page/components/user_row.dart';
import 'package:menuapp/models/models.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();

  List<CardReceiptModel> _sortedReceiptList = [];
  List<IdUserModel> _sortedUserList = [];

  late BinaryFileReader binaryFileReader;
  late Uint8List binaryData;
  late List<CardReceiptModel> cardReceiptList;
  late List<IdUserModel> userList;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    var data = await rootBundle.load('assets/images/dish_images/1.jpg');
    setState(() => binaryData = data.buffer.asUint8List());
    cardReceiptList = [
      CardReceiptModel(
          user: UserModel(userName: "Name_Guttt", userPhoto: binaryData),
          receiptId: "2",
          cookDifficulty: CookingDifficulty.easy,
          cookTime: CookingTime.min15,
          cookType: "Drink",
          dishName: 'Cocktail "Cool guy"',
          dishPhoto: binaryData,
          isDishSaved: false,
          savedCount: 140,
          isDishLiked: true,
          userId: '12'),
      CardReceiptModel(
          user: UserModel(userName: "John_Lennon", userPhoto: binaryData),
          cookDifficulty: CookingDifficulty.medium,
          cookTime: CookingTime.hour1,
          cookType: "Drink",
          dishName: 'Name',
          dishPhoto: binaryData,
          isDishSaved: true,
          savedCount: 140,
          isDishLiked: false,
          receiptId: '21',
          userId: '12'),
    ];

    userList = [
      IdUserModel(userName: "1", userPhoto: binaryData, userId: "userId"),
      IdUserModel(userName: "2", userPhoto: binaryData, userId: "userId"),
      IdUserModel(userName: "NAME", userPhoto: binaryData, userId: "userId"),
      IdUserModel(userName: "NAME", userPhoto: binaryData, userId: "userId"),
    ];
  }

  void listFiltering(String query) {
    setState(() {
      if (query.trim().isNotEmpty) {
        _sortedReceiptList = cardReceiptList
            .where((receipt) => receipt.dishName
                .toLowerCase()
                .contains(query.trim().toLowerCase()))
            .toList();

        _sortedUserList = userList
            .where((user) => user.userName
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
                _sortedReceiptList.clear();
                _sortedUserList.clear();
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
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                _sortedUserList.isNotEmpty
                    ? Column(
                        children: [
                          Text(
                            "Users",
                            style: TextStyle(
                                color: ColorVariables.backgroundColor,
                                fontSize: FontSizeVariables.h2Size,
                                fontWeight: FontWeight.bold),
                          ),
                          ListView.builder(
                            itemCount: _sortedUserList.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final item = _sortedUserList[index];
                              return Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: ColorVariables.primaryColor,
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Colors.black,
                                              blurRadius: 5)
                                        ]),
                                    child: UserRow(
                                        userName: item.userName,
                                        image: item.userPhoto,
                                        textColor:
                                            ColorVariables.backgroundColor),
                                  ),
                                ],
                              );
                            },
                          )
                        ],
                      )
                    : const SizedBox(),
                _sortedReceiptList.isNotEmpty
                    ? Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Receipts",
                            style: TextStyle(
                                color: ColorVariables.backgroundColor,
                                fontSize: FontSizeVariables.h2Size,
                                fontWeight: FontWeight.bold),
                          ),
                          ListView.builder(
                            itemCount: _sortedReceiptList.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final item = _sortedReceiptList[index];
                              return Column(
                                children: [
                                  MainPageCard(cardReceipt: item),
                                  const SizedBox(height: 20)
                                ],
                              );
                            },
                          ),
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
