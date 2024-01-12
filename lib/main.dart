import "package:flutter/material.dart";
import "package:menuapp/authorization/sign_in_page/sign_in_page.dart";
import "package:menuapp/navigation/navigation_page.dart";
import 'package:google_fonts/google_fonts.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      navigatorKey: navigatorKey,
      theme: ThemeData(fontFamily: GoogleFonts.balooChettan2().fontFamily),
      routes: {'/startpage': (context) => const NavigationPage()},
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: LoginPage(),
      ),
    ),
  );
}
