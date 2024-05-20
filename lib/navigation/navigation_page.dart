import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/page_transition_animation.dart';
import 'package:menuapp/http/DTOs/dtos.dart';
import 'package:menuapp/models/models.dart';
import 'package:menuapp/pages/home_page/home_page.dart';
import 'package:menuapp/pages/search_page/search_page.dart';
import 'package:menuapp/global_variables/icon_size_variables.dart';
import 'package:menuapp/pages/user_page/user_page.dart';
import 'package:menuapp/utils/secure_storage.dart';

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
        return FutureBuilder<String?>(
          future: SecureStorage().getUserIdFromToken(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Помилка завантаження даних'));
            } else if (snapshot.hasData && snapshot.data != null) {
              return UserPage(userId: snapshot.data!);
            } else {
              return const Center(child: Text('Не вдалося завантажити дані'));
            }
          },
        );
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
                  selectedIcon: Icon(
                    Icons.home,
                    size: IconSizeVariables.regularSize,
                    color: ColorVariables.backgroundColor,
                  ),
                  label: ''),
              NavigationDestination(
                  icon: Icon(
                    Icons.search_rounded,
                    size: IconSizeVariables.regularSize,
                  ),
                  selectedIcon: Icon(
                    Icons.search_rounded,
                    size: IconSizeVariables.regularSize,
                    color: ColorVariables.backgroundColor,
                  ),
                  label: ''),
              NavigationDestination(
                  icon: Icon(
                    Icons.add,
                    size: IconSizeVariables.regularSize,
                  ),
                  selectedIcon: Icon(
                    Icons.add,
                    size: IconSizeVariables.regularSize,
                    color: ColorVariables.backgroundColor,
                  ),
                  label: ''),
              NavigationDestination(
                  icon: Icon(
                    Icons.person,
                    size: IconSizeVariables.regularSize,
                  ),
                  selectedIcon: Icon(
                    Icons.person,
                    size: IconSizeVariables.regularSize,
                    color: ColorVariables.backgroundColor,
                  ),
                  label: ''),
            ],
            selectedIndex: _currentIndex,
            onDestinationSelected: (int index) {
              if (index == 2) {
                Navigator.push(
                  context,
                  NavigationService.createAddPageRoute(
                      RecipeNotifier(
                        FullRecipeDto(
                            cookingTime: CookingTime.min15,
                            difficulty: CookingDifficulty.easy,
                            image: null,
                            name: '',
                            recipeDescElements: [],
                            recipeIngredients: [],
                            recipeType: ''),
                      ),
                      false,
                      ''),
                );
              } else {
                setState(() {
                  _currentIndex = index;
                });
              }
            }),
        body: renderScreen(_currentIndex));
  }
}
