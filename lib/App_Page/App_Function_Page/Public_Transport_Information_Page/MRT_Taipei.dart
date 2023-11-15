import 'package:traffic_hero/Imports.dart';

class MRT_Taipei extends StatefulWidget {
  const MRT_Taipei({Key? key}) : super(key: key);

  @override
  State<MRT_Taipei> createState() => _MRT_TaipeiState();
}

class _MRT_TaipeiState extends State<MRT_Taipei> {
  @override
  Widget build(BuildContext context) {
    return Image.network("https://web.metro.taipei/img/all/metrotaipeimap.jpg");
  }
}
