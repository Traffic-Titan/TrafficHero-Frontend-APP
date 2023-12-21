// ignore_for_file: camel_case_types, library_private_types_in_public_api, file_names, unused_import, override_on_non_overriding_member, prefer_typing_uninitialized_variables, prefer_final_fields, library_prefixes, use_super_parameters, unnecessary_new, prefer_collection_literals, non_constant_identifier_names, avoid_print, unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings
import 'package:flutter_waya/components/check_box.dart';
import 'package:flutter_waya/extension/object_extension.dart';
import 'package:flutter_waya/flutter_waya.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:traffic_hero/App_Page/App_Function_Page/Road_Information/Road_Information_ParkingLot.dart';
import 'package:traffic_hero/imports.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart'; // Make sure to import the correct package
import 'package:traffic_hero/Components/Tool.dart' as Tool;
import 'package:flutter_typeahead/flutter_typeahead.dart';

class Road_Information extends StatefulWidget {
  const Road_Information({Key? key}) : super(key: key);

  @override
  _Road_InformationState createState() => _Road_InformationState();
}

//欲篩選的路況
List<String> _filterRoadInfoItems = [];
//道路資訊 可篩選之路況list
List<Map<String, dynamic>> roadInfoFilterList = [
  {'title': '全選', 'value': 'all', 'isChecked': false},
  {'title': '交通管制', 'value': '交通管制', 'isChecked': false},
  {'title': '交通事故', 'value': '事故', 'isChecked': false},
  {'title': '道路施工', 'value': '道路施工', 'isChecked': false},
  {'title': '道路壅塞', 'value': '阻塞', 'isChecked': false},
  {'title': '交通障礙', 'value': '交通障礙', 'isChecked': false},
  {'title': '其他', 'value': '其他', 'isChecked': false},
  // Add more items as needed
];

bool test = false;

class _Road_InformationState extends State<Road_Information> {
  late stateManager state;
  var position;
  var screenWidth;
  var screenHeight;
  var positionNow;
  var parkingInfoList;
  var trafficControlList;
  var roadAccidentList;
  var roadConstructionList;
  var trafficJamList;
  bool sclectShow = false;
  List<dynamic> roadInformationList = [];
  List<Map<String, dynamic>> destinationList = [];
  List<String> suggestions = [];
  var input;
  late TextEditingController endPlaceText = new TextEditingController();
  late GoogleMapController _mapController;
  final Set<Marker> _markers = Set<Marker>();
  late BitmapDescriptor ParkingInfoImg,
      TrafficControlImg,
      RoadAccidentImg,
      RoadConstructionImg,
      TrafficJamImg;
  bool checkedBox = false;
  var _showRoadInfoDetail;
  List<Map<String, dynamic>> roadInfoDetail = [
    {
      "happendate": "日期",
      "roadtype": "類型",
      "happentime": "00:00:00.000",
      "areaNm": "位置",
      "Latitude": "經度",
      "Longitude": "緯度",
      "comment": "事件內容",
      "region": "區域",
      "direction": "方向"
    }
  ];

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
    positionNow = state.positionNow;
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    getPBS('all');
    getPBS('交通障礙');
    // position = await geolocator().updataPosition(context);
  }

  @override
  void initState() {
    super.initState();
    // 初始化 customIcon
    _initCustomImg();
  }

  @override
  void dispose() {
    super.dispose();
  }

// 初始化 customIcon
  Future<void> _initCustomImg() async {
    ParkingInfoImg = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(
        size: Size(10, 10),
      ),
      'assets/roadInfo/parkingInfoImg.png',
    );
    TrafficControlImg = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(10, 10)),
      'assets/roadInfo/trafficControlImg.png',
    );
    RoadAccidentImg = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(10, 10)),
      'assets/roadInfo/roadAccidentImg.png',
    );
    RoadConstructionImg = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(10, 10)),
      'assets/roadInfo/roadConstructionImg.png',
    );
    TrafficJamImg = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(10, 10)),
      'assets/roadInfo/trafficjamImg.png',
    );
    // 一旦 customIcon 初始化完成，触发重建以使用它
    setState(() {});
  }



  Future<void> getPBS(type) async {
        var position = await geolocator().updataPosition(context);
    print('開始抓取PBS');
    var response;
    var jwt = ',' + state.accountState;
    var url = dotenv.env['PBS'].toString() +
        '?latitude=${position.latitude}&longitude=${position.longitude}&type=${type}';

    try {
      response = await api().apiGet(url, jwt);

      List<dynamic> res = jsonDecode(utf8.decode(response.bodyBytes));
      setState(() {
        for (var i = 0; i < res.length; i++) {
          roadInformationList.add(res[i]);
        }
      });
      print(roadInformationList);
      addRoadInfoMarkers();
    } catch (e) {
      print(e);
    }
  }

  //新增路況標記
  Future<void> addRoadInfoMarkers() async {
  print('開始標記');
  print(roadInformationList);

  try {
    for (int i = 0; i < roadInformationList.length; i++) {
      Marker marker = await createMarker(roadInformationList[i]);
      setState(() {
        _markers.add(marker);
      });
    }
  } catch (e) {
    print(e);
  }
}

Future<Marker> createMarker(Map<String, dynamic> roadInfo) async {
  try {
    BitmapDescriptor markerIcon = await _loadNetworkIcon(roadInfo['icon_url']);

    return Marker(
      markerId: MarkerId(roadInfo['roadtype']),
      position: LatLng(
        roadInfo['location']['latitude'],
        roadInfo['location']['longitude'],
      ),
      icon: markerIcon,
      infoWindow: InfoWindow(
        title: roadInfo['Address'], // 修改成正確的資訊
      ),
    );
  } catch (e) {
    print(e);
    // 如果加載圖標出現異常，返回一個默認的 Marker，你可以根據需求修改這個行為
    return Marker(
      markerId: MarkerId(roadInfo['roadtype']),
      position: LatLng(
        roadInfo['location']['latitude'],
        roadInfo['location']['longitude'],
      ),
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(
        title: roadInfo['Address'], // 修改成正確的資訊
      ),
    );
  }
}

Future<BitmapDescriptor> _loadNetworkIcon(String url) async {
  final http.Response response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return BitmapDescriptor.fromBytes(response.bodyBytes);
  } else {
    throw Exception('Failed to load network image');
  }
}


  //取得經緯度座標
  // void getLocation(destination) {
  //   _markers.clear();
  //   for (int i = 0; i < destinationList.length; i++) {
  //     if (destination == destinationList[i]['name']) {
  //       addPositionMarkers(destinationList[i]['lat'], destinationList[i]['lng'],
  //           destinationList[i]['name']);
  //       i = destinationList.length;
  //     }
  //   }
  // }

  _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  //Google Map View
  Widget mapView() {
    return GoogleMap(
      myLocationEnabled: false,
      myLocationButtonEnabled: false,
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: LatLng(state.positionNow.latitude, state.positionNow.longitude),
        zoom: 11,
      ),
      markers: _markers,
    );
  }

  //取得目的地經緯度座標
  Future<List<String>> getInputLocation(inputText, inputValue) async {
    var key = dotenv.env['GOOGLE_MAPS_API_KEY'];
    var response;
    var data;
    var url =
        'https://maps.googleapis.com/maps/api/place/textsearch/json?location=${state.positionNow.latitude}%2C${state.positionNow.longitude}&query=${input}&key=${key}';
    try {
      response = await get(Uri.parse(url.toString()));
    } catch (e) {
      print(e);
    }
    var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      data = responseBody['results'];
      suggestions = [];
      // 将API响应数据转换为建议项列表
      for (var item in data) {
        suggestions.add(item['name']);
        destinationList.add({
          'name': item['name'],
          'lat': item['geometry']['location']['lat'],
          'lng': item['geometry']['location']['lng'],
        });
      }
      return suggestions;
    } else {
      return suggestions;
    }
  }

  //搜尋紐
  PreferredSizeWidget appBar() {
    return AppBar(
      backgroundColor: const Color.fromRGBO(62, 111, 179, 1),
      leading: const InkWell(
          child: Icon(
        Icons.search,
        color: Colors.white,
        size: 28,
      )),
      title: TypeAheadField(
        textFieldConfiguration: TextFieldConfiguration(
          autofocus: false,
          style: DefaultTextStyle.of(context)
              .style
              .copyWith(fontStyle: FontStyle.italic, color: Colors.white),
          controller: endPlaceText,
          onChanged: (value) {
            // 获取用户输入的内容
            input = value;
          },
        ),
        suggestionsCallback: (pattern) async {
          return getInputLocation(input, false);
        },
        itemBuilder: (context, suggestion) {
          return ListTile(
            title: Text(suggestion.toString()),
          );
        },
        onSuggestionSelected: (suggestion) {
          endPlaceText.text = suggestion;
          // getLocation(suggestion);
        },
      ),
    );
  }

  // //定位及篩選路況按鈕
  Widget floatingBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          backgroundColor: const Color.fromRGBO(33, 84, 144, 1),
          onPressed: () {
            // addPositionMarkers(state.positionNow.latitude,
            // state.positionNow.longitude, '目前位置');
          },
          child: const Icon(
            Icons.location_searching,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        FloatingActionButton(
          backgroundColor: const Color.fromRGBO(33, 84, 144, 1),
          onPressed: () {
            setState(() {
              sclectShow = (sclectShow == false ? true : false);
            });
           
          },
          child: const Icon(
            Icons.line_weight,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  void _filterRoadInfoItemsChange(index, isSelected) {
    roadInfoFilterList[index]['isChecked'] = isSelected;
    if (isSelected) {
      _filterRoadInfoItems.add(roadInfoFilterList[index]['title']);
    } else {
      _filterRoadInfoItems.remove(roadInfoFilterList[index]['title']);
    }
  }

  //篩選路況

  //新增List要顯示的路況
  void addRoadInfoDetailList(list) {
    roadInfoDetail.add(list);
  }

  //道路資訊詳細資訊
  Future<void> showRoadInfoDetail() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // icon: Image.network(_showRoadInfoDetail['roadtype'],height: 70,),
          title: Text('${_showRoadInfoDetail['areaNm']}'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  '日期：${_showRoadInfoDetail['happendate']}',
                  style: const TextStyle(fontSize: 13),
                ),
                Text(
                    '時間：${_showRoadInfoDetail['happentime'].toString().substring(0, 5)}',
                    style: const TextStyle(fontSize: 13)),
                const SizedBox(
                  height: 5,
                ),
                Text('${_showRoadInfoDetail['comment']}',
                    style: const TextStyle(fontSize: 13)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('返回'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //道路資訊list
  Widget roadInfoListView(ScrollController scrollController) {
    return SizedBox(
      width: screenWidth * 0.9,
      child: ListView(
        controller: scrollController,
        padding: EdgeInsets.zero,
        children: List.generate(
          roadInformationList.length,
          (index) {
            final list = roadInformationList[index];
            return InkWell(
              child: Column(
                children: [
                  ListTile(
                      leading: Image.network(list['icon_url']),
                      // leading: Image.asset(list['roadtype']),
                      title: Text(list['areaNm']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('日期：' + list['happendate']),
                          Text(
                              '時間：${list['happentime'].toString().substring(0, 5)}'),
                          Text(
                            list['comment'].toString(),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      )),
                  const Divider(
                    thickness: 1,
                    color: Colors.grey,
                    indent: 10,
                    endIndent: 10,
                  ),
                ],
              ),
              onTap: () {
                setState(() {
                  _showRoadInfoDetail = list;
                });
                showRoadInfoDetail();
              },
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Stack(
        children: [
          mapView(),
          Align(
            alignment: Alignment.bottomLeft,
            child: DraggableScrollableSheet(
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  width:
                      screenWidth > 600 ? screenWidth / 4 + 100 : screenWidth,
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
                        child: roadInfoListView(scrollController),
                      ),
                    ],
                  ),
                );
              },
              expand: false,

              initialChildSize: 0.3, // 初始高度比例
              minChildSize: 0.3, // 最小高度比例
              maxChildSize: 1, // 最大高度比例
            ),
          ),
          Visibility(
            visible: sclectShow,
            child: Align(
              alignment: Alignment.center,
              child: Card(
                  child: SizedBox(
                width: 250,
                height: 400,
                child: Column(
                  children: [
                    for (int i = 0; i < roadInfoFilterList.length; i++)
                      CheckboxListTile(
                          title: Text(roadInfoFilterList[i]['title']),
                          value: roadInfoFilterList[i]['isChecked'],
                          onChanged: (value) {
                            setState(() {
                              roadInfoFilterList[i]['isChecked'] =
                                  roadInfoFilterList[i]['isChecked'] == false
                                      ? true
                                      : false;
                            });

                            for (var i = 0;
                                i < roadInfoFilterList.length;
                                i++) {
                              if (roadInfoFilterList[i]['isChecked'] == true) {
                                roadInformationList = [];
                                getPBS(roadInfoFilterList[i]['value']);
                              }
                            }
                          })
                  ],
                ),
              )),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: floatingBtn(),
    );
  }
}
