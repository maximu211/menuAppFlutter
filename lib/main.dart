import 'dart:io';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:menuapp/pages/authorization/sign_in_page/sign_in_page.dart';
import 'package:menuapp/navigation/navigation_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:menuapp/secure_storage.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final storage = SecureStorage().storage;

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(
    DevicePreview(
      enabled: true,
      tools: const [
        ...DevicePreview.defaultTools,
      ],
      builder: (context) => const MyApp(),
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

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});
  Future<String?> getTokenFromStorage() async {
    return await storage.read(key: 'AccessToken');
  }

  Future<bool> isUserLoggedIn() async {
    String? token = await getTokenFromStorage();
    return token != null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isUserLoggedIn(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final bool isLoggedIn = snapshot.data ?? false;
          return isLoggedIn ? const NavigationPage() : const LoginPage();
        }
      },
    );
  }
}
