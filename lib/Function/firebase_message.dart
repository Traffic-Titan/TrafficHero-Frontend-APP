import '../Imports.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('title:${message.notification?.title}');
  print('body:${message.notification?.body}');
  print('payload:${message.data}');
}

class Firebase_message {
  final _firebaseMess = FirebaseMessaging.instance;
  List<dynamic> messageList = [];
  late SharedPreferences prefs;

  Future<void> initNotifications() async {
    prefs = await SharedPreferences.getInstance();
    await _firebaseMess.requestPermission();
    final fCMToken = await _firebaseMess.getToken();
    if (prefs.get('userToken') != '') {
      await registerMessageToken(fCMToken);
    }

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

      messageList.add({
        'title': message.notification?.title,
        'body': message.notification?.body,
        'payload': message.data
      });

      print(messageList);
    });
  }

  Future<void> registerMessageToken(token) async {
    var response,
        url = dotenv.env['Subscribe'].toString() + '?fcm_token=${token}',
        jwt = ',${prefs.get('userToken')}',
        Body;

    try {
      response = await api().apiPost(Body, url, jwt);
      if (response.statusCode == 200) {
        print(true);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }
}
