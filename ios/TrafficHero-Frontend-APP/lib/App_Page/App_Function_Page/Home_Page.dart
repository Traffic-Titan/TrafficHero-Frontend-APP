// ignore_for_file: file_names, avoid_unnecessary_containers
import 'package:traffic_hero/imports.dart';



class Home extends StatelessWidget {
  const Home({Key? key,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
   // ignore: unused_local_variable
   var state = Provider.of<stateManager>(context).accountState;
   // ignore: avoid_print
   print(state);
   return Container(
        child : const SingleChildScrollView(
        ));
  }
}