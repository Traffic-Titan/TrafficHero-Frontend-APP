import 'package:traffic_hero/imports.dart';


class News extends StatelessWidget {
  const News({super.key});

  @override
  Widget build(BuildContext context) {
   // ignore: unused_local_variable
   String state = Provider.of<stateManager>(context).modeName;
   print(state);
    return const Placeholder();
  }
}