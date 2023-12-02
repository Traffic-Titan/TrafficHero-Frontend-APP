import '../Imports.dart';



  Future<void> handleBackgroundMessage(RemoteMessage message) async {
      print('title:${message.notification?.title}');
       print('body:${message.notification?.body}');
        print('payload:${message.data}');
  }


class Firebase_message{
  final _firebaseMess = FirebaseMessaging.instance;



  Future<void> initNotifications()async{
    await _firebaseMess.requestPermission();
    final fCMToken = await _firebaseMess.getToken();
    print('Token:$fCMToken');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('App opened from background message:');
      print('title: ${message.notification?.title}');
      print('body: ${message.notification?.body}');
      print('payload: ${message.data}');
    });
        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('App opened from background message:');
      print('title: ${message.notification?.title}');
      print('body: ${message.notification?.body}');
      print('payload: ${message.data}');
    });
  }
}