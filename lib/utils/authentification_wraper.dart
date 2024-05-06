import 'package:flutter/material.dart';
import 'package:menuapp/navigation/navigation_page.dart';
import 'package:menuapp/pages/authorization/sign_in_page/sign_in_page.dart';
import 'package:menuapp/utils/secure_storage.dart';
import 'package:menuapp/utils/refresh_token.dart';
import 'package:jwt_decode/jwt_decode.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key});

  Future<bool> isUserLoggedIn() async {
    String? token = await SecureStorage().readData("AccessToken");
    var isTokenExpired = Jwt.isExpired(token!);
    return isTokenExpired || token == null;
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
          if (isLoggedIn) {
            return const NavigationPage();
          } else {
            return const LoginPage();
          }
        }
      },
    );
  }
}
