import 'package:traffic_hero/Imports.dart';

class MRT_Taichung extends StatefulWidget {
  const MRT_Taichung({Key? key}) : super(key: key);

  @override
  State<MRT_Taichung> createState() => _MRT_TaichungState();
}

class _MRT_TaichungState extends State<MRT_Taichung> {
  @override
  Widget build(BuildContext context) {
    return Image.network("https://www.funtime.com.tw/blog/wp-content/uploads/2020/09/116-700x700.jpg",fit: BoxFit.fill);
  }
}
