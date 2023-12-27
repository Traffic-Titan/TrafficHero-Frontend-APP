// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, unnecessary_new, avoid_print, use_build_context_synchronously

import 'package:traffic_hero/firebase_options.dart';

import 'Imports.dart';

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  try {
    //firebase初始化
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    //firebase 訊息初始化
    await Firebase_message().initNotifications();
    //定位請求初始化
    await Geolocator.isLocationServiceEnabled();
  } catch (e) {
    print(e);
  }

  runApp(
    ChangeNotifierProvider(
      create: (context) => stateManager(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

@pragma('vm:entry-point')
void pipMain() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => stateManager(),
      child: MyApp(),
    ),
  );
}

class _MyAppState extends State<MyApp> {
  late SharedPreferences prefs;
  late stateManager state;



  @override
  Widget build(BuildContext context) {
    return PiPMaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: appLoadingPage(),
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
    );
  }
}
