// ignore_for_file: file_names, camel_case_types, use_super_parameters, prefer_typing_uninitialized_variables

import 'package:traffic_hero/Imports.dart';

class MRT_DanhaiLRT extends StatefulWidget {
  const MRT_DanhaiLRT({Key? key}) : super(key: key);

  @override
  State<MRT_DanhaiLRT> createState() => _MRT_DanhaiLRTState();
}
var screenWidth;

class _MRT_DanhaiLRTState extends State<MRT_DanhaiLRT> {
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return const Stack(
        children:[
          WebViewForMRT(
            tt: 'https://tw.piliapp.com/mrt-taiwan/danhai/',
          ),
        ]
    );
  }
}
