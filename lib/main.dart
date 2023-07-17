// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api
import 'imports.dart';

void main() {
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
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:const All_Page(),
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
    );
  }
}
