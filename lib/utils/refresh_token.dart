import 'dart:async';
import 'dart:isolate';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:menuapp/http/auth/user_requests.dart';
import 'package:menuapp/utils/secure_storage.dart';

class TokenFetcher {
  static void startTokenFetching() {
    Isolate.spawn(tokenFetchIsolate, null);
  }

  static void tokenFetchIsolate(_) async {
    String? accessToken =
        await SecureStorage().storage.read(key: "AccessToken");

    if (accessToken != null) {
      DateTime? decodedToken = Jwt.getExpiryDate(accessToken);
      DateTime refreshTime = decodedToken!.subtract(const Duration(minutes: 2));
      Duration timeUntilExpiry = refreshTime.difference(DateTime.now());

      Timer(timeUntilExpiry, () async {
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
      });
    }
  }
}
