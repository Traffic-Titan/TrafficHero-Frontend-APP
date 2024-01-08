// ignore_for_file: file_names

import 'package:traffic_hero/imports.dart';

//密碼加密
class Sha256 {
  String sha256Function(String password) {
    var bytes1 = utf8.encode(password); // 將數據轉換為字節數組
    var digest1 = sha256.convert(bytes1);
    return digest1.toString();
  }
}
