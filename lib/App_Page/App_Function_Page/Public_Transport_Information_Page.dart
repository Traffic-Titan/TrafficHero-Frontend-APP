// ignore_for_file: file_names, camel_case_types, unnecessary_import

import 'package:traffic_hero/App_Page/App_Function_Page/Public_Transport_Information_Page/Public_Transport_Information_THSRdart';
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
    position = await geolocator().updataPosition(context);
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
    var position = await geolocator().updataPosition(context);
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


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(62, 111, 179, 1),
          elevation: 0,
          toolbarHeight: 0,
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            indicator: UnderlineTabIndicator( // 被選中底線顏色
                borderSide: BorderSide(color: Colors.white)
            ),
            overlayColor: MaterialStateProperty.all(Color.fromRGBO(113, 170, 221, 1)),
            tabs: [
                Tab(icon: Icon(Icons.directions_bike_outlined),text: '自行車'),
                Tab(icon: Icon(Icons.directions_bus),text: '公車',),
                Tab(icon: Icon(Icons.directions_train_outlined),text: '捷運',),
                Tab(icon: Icon(Icons.train),text: '台鐵',),
                Tab(icon: Icon(Icons.directions_railway_sharp),text: '高鐵',),
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
            Public_Transport_Information_Train(),
            Public_Transport_Information_Highway(),
          ],
        )
      ),
    )
    );
  }


}