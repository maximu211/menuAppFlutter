import 'dart:async';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:menuapp/http/user_requests/user_requests.dart';
import 'package:menuapp/utils/secure_storage.dart';

class TokenFetcher {
  static Timer? _timer;

  static void startTokenFetching() {
    _timer ??= Timer.periodic(const Duration(seconds: 1), (_) async {
      await tokenFetchIsolate();
    });
  }

  static Future<void> tokenFetchIsolate() async {
    final String? accessToken = await SecureStorage().readData("AccessToken");
    if (accessToken != null) {
      final DateTime? expiryDate = Jwt.getExpiryDate(accessToken);
      if (expiryDate != null && DateTime.now().isAfter(expiryDate)) {
        final String? refreshToken =
            await SecureStorage().readData("RefreshToken");
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
    }
  }
}
