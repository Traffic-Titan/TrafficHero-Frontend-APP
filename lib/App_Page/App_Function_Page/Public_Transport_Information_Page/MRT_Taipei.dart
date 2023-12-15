// ignore_for_file: file_names, camel_case_types, use_super_parameters, prefer_typing_uninitialized_variables, prefer_const_constructors, sort_child_properties_last

import 'package:traffic_hero/App_Page/App_Function_Page/Public_Transport_Information_Page/MRT_Taipei_DynamicInfo.dart';
import 'package:traffic_hero/Imports.dart';

class MRT_Taipei extends StatefulWidget {
  const MRT_Taipei({Key? key}) : super(key: key);

  @override
  State<MRT_Taipei> createState() => _MRT_TaipeiState();
}
const List<String> lineName = <String>['BR','R','G','O','BL','Y'];
var screenWidth;
var state ;
var stationState = [{"":""}];

class _MRT_TaipeiState extends State<MRT_Taipei> {

  @override
  Widget build(BuildContext context) {
    state = Provider.of<stateManager>(context, listen: false);
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body:WebViewForMRT(
          tt: 'https://tw.piliapp.com/mrt-taiwan/taipei/',
        ),
         floatingActionButton: FloatingActionButton(
             child: Image.asset('assets/publicTransportIcon/MRTRouteMap.png',height: 40,width: 40,),
             backgroundColor: Color.fromRGBO(187, 214, 239, 1),
             onPressed: (){{
               Future.delayed(Duration(seconds: 1),(){
                 Navigator.push(context, MaterialPageRoute(builder: (context) => MRT_Taipei_DynamicInfo()));
               });
             }}
         ),
    );
  }
}
