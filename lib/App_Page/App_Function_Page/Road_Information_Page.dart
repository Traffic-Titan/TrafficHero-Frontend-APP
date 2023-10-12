// ignore_for_file: camel_case_types, library_private_types_in_public_api, file_names, unused_import, override_on_non_overriding_member, prefer_typing_uninitialized_variables, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:traffic_hero/imports.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart'; // Make sure to import the correct package

class Road_Information extends StatefulWidget {
  const Road_Information({Key? key}) : super(key: key);

  @override
  _Road_InformationState createState() => _Road_InformationState();
}

class _Road_InformationState extends State<Road_Information> with TickerProviderStateMixin{
  late TabController _tabController;
  late stateManager state;
  var nearbyStation_list = [];
  var stationView_list = [];
  var stationViewResult_list = [];
  var screenWidth;
  var screenHeight;
  var positionNow;
  var position;

  static const List<Tab> publicTransportationBar = <Tab>[
    Tab(text: '腳踏車'),
    Tab(text: '公車'),
    Tab(text: '捷運'),
    Tab(text: '台鐵'),
    Tab(text: '高鐵'),
  ];

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
    positionNow = state.positionNow;
    screenWidth = MediaQuery. of(context). size. width ;
    screenHeight = MediaQuery. of(context). size. height;
    position = await geolocator().updataPosition();
    // 取得附近站點有哪些
    getNearbyStation();



  }
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: publicTransportationBar.length);
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  //取得附近站點有哪些
  getNearbyStation() async{
    var response;
    var jwt = ',${state.accountState}';
    // 先讀取附近站點有哪些腳踏車資訊
    var nearbyStationURL = dotenv.env['StationNearby']! + '?latitude=${position.latitude}&longitude=${position.longitude}';
    try {
      response = await api().apiGet(nearbyStationURL, jwt);
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        // 將API讀取到的所有附近站點加入陣列
        nearbyStation_list = responseBody;
        // 取得大眾運輸資訊
        getPublicTransportation();
      } else {
        print(jsonDecode(utf8.decode(response.bodyBytes)).toString());
      }
    } catch (e) {
      print(e);
    }
  }

  // 取得大眾運輸資訊
  getPublicTransportation() async {
    // EasyLoading.show(status: '查詢中...');
    var response;
    var url;
    var jwt = ',${state.accountState}';
    switch(_tabController.index){

      // 腳踏車
      case 0:
        nearbyStation_list.forEach((element) async {
          // 使用者附近有腳踏車站點
          if (element["公共自行車"] != null) {
            // 將"公共自行車資料"加進要顯示的陣列中
            stationView_list.add(element);
            url = dotenv.env['PublicBicycle'];
            // 1012：area=XXX還未修改成讀取使用者目前所在縣市
            url +=
            '?area=Kaohsiung&StationUID=${element['公共自行車']['StationUID']}';

            try {
              response = await api().apiGet(url, jwt);
              // 將搜尋到的腳踏車站點資訊回傳至頁面
              var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
              if (response.statusCode == 200) {
                stationViewResult_list.add(responseBody);
              }
            } catch (e) {
              print(e);
            }
            setState(() {
              stationViewResult_list;
            });
          }
          // 使用者附近無腳踏車站點
          else {
            // stationViewResult_list.add('');
          };
        }
        );

        break;

      // // 公車
      // case 1:
      //   url = dotenv.env['TouristHotel'];
      //   break;
      //
      // // 捷運
      // case 2:
      //   url = dotenv.env['TouristFood'];
      //   break;
      //
      // // 台鐵
      // case 3:
      //   url = dotenv.env['TouristActivity'];
      //   break;
      //
      // // 高鐵
      // case 4:
      //   url = dotenv.env['TouristActivity'];
      //   break;
      // default:
      //   print(_tabController.index);
      //   break;
    }
  }
    @override
  Widget build(BuildContext context) {
    return MaterialApp(home: DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: appBar(),
        body: Stack(
          children: [
            DraggableScrollableSheet(
              builder: (BuildContext context, ScrollController scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(222, 235, 247, 1),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height:10),
                      SizedBox(
                        width:30,
                        height: 5,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50)),
                        ),
                      ),
                      SizedBox(height:14),
                      Expanded(
                        child: nearbyTransportationView(scrollController,_tabController.index),
                      ),
                    ],
                  ),

                );
              },
              initialChildSize: 0.3, // 初始高度比例
              minChildSize: 0.1, // 最小高度比例
              maxChildSize: 1, // 最大高度比例
            ),
          ],
        ),
      ),
    )
    );
  }

  //附近站點圖片
  Widget nearbyTransportationView(ScrollController scrollController,int transportationType){
    return SizedBox(
      width:  screenWidth * 0.9,
      // height: 200,
      child:GridView(
        controller: scrollController,
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, //横轴三个子widget
            childAspectRatio: 3/1),
        children: List.generate(
          stationViewResult_list.length,
              (index) {
            final list = stationViewResult_list[index];
            return InkWell(
              child:Row(
                  crossAxisAlignment: CrossAxisAlignment.start, //水平對齊方式
                  children: <Widget>[
                    Flexible(
                      child: Column(
                          children:[
                            Padding(
                              padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                              child: Column( //用Column讓兩排文字可以垂直排列
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  // 腳踏車模式版型
                                  // if(transportationType == 0)
                                    Text(list['station']['StationName']['Zh_tw'].toString(),overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 20,color: Color.fromRGBO(24, 60, 126, 1)),),
                                    Text(list['station']['StationAddress']['Zh_tw'].toString(),overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 13,color: Color.fromRGBO(24, 60, 126, 1)),),
                                    Text('可停車位'+list['station']['BikesCapacity'].toString(),overflow: TextOverflow.ellipsis,maxLines: 2,style: TextStyle(fontSize: 10,color: Color.fromRGBO(24, 60, 126, 1)),),
                                    Text('可借車位'+list['status']['AvailableRentBikesDetail']['GeneralBikes'].toString(),overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 10,color: Color.fromRGBO(24, 60, 126, 1)),)
                                  ,

                                ],
                              ),
                            ),
                          ]
                      ),
                    ),
                  ]
              ),
            );

          },
        ),
      ),
    );

    //   },
    // );
  }

  //AppBar
  PreferredSizeWidget appBar(){
    return AppBar(
      backgroundColor: const Color.fromRGBO(113, 170, 221, 1),
      bottom: TabBar(
        // labelColor: //被選種顏色,
        // unselectedLabelColor: //未被選種顏色,
        controller: _tabController,
        enableFeedback: true,
        onTap: (index) {

        },
        tabs: publicTransportationBar,
      ),
    );
  }
}


