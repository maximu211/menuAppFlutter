import 'dart:io';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:menuapp/pages/authorization/log_in_page/log_in_page.dart';
import 'package:menuapp/navigation/navigation_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:menuapp/utils/authentification_wraper.dart';
import 'package:menuapp/utils/http_override.dart';
import 'package:menuapp/utils/refresh_token.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  HttpOverrides.global = MyHttpOverrides();
  TokenFetcher.startTokenFetching();
  runApp(
    DevicePreview(
      enabled: true,
      tools: const [
        ...DevicePreview.defaultTools,
      ],
      builder: (context) {
        return const MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: ThemeData(fontFamily: GoogleFonts.balooChettan2().fontFamily),
      routes: {
        '/startPage': (context) => const NavigationPage(),
        '/logInPage': (context) => const LoginPage()
      },
      debugShowCheckedModeBanner: false,
      home: const Scaffold(body: AuthenticationWrapper()),
    );
  }
}
