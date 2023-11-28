import 'package:traffic_hero/Imports.dart';

class MRT_AnkengLRT extends StatefulWidget {
  const MRT_AnkengLRT({Key? key}) : super(key: key);

  @override
  State<MRT_AnkengLRT> createState() => _MRT_AnkengLRTState();
}
var screenWidth;


class _MRT_AnkengLRTState extends State<MRT_AnkengLRT> {
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Stack(
        children:[
          WebViewForMRT(
            tt: 'https://tw.piliapp.com/mrt-taiwan/ankang/',
          ),
        ]
    );
  }
}
