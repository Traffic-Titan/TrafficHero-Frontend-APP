// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, sized_box_for_whitespace, avoid_print
import 'package:traffic_hero/imports.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: 600,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: Center(
            child: ListView.builder(
               itemCount: 7,
              itemBuilder: (context, index) => Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                
                contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                
                title: Text('$index'),

                onTap: () {
                  print(dotenv.env['ios_sso_REVERSED_CLIENT_I_KEY']);
                },
                ),
                
            ),)),
      ),
    ));
  }
}
