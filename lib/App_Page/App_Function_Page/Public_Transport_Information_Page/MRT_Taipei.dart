import 'package:traffic_hero/App_Page/App_Function_Page/Public_Transport_Information_Page/MRT_Taipei_DynamicInfo.dart';
import 'package:traffic_hero/Imports.dart';

class MRT_Taipei extends StatefulWidget {
  const MRT_Taipei({Key? key}) : super(key: key);

  @override
  State<MRT_Taipei> createState() => _MRT_TaipeiState();
}
const List<String> lineName = <String>['BR','R','G','O','BL','Y'];
var screenWidth;
var _selectedItem=null;
var state ;
var stationState = [{"":""}];

class _MRT_TaipeiState extends State<MRT_Taipei> {


  // Widget scrollView(ScrollController scrollController) {
  //   return SizedBox(
  //       child:ListView(
  //         controller: scrollController,
  //         children: [
  //           //搜尋欄
  //           ListTile(
  //               leading: Icon(
  //                 Icons.search,
  //                 color: Color.fromRGBO(46, 80, 140, 1),
  //                 size: 28,
  //               ),
  //               title: DropdownButton<String>(
  //                 value: _selectedItem,
  //                 onChanged: (String? newValue) {
  //                   setState(() {
  //                     _selectedItem = newValue!;
  //                   });
  //                 },
  //                 items: lineName.map((String value) {
  //                   return DropdownMenuItem<String>(
  //                     value: value,
  //                     child: Text(value),
  //                   );
  //                 }).toList(),
  //               ),
  //             trailing: TextButton(
  //               onPressed: () {
  //                 updateStationState();
  //               },
  //               child: Text('搜尋'),
  //             ),
  //           ),
  //           ClipRRect(
  //             borderRadius: BorderRadius.all(Radius.circular(30)),
  //             child: Container(
  //               alignment: Alignment.bottomLeft,
  //               margin: EdgeInsets.only(left: 20,right: 20),
  //               padding: EdgeInsets.all(5),
  //               color: Color.fromRGBO(165, 201, 233, 1),
  //               child: Text('列車動態',style: TextStyle(color: Color.fromRGBO(29, 73, 153, 1),fontSize: 18),textAlign:TextAlign.center,),
  //             ),
  //           ),
  //
  //
  //         ],
  //       )
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    state = Provider.of<stateManager>(context, listen: false);
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body:WebViewForMRT(
          tt: 'https://tw.piliapp.com/mrt-taiwan/taipei/',
        ),
         floatingActionButton: FloatingActionButton(
             child: Icon(CupertinoIcons.arrow_up_arrow_down_circle_fill),
             onPressed: (){{
               Future.delayed(Duration(seconds: 1),(){
                 Navigator.push(context, MaterialPageRoute(builder: (context) => MRT_Taipei_DynamicInfo()));
               });;
             }}
         ),
    );
  }
}
