import "package:flutter/material.dart";
import "package:menuapp/authorization/sign_in_page/log_in_page.dart";
import "package:menuapp/global_variables/color_variables.dart";
import "package:menuapp/navigation/navigation_page.dart";
import 'package:google_fonts/google_fonts.dart';

final ColorPackage colors = ColorPackage();
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      theme: ThemeData(fontFamily: GoogleFonts.balooChettan2().fontFamily),
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
