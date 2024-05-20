import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:menuapp/http/DTOs/dtos.dart';
import 'package:menuapp/http/DTOs/result.dart';
import 'package:menuapp/http/routes.dart';
import 'package:menuapp/utils/secure_storage.dart';

class UserRequest {
  static Future<TokenFetchResult> logIn(
      String password, String username) async {
    final StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(BaseRoutes.baseUrl);
    stringBuffer.write(BaseRoutes.user);
    stringBuffer.write(UserRoutes.logIn);

    final response = await http.post(
      Uri.parse(stringBuffer.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'password': password, 'username': username}),
    );

    return TokenFetchResult.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }

  static Future<ServiceResult> logOut() async {
    final StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(BaseRoutes.baseUrl);
    stringBuffer.write(BaseRoutes.user);
    stringBuffer.write(UserRoutes.logOut);

    final String? accessToken =
        await SecureStorage().storage.read(key: "AccessToken");

    final response = await http.post(
      Uri.parse(stringBuffer.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      return ServiceResult.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception();
    }
  }

  static Future<TokenFetchResult> refreshToken(String refreshToken) async {
    final StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(BaseRoutes.baseUrl);
    stringBuffer.write(BaseRoutes.user);
    stringBuffer.write(UserRoutes.refreshToken);

    final response = await http.post(
      Uri.parse(stringBuffer.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'refreshToken': refreshToken,
      }),
    );


      return TokenFetchResult.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
  }

  static Future<AuthTokenFetch> registerEmail(String email) async {
    final StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(BaseRoutes.baseUrl);
    stringBuffer.write(BaseRoutes.user);
    stringBuffer.write(UserRoutes.registerEmail);

    final response = await http.post(
      Uri.parse(stringBuffer.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );

    return AuthTokenFetch.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }

  static Future<ServiceResult> verifyEmail(String code) async {
    final StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(BaseRoutes.baseUrl);
    stringBuffer.write(BaseRoutes.user);
    stringBuffer.write(UserRoutes.verifyEmail);

    final String? authToken =
        await SecureStorage().storage.read(key: "AuthToken");

    final response = await http.post(
      Uri.parse(stringBuffer.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode(<String, String>{
        'confirmationCode': code,
      }),
    );

    return ServiceResult.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }

  static Future<ServiceResult> updateEmail(String newEmail) async {
    final StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(BaseRoutes.baseUrl);
    stringBuffer.write(BaseRoutes.user);
    stringBuffer.write(UserRoutes.updateEmailAndSendCode);

    final String? authToken =
        await SecureStorage().storage.read(key: "AuthToken");

    final response = await http.post(
      Uri.parse(stringBuffer.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode(<String, String>{
        'newEmail': newEmail,
      }),
    );

    return ServiceResult.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }

  static Future<ServiceResult> resendConfirmationCode() async {
    final StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(BaseRoutes.baseUrl);
    stringBuffer.write(BaseRoutes.user);
    stringBuffer.write(UserRoutes.resendConfirmationCode);

    final String? authToken =
        await SecureStorage().storage.read(key: "AuthToken");

    final response = await http.get(
      Uri.parse(stringBuffer.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $authToken',
      },
    );

    return ServiceResult.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }

  static Future<AuthTokenFetch> sendCodeToRecoverPassword(
      String userName) async {
    final StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(BaseRoutes.baseUrl);
    stringBuffer.write(BaseRoutes.user);
    stringBuffer.write(UserRoutes.sendCodeToRecoverPassword);

    final response = await http.post(
      Uri.parse(stringBuffer.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': userName,
      }),
    );

    return AuthTokenFetch.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }

  static Future<ServiceResult> verifyPasswordRecover(String code) async {
    final StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(BaseRoutes.baseUrl);
    stringBuffer.write(BaseRoutes.user);
    stringBuffer.write(UserRoutes.verifyPasswordRecover);

    final response = await http.post(
      Uri.parse(stringBuffer.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'verificationCode': code,
      }),
    );

    return ServiceResult.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }

  static Future<ServiceResult> setNewPassword(
      String password, String repeatPassword) async {
    final StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(BaseRoutes.baseUrl);
    stringBuffer.write(BaseRoutes.user);
    stringBuffer.write(UserRoutes.setNewPassword);

    final response = await http.post(
      Uri.parse(stringBuffer.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "password": password,
        "repeatPassword": repeatPassword
      }),
    );

    return ServiceResult.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }

  static Future<ServiceResult> registerUser(
      String password, String repeatPassword, String username) async {
    final StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(BaseRoutes.baseUrl);
    stringBuffer.write(BaseRoutes.user);
    stringBuffer.write(UserRoutes.setNewPassword);

    final String? authToken =
        await SecureStorage().storage.read(key: "AuthToken");

    final response = await http.post(
      Uri.parse(stringBuffer.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode(<String, String>{
        "password": password,
        "repeatePassword": repeatPassword,
        "username": username
      }),
    );

    return ServiceResult.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }

  static Future<ServiceResult> setUserImage(String image) async {
    final StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(BaseRoutes.baseUrl);
    stringBuffer.write(BaseRoutes.user);
    stringBuffer.write(UserRoutes.setUserImage);

    final String? accessToken =
        await SecureStorage().storage.read(key: "AccessToken");

    final response = await http.post(
      Uri.parse(stringBuffer.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(<String, String>{
        "image": image,
      }),
    );

    return ServiceResult.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }

  static Future<FetchUserImage> getUserImage() async {
    final StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(BaseRoutes.baseUrl);
    stringBuffer.write(BaseRoutes.user);
    stringBuffer.write(UserRoutes.getUserImage);

    final String? accessToken =
        await SecureStorage().storage.read(key: "AccessToken");

    final response = await http.get(
      Uri.parse(stringBuffer.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
    );

    return FetchUserImage.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }

    static Future<UserPageDataDto> getUserPageData(String userId) async {
    final StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(BaseRoutes.baseUrl);
    stringBuffer.write(BaseRoutes.user);
    stringBuffer.write(UserRoutes.userPage);
    stringBuffer.write("/$userId");

    final String? accessToken =
        await SecureStorage().storage.read(key: "AccessToken");

    final response = await http.get(
      Uri.parse(stringBuffer.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
    );

    return UserPageDataDto.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }
}
