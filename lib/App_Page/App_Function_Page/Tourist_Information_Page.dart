// ignore_for_file: file_names, camel_case_types, deprecated_member_use, prefer_typing_uninitialized_variables, prefer_collection_literals, use_build_context_synchronously, avoid_print, unnecessary_brace_in_string_interps, unrelated_type_equality_checks, non_constant_identifier_names, unused_import
// ignore: unnecessary_import
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:traffic_hero/App_Page/App_Function_Page/Tourist_Information_Page_SearchPage.dart';
import 'package:traffic_hero/imports.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

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
  late LatLng currentCenter;
  late GoogleMapController mapController;
  late TextEditingController endPlaceText = TextEditingController();
  late var tourismList = [];
  var screenWidth;
  var screenHeight;
  var scrollview = 'list';
  var second = 1;
  var list;
  var Searchlist;
  var id;
  var searchResult_list;
  var resultDetail_list;
  var position;
  final Set<Marker> _markers = Set<Marker>();
  String searchText = '';
  Timer? timer;
  List<dynamic> seachList = [];
  static const List<Tab> touristTabBar = <Tab>[
    Tab(text: '景點'),
    Tab(text: '住宿'),
    Tab(text: '美食'),
    Tab(text: '活動'),
  ];

//初始化
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    screenWidth = MediaQuery.of(context).size.width;
    state = Provider.of<stateManager>(context, listen: false);
    prefs = await SharedPreferences.getInstance();
    searchResult('1');
    screenHeight = MediaQuery.of(context).size.height;
    state.changePositionNow(await geolocator().updataPosition(context));
    position = state.positionNow;
    getTourismInfo();
  }

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


//可控制座標
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
    timer = Timer.periodic(const Duration(seconds: 1), (_) async {
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

          second = 1;
        }
      }
    });
  }

  void stoptimer() {
    timer?.cancel();
  }

//輸出符合後端的模式規格
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
                scrollview = 'Listitem';
                id = list['id'];
              });
            }),
      );
    }
  }

  void addMarkersSeach(des) {
    _markers.clear();
    // 目前位置標記
    _markers.add(Marker(
      markerId: const MarkerId('目前位置'),
      position: LatLng(position.latitude, position.longitude),
      icon: BitmapDescriptor.defaultMarkerWithHue(223),
      infoWindow: const InfoWindow(title: '目前位置'),
    ));
    // 添加標記
    _markers.add(
      Marker(
          markerId: MarkerId(des['name']),
          position:
              LatLng(des['position']['latitude'], des['position']['longitude']),
          infoWindow: InfoWindow(
            title: des['name'],
            snippet: des['address'],
          ),
          onTap: () {}),
    );
  }

  Future<List<dynamic>> searchResult(String inputText) async {
    List<dynamic> seachList = [];

    setState(() {
      seachList = [];
    });

    var url = '${dotenv.env['SearchKeyWord']}?Keyword=$inputText';
    var jwt = ',${state.accountState}';
    var response = await api().apiGet(url, jwt);

    if (response.statusCode == 200) {
      setState(() {
        // searchResult_list : 儲存搜尋結果陣列

        searchResult_list = jsonDecode(utf8.decode(response.bodyBytes));
        print(searchResult_list);
        var hotel = searchResult_list['name']['hotel'];
        var scenic_spot1 = searchResult_list['name']['scenic_spot'];
        var restaurant = searchResult_list['name']['restaurant'];

        for (var i = 0; i < hotel.length; i++) {
          seachList.add(hotel[i]);
        }
        for (var i = 0; i < scenic_spot1.length; i++) {
          seachList.add(scenic_spot1[i]);
        }

        for (var i = 0; i < restaurant.length; i++) {
          seachList.add(restaurant[i]);
        }
      });
    } else {
      print(jsonDecode(utf8.decode(response.bodyBytes)));
    }

    return seachList;
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
    if (scrollview == 'list') {
      return nearbyPopularView(scrollController);
    } else if (scrollview == 'Listitem') {
      return onenearbyPopularView(scrollController);
    } else if (scrollview == 'search') {
      return oneNearbySearchView(scrollController);
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
                            const SizedBox(height: 10),
                            SizedBox(
                              width: 30,
                              height: 5,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                            ),
                            const SizedBox(height: 14),
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
        leading: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const Tourist_Information_Page_SearchPage()));
            },
            child: const Icon(
              Icons.search,
              color: Colors.white,
              size: 28,
            )),
        title: TypeAheadField(
          errorBuilder: (context, error) => const Text('暫無推薦'),
          textFieldConfiguration: TextFieldConfiguration(
            autofocus: false,
            style: DefaultTextStyle.of(context)
                .style
                .copyWith(fontStyle: FontStyle.italic, color: Colors.white),
            controller: endPlaceText,
            onChanged: (value) {
              // 获取用户输入的内容

              searchResult(value);
            },
          ),
          suggestionsCallback: (pattern) async {
            // 假設 searchResult 是一個異步方法，返回搜尋結果的列表

            return await searchResult(pattern);
          },
          itemBuilder: (context, suggestion) {
            // 在這裡判斷該建議項目是否已搜尋到，並做出相應的顯示
            bool isSearched = seachList.contains(suggestion);

            return ListTile(
              title: Text(
                suggestion['name'].toString(),
                style: TextStyle(
                  fontWeight: isSearched ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            );
          },
          onSuggestionSelected: (seachList) {
            endPlaceText.text = seachList['name'].toString();
            setState(() {
              scrollview = 'search';
              Searchlist = seachList;
              addMarkersSeach(seachList);
              id = seachList['id'];
              print(Searchlist);
            });
            // getLocation(suggestion);
          },
        ),
      ),
      bottom: TabBar(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white, //被選種顏色,
        // unselectedLabelColor: //未被選種顏色,
        controller: _tabController,
        enableFeedback: true,
        onTap: (index) {
          setState(() {
            scrollview = 'list';
            getTourismInfo();
          });
        },
        tabs: touristTabBar,
      ),
    );
  }

  //google map
  _onMapCreated(GoogleMapController controller) {
    mapController = controller;
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
        if (scrollview == 'list') {
          stoptimer();
          currentCenter = position.target;
          startTimer(currentCenter.latitude, currentCenter.longitude);
          print("地圖中心座標：${currentCenter.latitude}, ${currentCenter.longitude}");
        }
      },
      markers: _markers,
    );
  }

  Widget onenearbyPopularView(ScrollController scrollController) {
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
                    scrollview = 'list';
                  });
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                ),
              ),
              title: Text(
                list != null ? list['name'] : '',
                style: const TextStyle(fontSize: 20),
              ),
              subtitle:
                  Text(list != null ? list['address'].toString() : '無地址顯示'),
            ),
            SizedBox(
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
                    margin: const EdgeInsets.all(8), // 可以调整间距
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
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 30,
              width: screenWidth,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                        height: 30,
                      ),
                      Visibility(
                        visible: list['map_url'] == '' ? false : true,
                        child: InkWell(
                          onTap: () {
                            launch(list['map_url']);
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            child: const SizedBox(
                              width: 100,
                              height: 100,
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
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const ListTile(
              title: Text(
                '詳細介紹',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(
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
            const ListTile(
              title: Text(
                '天氣資訊',
                style: TextStyle(fontSize: 20),
              ),
            ),
            ListTile(
              leading: Image.network(list['weather']['weather_icon_url']),
              title: Text(
                '目前溫度：${list['weather']['temperature']}',
                style: const TextStyle(fontSize: 20),
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
            const SizedBox(
              height: 3,
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget oneNearbySearchView(ScrollController scrollController) {
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
                    scrollview = 'list';
                  });
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                ),
              ),
              title: Text(
                Searchlist != null ? Searchlist['name'] : '',
                style: const TextStyle(fontSize: 20),
              ),
              subtitle: Text(Searchlist != null
                  ? Searchlist['address'].toString()
                  : '無地址顯示'),
            ),
            SizedBox(
              height: 250,
              width: screenWidth,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount:
                    Searchlist == null ? 0 : Searchlist['picture'].length,
                itemBuilder: (context, index) {
                  var list2 = Searchlist['picture'][index];
                  return Container(
                    width: 280,
                    height: 60,
                    margin: const EdgeInsets.all(8), // 可以调整间距
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14.0),
                      child: Image.network(
                        list2.toString(),
                        width: Searchlist['picture']?.length == 0
                            ? screenWidth
                            : 280,
                        height: 60,
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            const ListTile(
              title: Text(
                '詳細介紹',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(
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
                    child: Text(
                        Searchlist['description_detail'].toString() == 'null'
                            ? Searchlist['description']
                            : Searchlist['description_detail']),
                  )),
            ),
            const ListTile(
              title: Text(
                '天氣資訊',
                style: TextStyle(fontSize: 20),
              ),
            ),
            ListTile(
              leading: Image.network(Searchlist['weather']['weather_icon_url']),
              title: Text(
                '目前溫度：${Searchlist['weather']['temperature']}',
                style: const TextStyle(fontSize: 20),
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      '今天最低溫：${Searchlist['weather']['the_lowest_temperature']}'),
                  Text(
                      '今天最高溫：${Searchlist['weather']['the_highest_temperature']}')
                ],
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            const SizedBox(
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
                          const SizedBox(
                            width: 10,
                          ),
                          AspectRatio(
                            //設定圖片的長寬比
                            aspectRatio: 3 / 2,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
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
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    16.0, 12.0, 16.0, 8.0),
                                child: Column(
                                  //用Column讓兩排文字可以垂直排列
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      list['name'].toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color:
                                              Color.fromRGBO(24, 60, 126, 1)),
                                    ),
                                    Text(
                                      list['address'] == ''
                                          ? '無地址顯示'
                                          : list['address'],
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 13,
                                          color:
                                              Color.fromRGBO(24, 60, 126, 1)),
                                    ),
                                    Text(
                                      list['phone'].toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
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
                        scrollview = 'Listitem';
                        id = list['id'];
                        addMarkersSeach(list);
                      });
                    },
                  ),
                ),
                const SizedBox(
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
