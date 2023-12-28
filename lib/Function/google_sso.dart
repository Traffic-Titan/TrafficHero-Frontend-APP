// ignore_for_file: camel_case_types, avoid_print, unnecessary_null_in_if_null_operators, non_constant_identifier_names, file_names
import 'package:traffic_hero/Imports.dart';

class googlesso extends GetxController {
  var googleSignIn = GoogleSignIn();
  var googleSgnout = GoogleSignIn().signOut();
  var googleAccount = Rx<GoogleSignInAccount?>(null);
  var isAuthorized = false;
  var scopes = <String>[];

//google登入
  Future<void> google() async {
    try {
      googleAccount.value = await googleSignIn.signIn();
    } catch (e) {
      print(e);
    }
  }
//google登出
  Future<void> google_signOut() async {
    googleAccount.value = await googleSignIn.signOut();
  }
}
