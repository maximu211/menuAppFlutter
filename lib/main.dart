import "package:flutter/material.dart";
import "package:menuapp/log_in_page/log_in_page.dart";
import "package:menuapp/global_variables/color_variables.dart";
import "package:menuapp/navigation/navigation_page.dart";

final ColorPackage colors = ColorPackage();
void main() {
  runApp(
    MaterialApp(
      routes: {
        '/startpage' : (context) => const NavigationPage()
      },
      home: Scaffold(
        backgroundColor: colors.background_color,
        body: const LoginPage(),
      )
    ),
  );
}
