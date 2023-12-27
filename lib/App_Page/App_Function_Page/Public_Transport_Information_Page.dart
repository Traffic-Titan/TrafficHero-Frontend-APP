// ignore_for_file: file_names, camel_case_types, unnecessary_import, non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print

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


  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
    positionNow = state.positionNow;
    screenWidth = MediaQuery. of(context). size. width ;
    screenHeight = MediaQuery. of(context). size. height;
    position = await geolocator().updataPosition(context);

  }


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
          backgroundColor: const Color.fromRGBO(62, 111, 179, 1),
          elevation: 0,
          toolbarHeight: 0,
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            indicator: const UnderlineTabIndicator( // 被選中底線顏色
                borderSide: BorderSide(color: Colors.white)
            ),
            overlayColor: MaterialStateProperty.all(const Color.fromRGBO(113, 170, 221, 1)),
            tabs: const [
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
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const publicTransportInfoBike(),
            publicTransportInfoBus(context),
            publicTransportInfoMRT(context),
            const Public_Transport_Information_Train(),
            const Public_Transport_Information_Highway(),
          ],
        )
      ),
    )
    );
  }


}