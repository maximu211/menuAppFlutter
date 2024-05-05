import 'dart:async';
import 'dart:isolate';
import 'package:menuapp/http/auth/user_requests.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:menuapp/http/result.dart';
import 'package:menuapp/utils/secure_storage.dart';

// class RefreshToken {
//   Timer? timer;
// static final RefreshToken _instance = RefreshToken._internal();
// late Timer _timer;

// factory RefreshToken() {
//   return _instance;
// }

// RefreshToken._internal() {
//   // Почати таймер при створенні екземпляру класу
//   startTokenRefreshTimer();
// }

// void startTokenRefreshTimer() async {
//   String? accessToken =
//       await SecureStorage().storage.read(key: "AccessToken");
//   if (accessToken != null) {
//     int expirationTime = _getTokenExpirationTime(accessToken);
//     if (expirationTime > 0) {
//       _timer =
//           Timer.periodic(Duration(seconds: expirationTime - 60), (timer) {
//         _refreshToken();
//       });
//     }
//   }
// }

// void _refreshToken() async {
//   String? refreshToken = await SecureStorage().readData("RefreshToken");
//   String? accessToken =
//       await SecureStorage().storage.read(key: "AccessToken");
//   if (accessToken != null &&
//       refreshToken != null &&
//       _isTokenExpired(accessToken)) {
//     final result = await UserRequest.refreshToken(refreshToken);
//     if (result.success) {
//       _updateToken(result.data["accessToken"], result.data["refreshToken"]);
//     } else {
//       print('Failed to refresh token: ${result.message}');
//     }
//   }
// }

// bool _isTokenExpired(String accessToken) {
//   try {
//     Map<String, dynamic> decodedToken = Jwt.parseJwt(accessToken);
//     int? expirationTime = decodedToken['exp'];
//     if (expirationTime != null) {
//       DateTime now = DateTime.now();
//       DateTime tokenExpiration =
//           DateTime.fromMillisecondsSinceEpoch(expirationTime * 1000);
//       return now.isAfter(tokenExpiration);
//     }
//   } catch (e) {
//     print('Failed to parse token: $e');
//   }
//   return true;
// }

// int _getTokenExpirationTime(String accessToken) {
//   try {
//     Map<String, dynamic> decodedToken = Jwt.parseJwt(accessToken);
//     int? expirationTime = decodedToken['exp'];
//     return expirationTime ?? 0;
//   } catch (e) {
//     print('Failed to parse token: $e');
//     return 0;
//   }
// }

// void _updateToken(String? newToken, String? refreshToken) {
//   SecureStorage().storage.write(key: "AccessToken", value: newToken);
//   SecureStorage().storage.write(key: "RefreshToken", value: refreshToken);
// }

// Future<void> refreshTokenIfNeededOnStartup() async {
//   String? refreshToken = await SecureStorage().readData("RefreshToken");
//   String? accessToken =
//       await SecureStorage().storage.read(key: "AccessToken");
//   if (accessToken != null &&
//       refreshToken != null &&
//       _isTokenExpired(accessToken)) {
//     final result = await UserRequest.refreshToken(refreshToken);
//     if (result.success) {
//       _updateToken(result.data["accessToken"], result.data["refreshToken"]);
//     } else {
//       print('Failed to refresh token: ${result.message}');
//     }
//   }
// }

// void cancelTokenRefreshTimer() {
//   _timer.cancel();
// }

//   void startTimerFromTokenDuration() async {
//     String? accessKey = await SecureStorage().storage.read(key: 'AccessKey');
//     if (accessKey != null) {
//       // Отримати тривалість токену і перетворити її в мілісекунди (припустимо, що це значення в мілісекундах)
//       int tokenDuration = int.parse(
//           accessKey); // Припустимо, що тут зберігається час в мілісекундах
//       timer = Timer(Duration(milliseconds: tokenDuration), () {
//         // Виконати код, коли таймер завершиться (наприклад, вивести повідомлення)
//         print('Токен завершився');
//       });
//     } else {
//       print('Помилка: Неможливо отримати доступ до ключа "AccessKey"');
//     }
//   }
// }

class TokenTimer {
  Timer? _timer;

  TokenTimer() {
    startTimer();
  }

  void startTimer() {
    print("старт");
    SecureStorage().storage.read(key: 'AccessToken').then((expiration) {
      if (expiration != null) {
        Map<String, dynamic> decodedToken = Jwt.parseJwt(expiration);
        if (decodedToken.containsKey('exp')) {
          int expirationTimeInSeconds = decodedToken['exp'];
          int currentTimeInSeconds =
              DateTime.now().millisecondsSinceEpoch ~/ 1000;
          int difference = expirationTimeInSeconds - currentTimeInSeconds;
          if (difference > 0) {
            // Виводимо початковий відлік секунд
            print('Час до закінчення дії токену: $difference сек');

            _timer = Timer.periodic(Duration(seconds: 1), (timer) {
              currentTimeInSeconds =
                  DateTime.now().millisecondsSinceEpoch ~/ 1000;
              difference = expirationTimeInSeconds - currentTimeInSeconds;
              if (difference > 0) {
                // Оновлюємо відлік секунд що залишилися
                print('Час до закінчення дії токену: $difference сек');
              } else {
                refreshToken();
                print('Час дії токену закінчився');
              }
            });
          } else {
            refreshToken();
            print('Токен вже закінчився');
          }
        } else {
          print('Токен не містить часу закінчення (exp)');
        }
      }
    }).catchError((error) {
      print('Помилка при отриманні часу дії токену: $error');
    });
  }

  void refreshToken() async {
    // Отримуємо refreshToken з secure storage
    String? refreshToken =
        await SecureStorage().storage.read(key: 'RefreshToken');
    if (refreshToken != null) {
      // Відправляємо запит на оновлення токену до бекенда
      ServiceResult result = await UserRequest.refreshToken(refreshToken);
      if (result.success) {
        // Якщо оновлення токену успішне, оновлюємо accessToken та refreshToken у secure storage
        await SecureStorage()
            .storage
            .write(key: 'AccessToken', value: result.data['accessToken']);
        await SecureStorage()
            .storage
            .write(key: 'RefreshToken', value: result.data['refreshToken']);
        // Починаємо новий таймер для нового accessToken
        //startTimer();
      } else {
        print('Не вдалося оновити токен: ${result.message}');
      }
    } else {
      print('Не вдалося отримати refreshToken з secure storage');
    }
  }

  void cancelTimer() {
    // Скасовуємо таймер, якщо він існує
    _timer?.cancel();
  }
}
