// ignore_for_file: file_names, camel_case_types, unnecessary_import

import 'package:traffic_hero/App_Page/App_Function_Page/Public_Transport_Information_Page/Public_Transport_Information_Highway.dart';
import 'package:traffic_hero/Imports.dart';

class Public_Transport_Information extends StatefulWidget {
  const Public_Transport_Information({super.key});

  @override
  State<Public_Transport_Information> createState() => _Public_Transport_InformationState();
}

class _Public_Transport_InformationState extends State<Public_Transport_Information> with TickerProviderStateMixin{
  // ignore: unused_field
  late TabController _tabController;
  late stateManager state;
  var nearbyStation_list = [];
  var stationView_list = [];
  var stationViewResult_list = [];
  var screenWidth;
  var screenHeight;
  var positionNow;
  var position;

  // static const List<Tab> publicTransportationBar = <Tab>[
  //   Tab(text: '腳踏車'),
  //   Tab(text: '公車'),
  //   Tab(text: '捷運'),
  //   Tab(text: '台鐵'),
  //   Tab(text: '高鐵'),
  // ];

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
    positionNow = state.positionNow;
    screenWidth = MediaQuery. of(context). size. width ;
    screenHeight = MediaQuery. of(context). size. height;
    position = await geolocator().updataPosition();
    // 取得附近站點有哪些
    // getNearbyStation();
  }
  @override
  void initState() {
    super.initState();
    // _tabController = TabController(vsync: this, length: publicTransportationBar.length);
  }
  @override
  void dispose() {
    // _tabController.dispose();
    super.dispose();
  }
  // //取得附近站點有哪些
  // getNearbyStation() async{
  //   var response;
  //   var jwt = ',${state.accountState}';
  //   // 先讀取附近站點有哪些腳踏車資訊
  //   var nearbyStationURL = dotenv.env['StationNearbyBike']! + '?latitude=${position.latitude}&longitude=${position.longitude}';
  //   try {
  //     response = await api().apiGet(nearbyStationURL, jwt);
  //     var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
  //     if (response.statusCode == 200) {
  //       // 將API讀取到的所有附近站點加入陣列
  //       nearbyStation_list = responseBody;
  //       // 取得大眾運輸資訊
  //       getPublicTransportation();
  //     } else {
  //       print(jsonDecode(utf8.decode(response.bodyBytes)).toString());
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  //腳踏車附近站點
  stationNearbySearchBus() async{
    var jwt = ',${state.accountState}';
    var position = await geolocator().updataPosition();
    var url= '${dotenv.env['StationNearbyBus']}?latitude=${position.latitude}&longitude=${position.longitude}';
    var response;
    print('SearchBus');
    try {
      response = await api().apiGet(url, jwt);
    } catch (e) {
      print(e);
    }
    var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      state.updateNearbyStationBus(responseBody);
      // setState(() {
      //   nearbyStation_list = responseBody;
      // });
    }
  }


  // // 取得大眾運輸資訊
  // getPublicTransportation() async {
  //   // EasyLoading.show(status: '查詢中...');
  //   var response;
  //   var url;
  //   var jwt = ',${state.accountState}';
  //   switch(_tabController.index){
  //
  //   // 腳踏車
  //     case 0:
  //       nearbyStation_list.forEach((element) async {
  //         // 使用者附近有腳踏車站點
  //         if (element["公共自行車"] != null) {
  //           // 將"公共自行車資料"加進要顯示的陣列中
  //           stationView_list.add(element);
  //           url = dotenv.env['PublicBicycle'];
  //           // 1012：area=XXX還未修改成讀取使用者目前所在縣市
  //           url +=
  //           '?area=Kaohsiung&StationUID=${element['公共自行車']['StationUID']}';
  //
  //           try {
  //             response = await api().apiGet(url, jwt);
  //             // 將搜尋到的腳踏車站點資訊回傳至頁面
  //             var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
  //             if (response.statusCode == 200) {
  //               stationViewResult_list.add(responseBody);
  //             }
  //           } catch (e) {
  //             print(e);
  //           }
  //           setState(() {
  //             stationViewResult_list;
  //           });
  //         }
  //         // 使用者附近無腳踏車站點
  //         else {
  //           // stationViewResult_list.add('');
  //         };
  //       }
  //       );
  //
  //       break;
  //
  //   // // 公車
  //   // case 1:
  //   //   url = dotenv.env['TouristHotel'];
  //   //   break;
  //   //
  //   // // 捷運
  //   // case 2:
  //   //   url = dotenv.env['TouristFood'];
  //   //   break;
  //   //
  //   // // 台鐵
  //   // case 3:
  //   //   url = dotenv.env['TouristActivity'];
  //   //   break;
  //   //
  //   // // 高鐵
  //   // case 4:
  //   //   url = dotenv.env['TouristActivity'];
  //   //   break;
  //   // default:
  //   //   print(_tabController.index);
  //   //   break;
  //   }
  // }


  //AppBar
  // PreferredSizeWidget appBar(){
  //   return AppBar(
  //     backgroundColor: const Color.fromRGBO(113, 170, 221, 1),
  //     toolbarHeight: 0,
  //     bottom: TabBar(
  //       // labelColor: //被選種顏色,
  //       // unselectedLabelColor: //未被選種顏色,
  //       controller: _tabController,
  //       tabs: publicTransportationBar,
  //     ),
  //
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(113, 170, 221, 1),
          toolbarHeight: 0,
          bottom: TabBar(
            // labelColor: //被選種顏色,
            // unselectedLabelColor: //未被選種顏色,
            // controller: _tabController,
            tabs: [
                Tab(text: '腳踏車'),
                Tab(text: '公車'),
                Tab(text: '捷運'),
                Tab(text: '台鐵'),
                Tab(text: '高鐵'),
            ],
          ),

        ),
        body: TabBarView(
          //禁止左右滑動
          physics: NeverScrollableScrollPhysics(),
          children: [
            publicTransportInfoBike(),
            publicTransportInfoBus(context),
            publicTransportInfoMRT(context),
            publicTransportInfoTrain(context),
            publicTransportInfoHighway(context),
          ],
        )
      ),
    )
    );
  }


}