// ignore_for_file: file_names, camel_case_types, use_super_parameters, prefer_typing_uninitialized_variables

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
    return const Stack(
        children:[
          WebViewForMRT(
            tt: 'https://tw.piliapp.com/mrt-taiwan/ankang/',
          ),
        ]
    );
  }
}
