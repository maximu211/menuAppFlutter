import 'package:flutter/material.dart';
import 'package:menuapp/account_page/account_page.dart';
import 'package:menuapp/add_page/add_page.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/home_page/home_page.dart';
import 'package:menuapp/search_page/search_page.dart';

import '../global_variables/font_size_variables.dart';
import '../global_variables/icon_size_variables.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NavigationPage();
  }
}

class _NavigationPage extends State<NavigationPage> {
  ColorPackage colors = ColorPackage();
  FontSizeVariables fontSize = FontSizeVariables();
  IconSizeVariables iconSizeVariables = IconSizeVariables();

  int _currentIndex = 0;

  Widget renderScreen(int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return const SearchPage();
      case 2:
        return const AddPage();
      case 3:
        return const AccountPage();
      default:
        return const Text('Невідомий екран');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.background_color,
      bottomNavigationBar: NavigationBar(
          backgroundColor: colors.background_color,
          indicatorColor: colors.primary_color,
          destinations: [
            NavigationDestination(
                icon: Icon(
                  Icons.home,
                  size: iconSizeVariables.regularSize,
                ),
                label: ''),
            NavigationDestination(
                icon: Icon(
                  Icons.search_rounded,
                  size: iconSizeVariables.regularSize,
                ),
                label: ''),
            NavigationDestination(
                icon: Icon(
                  Icons.add,
                  size: iconSizeVariables.regularSize,
                ),
                label: ''),
            NavigationDestination(
                icon: Icon(
                  Icons.person,
                  size: iconSizeVariables.regularSize,
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
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background_image.png"),
                  fit: BoxFit.fill),
            ),
          ),
          renderScreen(_currentIndex)
        ],
      ),
    );
  }
}
