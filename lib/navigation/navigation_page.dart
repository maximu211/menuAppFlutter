
import 'package:flutter/material.dart';
import 'package:menuapp/account_page/account_page.dart';
import 'package:menuapp/add_page/add_page.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/home_page/home_page.dart';
import 'package:menuapp/search_page/search_page.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NavigationPage();
  }
}

class _NavigationPage extends State<NavigationPage> {
  ColorPackage colors = ColorPackage();

  int _currentIndex = 0;

  Widget renderScreen(int index){
    switch (index){
      case 0: return const HomePage();
      case 1: return const SearchPage();
      case 2: return const AddPage();
      case 3: return AccountPage();
      default: return const Text('Невідомий екран');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: colors.primary_color,
        //shadowColor: const Color.fromARGB(0, 1, 1, 1),
        actions: [
          Center(
            child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Row(
                  children: [
                    Text("Cool App Name",
                        style: TextStyle(fontSize: 20, color: colors.background_color)),
                    Image.asset('assets/images/logo.png', color: colors.background_color,)
                  ],
                )),
          )
        ],
      ),
      backgroundColor: colors.background_color,
      bottomNavigationBar: NavigationBar(
        height: 50,
        backgroundColor: colors.background_color,
        indicatorColor: colors.primary_color,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: ''),
          NavigationDestination(icon: Icon(Icons.search_rounded), label: ''),
          NavigationDestination(icon: Icon(Icons.add), label: ''),
          NavigationDestination(icon: Icon(Icons.person), label: ''),
        ],
        selectedIndex: _currentIndex,
        onDestinationSelected: (int index){
          setState(() {
            _currentIndex = index;
          });
        }
      ),
      body: renderScreen(_currentIndex)
    );
  }
}
