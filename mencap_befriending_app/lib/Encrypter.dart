import 'dart:convert';
import 'package:crypto/crypto.dart' ;

class Encrypter
{  // The 4 print()s are just for testing, they can be removed if the function works successfully.
  String encryptBase64(String str) {
      print("Text before Base64 encryption: " + str);
      var content = utf8.encode(str);
      var digest = base64Encode(content);
      String base64String = digest.toString();
      print("Base64 encrypted text: " + base64String);
      return base64String;
  }

  String decryptBase64(String encStr) {
      print("Text before Base64 decryption:" + encStr);
      String base64String = String.fromCharCodes(base64Decode(encStr));
      print("Text after Base64 decryption:" + base64String);
      return base64String;
  }

  String hashPassword(String password) {
  // Encode the password using UTF-8
  var bytes = utf8.encode(password);

  // Hash the bytes using SHA-256
  var digest = sha256.convert(bytes);

  // Convert the digest to a hexadecimal string
  return digest.toString();
}

}