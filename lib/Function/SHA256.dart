// ignore_for_file: file_names

import 'package:traffic_hero/imports.dart';

//密碼加密
class Sha256 {
  String sha256Function(String password) {
    var bytes1 = utf8.encode(password); // 将数据转换为字节数组
    var digest1 = sha256.convert(bytes1);
    return digest1.toString();
  }
}
