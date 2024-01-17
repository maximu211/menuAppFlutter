import 'package:flutter/material.dart';
import 'package:menuapp/account_page/account_page.dart';
import 'package:menuapp/add_page/add_page.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/page_transition_animation.dart';
import 'package:menuapp/home_page/home_page.dart';
import 'package:menuapp/search_page/search_page.dart';
import 'package:menuapp/global_variables/icon_size_variables.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NavigationPage();
  }
}

class _NavigationPage extends State<NavigationPage> {
  int _currentIndex = 0;

  Widget renderScreen(int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return const SearchPage();
      case 3:
        return const AccountPage();
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
          indicatorColor: ColorVariables.primaryColor,
          destinations: [
            NavigationDestination(
                icon: Icon(
                  Icons.home,
                  size: IconSizeVariables.regularSize,
                ),
                label: ''),
            NavigationDestination(
                icon: Icon(
                  Icons.search_rounded,
                  size: IconSizeVariables.regularSize,
                ),
                label: ''),
            NavigationDestination(
                icon: Icon(
                  Icons.add,
                  size: IconSizeVariables.regularSize,
                ),
                label: ''),
            NavigationDestination(
                icon: Icon(
                  Icons.person,
                  size: IconSizeVariables.regularSize,
                ),
                label: ''),
          ],
          selectedIndex: _currentIndex,
          onDestinationSelected: (int index) {
            if (index == 2) {
              Navigator.push(context, createRoute(pageType: 'addPage'));
            } else {
              setState(() {
                _currentIndex = index;
              });
            }
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
