import 'package:traffic_hero/Imports.dart';

class MRT_Kaohsiung extends StatefulWidget {
  const MRT_Kaohsiung({Key? key}) : super(key: key);

  @override
  State<MRT_Kaohsiung> createState() => _MRT_KaohsiungState();
}

class _MRT_KaohsiungState extends State<MRT_Kaohsiung> {
  @override
  Widget build(BuildContext context) {
    return Image.network("https://www.krtc.com.tw/Content/userfiles/images/guide-map.jpg?v=c24_1",fit: BoxFit.fill);
  }
}
