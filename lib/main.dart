// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, unnecessary_new
import 'imports.dart';

void main() async{
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

      await geolocator().updataPosition();

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


class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch:   Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const Login(),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{'/ALLpage': (_) => new All_Page()},
      builder: EasyLoading.init(),
    );
  }
}

