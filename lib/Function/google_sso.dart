// ignore_for_file: camel_case_types, avoid_print, unnecessary_null_in_if_null_operators, non_constant_identifier_names
import 'package:traffic_hero/imports.dart';

class googlesso extends GetxController {
  var googleSignIn = GoogleSignIn();
  var googleSgnout = GoogleSignIn().signOut();
  var googleAccount = Rx<GoogleSignInAccount?>(null);
  var isAuthorized = false;
  var scopes = <String>[];

  Future<void> google() async {
    try {
      googleAccount.value = await googleSignIn.signIn();
    } on PlatformException catch (e) {
      if (e.code == 'channel-error') {
        print('object');
      }
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

  Future<void> google_signOut() async {
    try {
      googleAccount.value = await googleSignIn.signOut();
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

  Future<User?> signinWithGoogle() async {
    GoogleSignInAccount? gUser;
    try {
      gUser = await googleSignIn.signIn();
    } on PlatformException {
      print('signout');
      // Handle the platform exception here.
    } on FormatException catch (e) {
      print("FormatException: ${e.message}");
      // Handle the format exception here.
    } catch (e) {
      print("Other Exception: ${e.toString()}");
      // Handle other exceptions here.
    }

    if (gUser != null) {
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredential.user;
    }

    return null;
  }
}
