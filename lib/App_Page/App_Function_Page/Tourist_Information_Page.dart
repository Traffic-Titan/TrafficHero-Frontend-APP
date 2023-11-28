// ignore_for_file: file_names, camel_case_types
// ignore: unnecessary_import
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:traffic_hero/App_Page/App_Function_Page/Tourist_Information_Page_SearchPage.dart';
import 'package:traffic_hero/imports.dart';

// ignore: unused_import
import 'Tourist_Detail_Info.dart';

class Tourist_Information extends StatefulWidget {
  const Tourist_Information({super.key});

  @override
  State<Tourist_Information> createState() => _Tourist_InformationState();
}

class _Tourist_InformationState extends State<Tourist_Information>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late stateManager state;
  late SharedPreferences prefs;
  var screenWidth;
  var screenHeight;
  var scrollview = true;
  String searchText = '';
  late LatLng currentCenter;
  late var tourismList = [];
  late GoogleMapController mapController;
  final Set<Marker> _markers = Set<Marker>();
  var position;
  Timer? timer;
  var second = 1;
  var id;

  _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    screenWidth = MediaQuery.of(context).size.width;
    state = Provider.of<stateManager>(context, listen: false);
    prefs = await SharedPreferences.getInstance();

    screenHeight = MediaQuery.of(context).size.height;
    state.changePositionNow(await geolocator().updataPosition(context));
    position = state.positionNow;
    getTourismInfo();
  }

  static const List<Tab> touristTabBar = <Tab>[
    Tab(text: '景點'),
    Tab(text: '住宿'),
    Tab(text: '美食'),
    Tab(text: '活動'),
  ];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: touristTabBar.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  getTourismInfo2(latitude, longitude) async {
    var response;
    var url;
    var jwt = ',${state.accountState}';
    switch (_tabController.index) {
      case 0:
        url = dotenv.env['TouristSpot'];
        break;
      case 1:
        url = dotenv.env['TouristHotel'];
        break;
      case 2:
        url = dotenv.env['TouristFood'];
        break;
      case 3:
        url = dotenv.env['TouristActivity'];
        break;
      default:
        print(_tabController.index);
        break;
    }
    url +=
        '?latitude=${latitude}&longitude=${longitude}&mode=${changeMode(state.modeName)}&os=${prefs.get('system')}';
    try {
      response = await api().apiGet(url, jwt);
    } catch (e) {
      print(e);
    }
    var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      setState(() {
        tourismList = responseBody;
      });
      addMarkers();
    } else {
      EasyLoading.dismiss();
      print(jsonDecode(utf8.decode(response.bodyBytes)).toString());
    }
  }

//延遲向後端取得觀光資訊
  startTimer(latitude, longitude) {
    timer = Timer.periodic(Duration(seconds: 1), (_) async {
      try {
        setState(() {
          print(second);
          second--;
        });
        if (second == 0) {
          stoptimer();
          await getTourismInfo2(latitude, longitude);
          setState(() {
            second = 1;
          });
        }
      } catch (e) {
        try {
          setState(() {
            second = 1;
          });
          stoptimer();
          await getTourismInfo2(latitude, longitude);
        } catch (e) {
          stoptimer();
          setState(() {
            second = 1;
          });
        }
      }
    });
  }

  void stoptimer() {
    timer?.cancel();
  }

  changeMode(mode) {
    if (mode == 'car') {
      return 'Car';
    } else if (mode == 'scooter') {
      return 'Scooter';
    } else {
      return 'Transit';
    }
  }

  //取得觀光資料(轉到該頁面戳一次)
  getTourismInfo() async {
    var response;
    var url;
    var jwt = ',${state.accountState}';
    switch (_tabController.index) {
      case 0:
        url = dotenv.env['TouristSpot'];
        break;
      case 1:
        url = dotenv.env['TouristHotel'];
        break;
      case 2:
        url = dotenv.env['TouristFood'];
        break;
      case 3:
        url = dotenv.env['TouristActivity'];
        break;
      default:
        print(_tabController.index);
        break;
    }

    try {
      url +=
          '?latitude=${position.latitude}&longitude=${position.longitude}&mode=${changeMode(state.modeName)}&os=${prefs.get('system')}';
      response = await api().apiGet(url, jwt);
    } catch (e) {
      print(e);
    }
    var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      try {
        setState(() {
          tourismList = responseBody;
        });
      } catch (e) {
        print(e);
      }

      addMarkers();
    } else {
      EasyLoading.dismiss();
      print(jsonDecode(utf8.decode(response.bodyBytes)).toString());
    }
  }

  //新增標記
  void addMarkers() {
    _markers.clear();
    // 目前位置標記
    _markers.add(Marker(
      markerId: MarkerId('目前位置'),
      position: LatLng(position.latitude, position.longitude),
      icon: BitmapDescriptor.defaultMarkerWithHue(223),
      infoWindow: InfoWindow(title: '目前位置'),
    ));
    // 添加標記
    for (int i = 0; i < tourismList.length; i++) {
      var list = tourismList[i];

      _markers.add(
        Marker(
            markerId: MarkerId(list['name']),
            position: LatLng(
                list['position']['latitude'], list['position']['longitude']),
            infoWindow: InfoWindow(
              title: list['name'],
              snippet: list['address'],
            ),
            onTap: () {
              setState(() {
                scrollview = false;
                id = list['id'];
              });
            }),
      );
    }
  }

  findid(id) {
    for (var i = 0; i < tourismList.length; i++) {
      if (tourismList[i]['id'] == id) {
        print(tourismList[i]['id']);
        print(id);
        return tourismList[i];
      }
    }
  }

  scrollView(scrollController) {
    if (scrollview == true) {
      return nearbyPopularView(scrollController);
    } else {
      return onenearbyPopularView(scrollController);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: appBar(),
            body: Stack(
              children: [
                // Map
                mapView(),

                Align(
                  alignment: Alignment.bottomLeft,
                  child: DraggableScrollableSheet(
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      return Container(
                        width: screenWidth > 600
                            ? screenWidth / 4 + 100
                            : screenWidth,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(222, 235, 247, 1),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            SizedBox(
                              width: 30,
                              height: 5,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                            ),
                            SizedBox(height: 14),
                            Expanded(
                              child: scrollView(scrollController),
                            ),
                          ],
                        ),
                      );
                    },
                    expand: false,

                    initialChildSize: 0.3, // 初始高度比例
                    minChildSize: 0.2, // 最小高度比例
                    maxChildSize: 1, // 最大高度比例
                  ),
                )
              ],
            ),
          ),
        ));
  }

  //AppBar
  PreferredSizeWidget appBar() {
    return AppBar(
      backgroundColor: const Color.fromRGBO(62, 111, 179, 1),
      leading: const Icon(
        Icons.checklist_rtl_sharp,
        color: Colors.white,
        size: 28,
      ),
      title: ListTile(
        // leading: InkWell(
        //     onTap: () async {
        //       LatLngBounds bounds = await mapController.getVisibleRegion();

        //       // 計算中心座標
        //       double centerLatitude =
        //           (bounds.northeast.latitude + bounds.southwest.latitude) / 2;
        //       double centerLongitude =
        //           (bounds.northeast.longitude + bounds.southwest.longitude) / 2;

        //       // 將中心座標輸出到控制台
        //       print("地圖中心座標：$centerLatitude, $centerLongitude");
        //     },
        //     child: Icon(
        //       Icons.search,
        //       color: Colors.white,
        //       size: 28,
        //     )),
        // title: TextField(
        //   decoration: InputDecoration(
        //     hintText: '以名稱搜尋',
        //     hintStyle: TextStyle(
        //       color: Colors.white,
        //       fontSize: 18,
        //       fontStyle: FontStyle.italic,
        //     ),
        //     border: InputBorder.none,
        //   ),
        //   onTap: () {
        //     // 只要點擊搜尋欄就跳轉到另外一個空白頁面
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => Tourist_Information_Page_SearchPage()));
        //   },
        //   style: TextStyle(
        //     color: Colors.white,
        //   ),
        // ),
      ),
      bottom: TabBar(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white, //被選種顏色,
        // unselectedLabelColor: //未被選種顏色,
        controller: _tabController,
        enableFeedback: true,
        onTap: (index) {
          setState(() {
            scrollview = true;
            getTourismInfo();
          });
        },
        tabs: touristTabBar,
      ),
    );
  }

  //Google Map View
  Widget mapView() {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        // target: LatLng(23.692502, 120.532229),
        target: LatLng(state.positionNow.latitude, state.positionNow.longitude),
        zoom: 11.0,
      ),
      onCameraMove: (CameraPosition position) async {
        // 監測中心座標的變化並自動輸出
        stoptimer();
        currentCenter = position.target;
        startTimer(currentCenter.latitude, currentCenter.longitude);
        print("地圖中心座標：${currentCenter.latitude}, ${currentCenter.longitude}");
      },
      markers: _markers,
    );
  }

  Widget onenearbyPopularView(ScrollController scrollController) {
    var list;
    if (findid(id) != []) {
      list = findid(id);
    } else {}

    print(list);
    return SizedBox(
      width: screenWidth * 0.9,
      // height: 200,
      child: SingleChildScrollView(
        controller: scrollController,
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            ListTile(
              leading: IconButton(
                  onPressed: () {
                    setState(() {
                      scrollview = true;
                    });
                  },
                  icon: Icon(Icons.arrow_back_ios,),
                  ),
              title: Text(
                list != null ? list['name'] : '',
                style: TextStyle(fontSize: 20),
              ),
              subtitle:
                  Text(list != null ? list['address'].toString() : '無地址顯示'),
            ),

            Container(
              height: 250,
              width: screenWidth,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: list == null ? 0 : list['picture'].length,
                itemBuilder: (context, index) {
                  var list2 = list['picture'][index];
                  return Container(
                    width: 280,
                    height: 60,
                    margin: EdgeInsets.all(8), // 可以调整间距
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14.0),
                      child: Image.network(
                        list2.toString(),
                        width: list['picture']?.length == 0 ? screenWidth : 280,
                        height: 60,
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 30,
              width: screenWidth,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  Row(
                    children: [
                      Visibility(
                        visible: list['website_url'] == '' ? false : true,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WebView(
                                        tt: list['website_url'].toString())));
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            child: SizedBox(
                              width: 100,
                              height: 95,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('網站'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Visibility(
                        visible: list['google_maps_url'] == '' ? false : true,
                        child: InkWell(
                          onTap: () {
                            launch(list['google_maps_url']);
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            child: SizedBox(
                              width: 100,
                              height: 95,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('導航'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      //         Visibility(
                      //           visible: list['website_url'] == '' ? false : true,
                      //           child: InkWell(
                      //             onTap: () {
                      //               Navigator.push(
                      //                   context,
                      //                   MaterialPageRoute(
                      //                       builder: (context) => WebView(
                      //                           tt: list['website_url'].toString())));
                      //             },
                      //             child: Card(
                      //               shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(14.0),
                      // ),
                      //               child: Text('網站'),),
                      //           ),
                      //         ),
                      SizedBox(
                        width: 10,
                      ),
                      // InkWell(
                      //   child: Text('data'),
                      // )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              title: Text(
                '詳細介紹',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: SizedBox(
                  width:
                      screenWidth > 600 ? screenWidth / 4 + 100 : screenWidth,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(list['description_detail'].toString() == 'null'
                        ? list['description']
                        : list['description_detail']),
                  )),
            ),
            ListTile(
              title: Text(
                '天氣資訊',
                style: TextStyle(fontSize: 20),
              ),
            ),
            ListTile(
              leading: Image.network(list['weather']['weather_icon_url']),
              title: Text(
                '目前溫度：${list['weather']['temperature']}',
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('今天最低溫：${list['weather']['the_lowest_temperature']}'),
                  Text('今天最高溫：${list['weather']['the_highest_temperature']}')
                ],
              ),
            ),
            SizedBox(
              height: 3,
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  //附近景點
  Widget nearbyPopularView(ScrollController scrollController) {
    return SizedBox(
      width: screenWidth * 0.9,
      // height: 200,
      child: GridView(
        controller: scrollController,
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, //横轴三个子widget
            childAspectRatio: 3 / 1),
        children: List.generate(
          tourismList.length,
          (index) {
            final list = tourismList[index];
            return Column(
              children: [
                Expanded(
                  child: InkWell(
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start, //水平對齊方式
                        children: <Widget>[
                          SizedBox(
                            width: 10,
                          ),
                          AspectRatio(
                            //設定圖片的長寬比
                            aspectRatio: 3 / 2,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(14.0),
                                  topRight: Radius.circular(14.0),
                                  bottomLeft: Radius.circular(14.0),
                                  bottomRight: Radius.circular(14.0)),
                              child: Image.network(
                                list['picture'][0],
                                height: screenHeight * 0.01,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Column(children: [
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                                child: Column(
                                  //用Column讓兩排文字可以垂直排列
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      list['name'].toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color:
                                              Color.fromRGBO(24, 60, 126, 1)),
                                    ),
                                    Text(
                                      list['address'] == ''
                                          ? '無地址顯示'
                                          : list['address'],
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 13,
                                          color:
                                              Color.fromRGBO(24, 60, 126, 1)),
                                    ),
                                    Text(
                                      list['phone'].toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 10,
                                          color:
                                              Color.fromRGBO(24, 60, 126, 1)),
                                    ),
                                    // Text(
                                    //   '與景點距離${list['phone']} 公里',
                                    //   overflow: TextOverflow.ellipsis,
                                    //   style: TextStyle(
                                    //       fontSize: 10,
                                    //       color:
                                    //           Color.fromRGBO(24, 60, 126, 1)),
                                    // ),
                                  ],
                                ),
                              ),
                            ]),
                          ),
                        ]),
                    onTap: () async {
                      state.updatePageDetail(list);
                      setState(() {
                        scrollview = false;
                        id = list['id'];
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            );
          },
        ),
      ),
    );

    //   },
    // );
  }
}
