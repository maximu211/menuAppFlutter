import 'dart:io';
import 'package:flutter/services.dart';

class SSLCertificateManager {
  // Приватне поле для зберігання сертифіката
  static Uint8List? _certificateBytes;

  // Метод для завантаження SSL-сертифіката
  static Future<void> loadCertificate() async {
    if (_certificateBytes == null) {
      ByteData data =
          await rootBundle.load('assets/certificate/CertMenuApp.cer');
      _certificateBytes = data.buffer.asUint8List();
    }
  }

  static SecurityContext getSecurityContext() {
    SecurityContext context = SecurityContext.defaultContext;
    if (_certificateBytes != null) {
      context.setTrustedCertificatesBytes(_certificateBytes!);
    }
    return context;
  }
}
