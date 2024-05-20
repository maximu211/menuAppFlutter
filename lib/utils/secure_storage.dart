import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';

class SecureStorage {
  static final SecureStorage _instance = SecureStorage._internal();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  factory SecureStorage() {
    return _instance;
  }

  SecureStorage._internal();

  FlutterSecureStorage get storage => _storage;

  Future<String?> readData(String key) async {
    return await _storage.read(key: key);
  }

  Future<String?> getUserIdFromToken() async {
    // Отримуємо токен з сховища
    String? token = await readData("AccessToken");
    if (token == null) {
      return null;
    }
    
    // Розпаковуємо токен і отримуємо userId
    Map<String, dynamic> decodedToken = Jwt.parseJwt(token);
    return decodedToken['userId'] as String?;
  }
}
