import 'package:traffic_hero/Imports.dart';

class MRT_Taichung extends StatefulWidget {
  const MRT_Taichung({Key? key}) : super(key: key);

  @override
  State<MRT_Taichung> createState() => _MRT_TaichungState();
}

class _MRT_TaichungState extends State<MRT_Taichung> {
  var screenWidth;
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Stack(
        children:[
          WebViewForMRT(
            tt: 'https://tw.piliapp.com/mrt-taiwan/taichung/',
          ),
        ]
    );
  }
}
