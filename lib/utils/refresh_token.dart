import 'dart:async';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:menuapp/http/auth/user_requests.dart';
import 'package:menuapp/utils/secure_storage.dart';

class TokenFetcher {
  static void startTokenFetching() {
    Timer.periodic(const Duration(seconds: 1), (_) {
      tokenFetchIsolate();
    });
  }

  static void tokenFetchIsolate() async {
    String? accessToken =
        await SecureStorage().storage.read(key: "AccessToken");

    if (accessToken != null) {
      DateTime? decodedToken = Jwt.getExpiryDate(accessToken);
      Duration timeUntilExpiry = decodedToken!.difference(DateTime.now());

      if (timeUntilExpiry <= Duration.zero) {
        UserRequest.refreshToken(
                await SecureStorage().storage.read(key: "RefreshToken") ?? '')
            .then((result) {
          if (result.success) {
            SecureStorage()
                .storage
                .write(key: "AccessToken", value: result.accessToken);
            SecureStorage()
                .storage
                .write(key: "RefreshToken", value: result.refreshToken);
          }
        });
      }
    }
  }
}
