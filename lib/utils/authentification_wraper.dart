import 'package:flutter/material.dart';
import 'package:menuapp/http/auth/user_requests.dart';
import 'package:menuapp/navigation/navigation_page.dart';
import 'package:menuapp/pages/authorization/sign_in_page/sign_in_page.dart';
import 'package:menuapp/utils/secure_storage.dart';
import 'package:menuapp/utils/refresh_token.dart';
import 'package:jwt_decode/jwt_decode.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key});

  Future<String?> getAccessToken() async {
    return SecureStorage().readData("AccessToken");
  }

  Future<bool> isTokenExpired(String? token) async {
    if (token == null) {
      return true;
    }
    return Jwt.isExpired(token);
  }

  Future<void> refreshTokenIfNeeded() async {
    final String? refreshToken = await SecureStorage().readData("RefreshToken");
    if (refreshToken != null) {
      final result = await UserRequest.refreshToken(refreshToken);
      if (result.success) {
        await SecureStorage()
            .storage
            .write(key: "AccessToken", value: result.accessToken);
        await SecureStorage()
            .storage
            .write(key: "RefreshToken", value: result.refreshToken);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: getAccessToken(),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final String? accessToken = snapshot.data;
          if (accessToken != null) {
            return FutureBuilder<bool>(
              future: isTokenExpired(accessToken),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  final bool isExpired = snapshot.data ?? true;
                  if (isExpired) {
                    refreshTokenIfNeeded();
                  }
                  return const NavigationPage();
                }
              },
            );
          } else {
            return const LoginPage();
          }
        }
      },
    );
  }
}
