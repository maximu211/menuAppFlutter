// ignore_for_file: use_build_context_synchronously

import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/http/search_requests/search_request.dart';
import 'package:menuapp/pages/common_components/user_card.dart';
import 'package:menuapp/pages/home_page/card/card.dart';
import 'package:menuapp/models/models.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();

  List<CardRecipeModel> _sortedrecipeList = [];
  List<UserModel> _sortedUserList = [];
  String? _previousQuery;

  @override
  void initState() {
    super.initState();
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
            onSearch: (query) async {
              if (query.isEmpty) {
                setState(() {
                  _sortedrecipeList.clear();
                  _sortedUserList.clear();
                });
                return;
              }

              if (query != _previousQuery) {
                try {
                  final searchResult =
                      await SearchRequests.getSearchResult(query);
                  setState(() {
                    _sortedrecipeList = searchResult.recipeList;
                    _sortedUserList = searchResult.usersList;
                    _previousQuery = query;
                  });
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Error occurred while searching')));
                }
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
                if (_sortedUserList.isEmpty && _sortedrecipeList.isEmpty)
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ColorVariables.primaryColor,
                          boxShadow: const [
                            BoxShadow(color: Colors.black, blurRadius: 2)
                          ]),
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        textAlign: TextAlign.center,
                        "Please enter a search term to find recipes or users 😉",
                        style: TextStyle(
                          color: ColorVariables.backgroundColor,
                          fontSize: FontSizeVariables.h2Size,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                _sortedUserList.isNotEmpty
                    ? Column(
                        children: [
                          Text(
                            "Users",
                            style: TextStyle(
                                color: ColorVariables.primaryColor,
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
                                  UserCard(userModel: item),
                                ],
                              );
                            },
                          )
                        ],
                      )
                    : const SizedBox(),
                _sortedrecipeList.isNotEmpty
                    ? Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Recipes",
                            style: TextStyle(
                                color: ColorVariables.primaryColor,
                                fontSize: FontSizeVariables.h2Size,
                                fontWeight: FontWeight.bold),
                          ),
                          ListView.builder(
                            itemCount: _sortedrecipeList.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final item = _sortedrecipeList[index];
                              return Column(
                                children: [
                                  MainPageCard(cardRecipe: item),
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
