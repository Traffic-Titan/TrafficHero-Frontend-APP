
// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, unnecessary_new, avoid_print, use_build_context_synchronously


import 'Imports.dart';
// import 'firebase_options.dart';

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp()s;
  // await FlutterConfig.loadEnvVariables();
// await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
// );
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
  runApp(ChangeNotifierProvider(
      create: (context) => stateManager(),
      child: MyApp(),
    ),);
}


class _MyAppState extends State<MyApp> {
  late SharedPreferences prefs;
  late stateManager state;



  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    prefs = await SharedPreferences.getInstance();
    EasyLoading.dismiss();
  }

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
