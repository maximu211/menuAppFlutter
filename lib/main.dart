import "package:flutter/material.dart";
import "package:menuapp/authorization/sign_in_page/sign_in_page.dart";
import "package:menuapp/global_variables/color_variables.dart";
import "package:menuapp/home_page/components/booked_icon.dart";
import "package:menuapp/navigation/navigation_page.dart";
import 'package:google_fonts/google_fonts.dart';
import "package:provider/provider.dart";

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final ColorPackage colors = ColorPackage();
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    navigatorKey: navigatorKey,
      theme: ThemeData(fontFamily: GoogleFonts.balooChettan2().fontFamily),
      routes: {'/startpage': (context) => const NavigationPage()},
      home: Scaffold(
        backgroundColor: colors.background_color,
        body: const LoginPage(),
      )));
}
