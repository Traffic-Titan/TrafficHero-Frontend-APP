import 'package:traffic_hero/Imports.dart';

class MRT_Taoyuan extends StatefulWidget {
  const MRT_Taoyuan({Key? key}) : super(key: key);

  @override
  State<MRT_Taoyuan> createState() => _MRT_TaoyuanState();
}

class _MRT_TaoyuanState extends State<MRT_Taoyuan> {
  @override
  Widget build(BuildContext context) {
    return Image.network("https://blog.tripbaa.com/wp-content/uploads/2018/05/road_02-1_big.jpg");
  }
}
