// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, unnecessary_new, avoid_print, use_build_context_synchronously
import 'Imports.dart';

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

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
  late SharedPreferences prefs;
  late stateManager state;
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    prefs = await SharedPreferences.getInstance();
    state = Provider.of<stateManager>(context, listen: false);
    await getOperationalStatus();
    EasyLoading.dismiss();
  }

  getOperationalStatus() async {
    var position = await geolocator().updataPosition();
    var url =
        '${dotenv.env['OperationalStatus']}?longitude=${position.longitude}&latitude=${position.latitude}';
    var jwt = ',${prefs.get('userToken')}';

    var response = await api().apiGet(url, jwt);
    print(jsonDecode(utf8.decode(response.bodyBytes)));
    if (response.statusCode == 200) {
      state
          .updateOperationalStatus(jsonDecode(utf8.decode(response.bodyBytes)));
      print(state.OperationalStatus);
      print('${state.OperationalStatus}test');
    } else {
      print(jsonDecode(utf8.decode(response.bodyBytes)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const Login(),
      debugShowCheckedModeBanner: true,
      builder: EasyLoading.init(),
    );
  }
}
