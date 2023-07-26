// ignore_for_file: camel_case_types, prefer_final_fields, avoid_print

import 'package:traffic_hero/imports.dart';

class googlesso extends GetxController {
  var _googleSignin = GoogleSignIn();
  var googleAccount = Rx<GoogleSignInAccount?>(null);
  var googleAccount1 = Rx<GoogleIdentity?>(null);

  Future<void> googleLogin() async {
    try {
     
        googleAccount.value = await _googleSignin.signIn();
      
    } on PlatformException catch (e) {
      print("PlatformException: ${e.message}");
      // Handle the platform exception here.
    } on FormatException catch (e) {
      print("FormatException: ${e.message}");
      // Handle the format exception here.
    } catch (e) {
      print("Other Exception: ${e.toString()}");
      // Handle other exceptions here.
    }
  }
}
