import '../Imports.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('title:${message.notification?.title}');
  print('body:${message.notification?.body}');
  print('payload:${message.data}');

  // 使用 Map 類型來構建新的訊息
  final newMessage = {
    'title': message.notification?.title,
    'body': message.notification?.body,
    'payload': message.data
  };



  try {
    await saveList(newMessage);
  } catch (e) {
    print(e);
  }

}

Future<void> saveList(messagelist) async {
  print('開始儲存');
  List<dynamic> message = [];
  late SharedPreferences prefs;
  prefs = await SharedPreferences.getInstance();

  try {
    final storedMessage = prefs.getString('message');
    final decodedMessage = json.decode(storedMessage!.trim()) as List<dynamic>;
    print("加入之前" + decodedMessage.toString());
    if (decodedMessage is List) {
      message = decodedMessage;
      print(message);
      print(message.length);
    }
    ;

    message.add(messagelist);
    prefs.setString('message', json.encode(message));
    print("saveList加入之後" +prefs.getString('message').toString());
  } catch (e) {
    print(e);
  }
}

class Firebase_message {
  final _firebaseMess = FirebaseMessaging.instance;
  List<dynamic> messageList = [];
  late SharedPreferences prefs;
  late stateManager state;

  Future<void> UpdateContext(context) async {
    state = Provider.of<stateManager>(context, listen: false);
  }

  Future<void> initNotifications() async {
    prefs = await SharedPreferences.getInstance();
    await _firebaseMess.requestPermission();
    final fCMToken = await _firebaseMess.getToken();
    print('Token:$fCMToken');
    if (prefs.get('userToken') != '') {
      await registerMessageToken(fCMToken);
    }

    
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('App opened from onMessageOpenedApp message:');
      print('title: ${message.notification?.title}');
      print('body: ${message.notification?.body}');
      print('payload: ${message.data}');

      final newMessage = {
    'title': message.notification?.title,
    'body': message.notification?.body,
    'payload': message.data
  };



  try {
     saveList(newMessage);
  } catch (e) {
    print(e);
  }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('App opened from onMessage message:');
      print('title: ${message.notification?.title}');
      print('body: ${message.notification?.body}');
      print('payload: ${message.data}');

      // 初始化 messageList，以防它為 null
      messageList ??= [];

      // 使用 Map 類型來構建新的訊息
      final newMessage = {
        'title': message.notification?.title,
        'body': message.notification?.body,
        'payload': message.data
      };
      await saveList(newMessage);
      // messageList.add(newMessage);
      // prefs.setString('message', json.encode(messageList));
      // try {
      //   await update().Update(messageList);
      // } catch (e) {
      //   print(e);
      // }

      // state.UpdateMessageList(messageList);
      // print(messageList);
    });
  }

  Future<void> registerMessageToken(token) async {
    // EasyLoading.show(status: '開始註冊');
    print('註冊');
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
      // EasyLoading.showError('FCME'+e.toString());
      print(e);
    }
  }
}
