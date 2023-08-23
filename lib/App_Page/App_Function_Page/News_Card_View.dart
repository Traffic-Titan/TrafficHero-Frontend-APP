// ignore_for_file: file_names, must_be_immutable, prefer_typing_uninitialized_variables, non_constant_identifier_names, sized_box_for_whitespace, prefer_const_constructors
import 'package:traffic_hero/Imports.dart';

class NewsCardView extends StatefulWidget {
  NewsCardView({super.key, required this.listView});

  var listView;

  @override
  State<NewsCardView> createState() => _NewsCardViewState();
}

class _NewsCardViewState extends State<NewsCardView> {
  @override
  void initState() {
    super.initState();
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width - 50,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.listView['NewsCategory'].toString(),
                      style: const TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    const Text(
                      ' | ',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    Text(
                      widget.listView['UpdateTime'].toString(),
                      style: const TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ],
                ),
                Text(
                  widget.listView['Title'].toString(),
                  style: TextStyle(fontSize: 25),
                ),
                const SizedBox(
                  height: 50,
                ),
                Center(
                    child: Text(
                  widget.listView['Description'].toString(),
                  style:const TextStyle(fontSize: 19),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
