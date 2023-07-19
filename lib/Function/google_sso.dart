// ignore_for_file: unused_field, prefer_final_fields, camel_case_types

import 'package:traffic_hero/imports.dart';

class googlesso extends GetxController {
  var _googleSignin = GoogleSignIn();
  var googleAccount = Rx<GoogleSignInAccount?>(null);
  var googleAccount1 = Rx<GoogleIdentity?>(null);

  googleLogin () async {
    googleAccount.value = await _googleSignin.signIn();
  }
}