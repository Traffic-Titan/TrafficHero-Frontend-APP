// ignore_for_file: deprecated_member_use, file_names, camel_case_types, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, prefer_collection_literals, avoid_print, prefer_const_constructors, prefer_interpolation_to_compose_strings, non_constant_identifier_names, avoid_unnecessary_containers

import 'package:traffic_hero/imports.dart';

class mapPage extends StatefulWidget {
  mapPage({super.key, required this.url, required this.position});

  final url;
  final position;

  @override
  State<mapPage> createState() => _mapPageState();
}

class _mapPageState extends State<mapPage> {
  late GoogleMapController mapController;
  late stateManager state;
  late SharedPreferences prefs;
  var screenWidth;
  var screenHeight;
  final Set<Marker> _markers = Set<Marker>();
  var scrollview = true;
  var gasStationDetail;
  String name = '';
  var position;
  List<dynamic> mapListGasStation = [
    {
      "basic": {
        "station_code": "D4342",
        "type": "",
        "station_name": "",
        "address": "",
        "phone": "",
        "available": true,
        "in_freeway": false,
        "business_hours": "07:00-21:00"
      },
      "gasoline": {
        "92": true,
        "95": true,
        "98": true,
        "alcohol_gasoline": false,
        "kerosene": false,
        "super_diesel": true
      },
      "payment": {
        "member_card": true,
        "e_invoice": true,
        "easy_card": true,
        "i_pass": true,
        "happy_cash": true
      },
      "other_service": {
        "self_service": false,
        "self_service_diesel": false,
        "car_wash": "自助投幣式",
        "etag": "\n    ",
        "maintenance": "\n    "
      },
      "location": {"longitude": 120.527777777778, "latitude": 23.7008333333333},
      "distance": 0,
      "icon_url":
      "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f1/CPC_Corporation%2C_Taiwan_Seal.svg/1024px-CPC_Corporation%2C_Taiwan_Seal.svg.png",

      "url":
      "comgooglemapsurl://www.google.com/maps/dir/?api=1&destination=雲林縣斗六市雲林路二段334號&travelmode=driving&dir_action=navigate"
    }
  ];

  List<dynamic> mapListConvenientStore = [
    {
      "company_id": 23285582,
      "branch_id": 80490752,
      "company_name": "",
      "branch_name": "",
      "branch_address": "",
      "status": "核准設立",
      "location": {"longitude": 120.5357042, "latitude": 23.6984855},
      "icon_url":
          "https://www.colorhexa.com/e7f1fe.png",
      "distance": 0,
      "url":
          "comgooglemapsurl://www.google.com/maps/dir/?api=1&destination=雲林縣斗六市鎮南里明德路四五五號一樓&travelmode=driving&dir_action=navigate"
    },
  ];

  @override
  void initState() {
 
    super.initState();
  }

  @override
  void didChangeDependencies() async {

    super.didChangeDependencies();
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (widget.url == '/APP/Home/QuickSearch/ConvenientStore') {
      setState(() {
        name = '快速尋找地點 - 便利商店';
      });
    } else {
      setState(() {
        name = '快速尋找地點 - 加油站';
      });
    }
    state = Provider.of<stateManager>(context, listen: true);
    prefs = await SharedPreferences.getInstance();
    getContent();
  }

  //function
  changeMode(mode) {
    if (mode == 'car') {
      return 'Car';
    } else if (mode == 'scooter') {
      return 'Scooter';
    } else {
      return 'Transit';
    }
  }

  getContent() async {
    var response;
    var url = widget.url +
        '?os=${prefs.get('system')}&mode=${changeMode(state.modeName)}&longitude=${widget.position.longitude}&latitude=${widget.position.latitude}';
    var jwt = ',${state.accountState}';
    var responseBody;
    try {
      response = await api().apiGet(url, jwt);
      responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      print(responseBody);
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        if (widget.url == '/APP/Home/QuickSearch/ConvenientStore') {
          setState(() {
            mapListConvenientStore = responseBody;
          });
          addMarkers(responseBody);
        } else {
          setState(() {
            mapListGasStation = responseBody;
          });
          addMarkers(responseBody);
        }
      }
    } catch (e) {
      print(e);
      // getContent();
    }
  }

  changeView(url, scrollController) {
    if (url == '/APP/Home/QuickSearch/ConvenientStore') {
      return ConvenientStoreView(scrollController);
    } else {
      return GasStationView(scrollController);
    }
  }

  void addMarkers(content) {
    print('開始標記');
    _markers.clear();
    // 目前位置標記
    _markers.add(Marker(
      markerId: MarkerId('目前位置'),
      position: LatLng(widget.position.latitude, widget.position.longitude),
      icon: BitmapDescriptor.defaultMarkerWithHue(223),
      infoWindow: InfoWindow(title: '目前位置'),
    ));

    // 添加標記
    if (widget.url == '/APP/Home/QuickSearch/ConvenientStore') {
      print('1');
      print(content.length);
      for (int i = 0; i < content.length; i++) {
        print(content[i]);
        var list = content[i];
        try {
          _markers.add(
            Marker(
                markerId: MarkerId(list['company_name']),
                position: LatLng(list['location']['latitude'],
                    list['location']['longitude']),
                infoWindow: InfoWindow(
                  title: list['company_name'],
                  snippet: list['branch_address'],
                ),
                onTap: () {
                  // launch();
                  setState(() {});
                }),
          );
          print(i.toString() +
              '標記成功' +
              list['location']['latitude'].toString() +
              list['location']['longitude'].toString());
        } catch (e) {
          print(i.toString() + '標記失敗');
        }
      }
    } else {
      print(content.length);
      for (int i = 0; i < content.length; i++) {
        var list = content[i];
        _markers.add(
          Marker(
              markerId: MarkerId(list['basic']['station_name']),
              position: LatLng(
                  list['location']['latitude'], list['location']['longitude']),
              infoWindow: InfoWindow(
                title: list['basic']['station_name'] +
                    " - 距離: " +
                    list['distance'].toInt().toString() +
                    '公尺',
                snippet: list['basic']['address'],
                  onTap: () {
                    launch(content[i]['url']);
                    setState(() {});
                  }
              ),
              ),
        );
        print(i.toString() +
            '標記成功' +
            list['location']['latitude'].toString() +
            list['location']['longitude'].toString());
      }
    }
  }

//Widget
  PreferredSizeWidget appBar() {
    return AppBar(
      title: Text(name),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      backgroundColor: const Color.fromRGBO(62, 111, 179, 1),
    );
  }

  _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  //加油站詳細資訊
  Future<void> showGasStationDetail() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          icon: Image.network(gasStationDetail['icon_url'],height: 70,),
          title: Text('${gasStationDetail['basic']['station_name']}-${gasStationDetail['basic']['type']}'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('地址：${gasStationDetail['basic']['address']}',style: TextStyle(fontSize: 13),),
                Text('營業時間：${gasStationDetail['basic']['business_hours']}',style: TextStyle(fontSize: 13)),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Image.asset('assets/gasStation/gas.png',height: 25,),
                    SizedBox(width: 5,),
                    Text('提供油種',style: TextStyle(fontSize: 18,color: Colors.indigo)),
                  ],
                ),
                SizedBox(height: 3,),
                Row(
                    children: [
                      (gasStationDetail['gasoline']['92']) ? Image.asset('assets/gasStation/gasoline_92.png',height: 35,):Text(''),
                      (gasStationDetail['gasoline']['95']) ? Image.asset('assets/gasStation/gasoline_95.png',height: 35,):Text(''),
                      (gasStationDetail['gasoline']['98']) ? Image.asset('assets/gasStation/gasoline_98.png',height: 35,):Text(''),
                      (gasStationDetail['gasoline']['alcohol_gasoline']) ? Image.asset('assets/gasStation/gasoline_Alcohol.png',height: 35,):Text(''),
                      (gasStationDetail['gasoline']['kerosene']) ? Image.asset('assets/gasStation/gasoline_Alcohol.png',height: 35,):Text(''),
                      (gasStationDetail['gasoline']['super_diesel']) ? Image.asset('assets/gasStation/gasoline_Kerosene.png',height: 35,):Text(''),
                    ],
                  ),

                SizedBox(height: 5,),
                Row(
                  children: [
                    Image.asset('assets/gasStation/payment.png',height: 25,),
                    SizedBox(width: 5,),
                    Text('付款方式',style: TextStyle(fontSize: 18,color: Colors.indigo)),
                  ],
                ),
                SizedBox(height: 3,),
                Wrap(
                    children: [
                      (gasStationDetail['payment']['member_card']) ? Image.asset('assets/gasStation/payment_MemberCard.png',height: 25,):Text(''),
                      SizedBox(width: 5,),
                      (gasStationDetail['payment']['e_invoice']) ? Image.asset('assets/gasStation/payment_EInvoice.png',height: 25,):Text(''),
                      SizedBox(width: 5,),
                      (gasStationDetail['payment']['easy_card']) ? Image.asset('assets/gasStation/payment_EasyCard.png',height: 25,):Text(''),
                      SizedBox(width: 5,),
                      (gasStationDetail['payment']['i_pass']) ? Image.asset('assets/gasStation/payment_IPass.png',height: 25,):Text(''),
                      SizedBox(width: 5,),
                      (gasStationDetail['payment']['happy_cash']) ? Image.asset('assets/gasStation/payment_HappyCash.png',height: 25,):Text(''),
                    ],
                  ),

                SizedBox(height: 5,),
                Row(
                  children: [
                    Image.asset('assets/gasStation/service.png',height: 25,),
                    SizedBox(width: 5,),
                    Text('其他服務',style: TextStyle(fontSize: 18,color: Colors.indigo)),
                  ],
                ),
                SizedBox(height: 3,),
                Row(
                  children: [
                    (gasStationDetail['other_service']['self_service']) ? Image.asset('assets/gasStation/service_SelfService.png',height: 25,):Text(''),
                    (gasStationDetail['other_service']['self_service_diesel']) ? Image.asset('assets/gasStation/service_SelfDiesel.png',height: 25,):Text(''),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('確認'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget GasStationView(ScrollController scrollController) {
    return SizedBox(
      width: screenWidth,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              controller: scrollController,
              children: List.generate(
                mapListGasStation.length,
                    (index) {
                  final list = mapListGasStation[index];
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            gasStationDetail = list;
                          });
                          showGasStationDetail();
                        },
                        child: ListTile(
                            leading: Image.network(list['icon_url']),
                            title:Text('${list['basic']['station_name']}-${list['basic']['type']}'),
                            subtitle:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(list['basic']['address'],overflow: TextOverflow.ellipsis,),
                                Wrap(
                                  children: [
                                    (list['payment']['member_card']) ? Image.asset('assets/gasStation/payment_MemberCard.png',height: 25,):Text(''),
                                    (list['other_service']['self_service']) ? Image.asset('assets/gasStation/service_SelfService.png',height: 25,):Text(''),
                                    (list['other_service']['self_service_diesel']) ? Image.asset('assets/gasStation/service_SelfDiesel.png',height: 25,):Text(''),
                                  ],
                                )
                              ],
                            ),
                            trailing: InkWell(
                              child: Container(
                                  child: Column(
                                    children: [
                                      Text('${list['distance']}km',style: TextStyle(fontSize: 20,color: Colors.indigo),),
                                      Icon(Icons.navigation,color: Colors.indigo,size: 20,),
                                    ],
                                  )
                              ),
                              onTap: () {
                                launch(list['url']);
                              },
                            ),
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.grey,
                        indent: 10,
                        endIndent: 10,
                      ),
                    ],

                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget ConvenientStoreView(ScrollController scrollController) {
    return SizedBox(
      width: screenWidth,
      // height: 200,
      child: Column(
        children: [
          // Container(width: screenWidth,height: 50,color: Colors.blue,child: Center(child: Text('dddd')),),
          Expanded(
            child: ListView(
              controller: scrollController,
              children: List.generate(
                mapListConvenientStore.length,
                (index) {
                  final list = mapListConvenientStore[index];
                  return InkWell(
                    child: Column(
                      children: [
                        ListTile(
                          leading: Image.network(list['icon_url'],width:screenWidth > 600 ? 600 * 0.1 : screenWidth * 0.15,height: screenWidth > 600 ? 600 * 0.1 : screenWidth * 0.15,),
                          title:Text(list['company_name'],overflow: TextOverflow.ellipsis),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(list['branch_name'],overflow: TextOverflow.ellipsis),
                              Text(list['branch_address'],overflow: TextOverflow.ellipsis),
                            ],
                          ),
                          trailing: InkWell(
                            child: Container(
                                child: Column(
                                  children: [
                                    Text('${list['distance']}km',style: TextStyle(fontSize: 20,color: Colors.indigo),),
                                    Icon(Icons.navigation,color: Colors.indigo,size: 20,),
                                  ],
                                )
                            ),
                            onTap: () {
                              launch(list['url']);
                            },
                          ),
                        ),
                        Divider(
                            thickness: 1,
                            color: Colors.grey,
                            indent: 10,
                            endIndent: 10)
                      ],
                    ),
                    onTap: (){
                      setState(() {
                        mapController.showMarkerInfoWindow(MarkerId(list['company_name']));
                      });
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    );

    //   },
    // );
  }

  Widget draggableScrollableSheet() {
    return DraggableScrollableSheet(
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          width: screenWidth > 600 ? screenWidth / 4 + 100 : screenWidth,
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
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(50)),
                ),
              ),
              Expanded(
                child: changeView(widget.url, scrollController),
              ),
            ],
          ),
        );
      },
      expand: false,

      initialChildSize: 0.3, // 初始高度比例
      minChildSize: 0.1, // 最小高度比例
      maxChildSize: 1, // 最大高度比例
    );
  }

  Widget mapView() {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: LatLng(widget.position.latitude, widget.position.longitude),
        zoom: 15.0,
      ),
      onCameraMove: (CameraPosition position) async {
        // 監測中心座標的變化並自動輸出
      },
      markers: _markers,
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
              child: draggableScrollableSheet())
        ],
      ),
    );
  }
}
