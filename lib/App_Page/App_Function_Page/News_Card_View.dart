// ignore_for_file: file_names, must_be_immutable, prefer_typing_uninitialized_variables, non_constant_identifier_names
import 'package:traffic_hero/Imports.dart';

class NewsCardView extends StatefulWidget {
  NewsCardView({super.key, required this.list_view});

  var list_view;

  @override
  State<NewsCardView> createState() => _NewsCardViewState();
}

class _NewsCardViewState extends State<NewsCardView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('data'),
    );
  }
}
