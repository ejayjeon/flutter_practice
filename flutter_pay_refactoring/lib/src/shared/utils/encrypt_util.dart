import 'dart:developer';

import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptUtil {
  EncryptUtil._();

  static cryptAES({
    required String plainText,
    required toEncrypt,
    String? passKey,
  }) {
    String aesKey = const String.fromEnvironment("AES_KEY");
    const padding = "PKCS7";

    try {
      final key = encrypt.Key.fromUtf8(passKey ?? aesKey);
      final iv = encrypt.IV.fromLength(16);
      final encrypter = encrypt.Encrypter(
          encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: padding));
      return toEncrypt
          ? encrypter.encrypt(plainText, iv: iv).base64
          : encrypter.decrypt64(plainText, iv: iv);
    } catch (e) {
      log("에러발생: $e", name: "encryptAES");
      // rethrow;
    }
  }
}
