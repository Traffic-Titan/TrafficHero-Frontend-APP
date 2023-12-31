// ignore_for_file: file_names, sort_child_properties_last, unused_element, unused_local_variable, override_on_non_overriding_member, prefer_typing_uninitialized_variables, avoid_print, duplicate_ignore, avoid_unnecessary_containers, deprecated_member_use, library_prefixes, non_constant_identifier_names, prefer_final_fields, prefer_const_constructors, prefer_interpolation_to_compose_strings, empty_catches, sized_box_for_whitespace, prefer_const_literals_to_create_immutables
import 'package:flutter_waya/extension/object_extension.dart';
import 'package:traffic_hero/Imports.dart';
import 'package:geocoding/geocoding.dart';
import 'package:traffic_hero/Components/Tool.dart' as Tool;

class CMS extends StatefulWidget {
  const CMS({super.key});

  @override
  State<CMS> createState() => _CMSState();
}

class _CMSState extends State<CMS> {
  var screenWidth;
  var screenHeight;
  List<String> stringList = [];
  var position1;
  int index1 = 0;
  var SpeedEnforcement;
  List<dynamic> ShowSpeedEnforcement = [];
  PageController controller = PageController();
  List<dynamic> cmsList_car = [
    {
      "type": "",
      "icon": "https://www.colorhexa.com/000000.png",
      "content": [
        {
          "text": [""],
          "color": ["#FFFFFF"]
        },
        {
          "text": ["", ""],
          "color": ["#FFFFFF", "#FFFFFF"]
        },
        {
          "text": [""],
          "color": ["#FFFFFF"]
        }
      ],
      "voice": "",
      "longitude": "121.000000",
      "latitude": "25.000000",
      "direction": "string",
      "distance": 2.5,
      "priority": "1",
      "start": "2023-11-15T12:27:16.874000",
      "end": "2025-01-05T04:27:16.874000",
      "active": true,
      "id": "655448a4c9dca141521c3630"
    },
  ];
  late stateManager state;
  late SharedPreferences prefs;
  int _speed = 0;
  StreamController<double> _speedStreamController = StreamController<double>();
  bool showIcon = false;
  var position;

  late Icon phoneIcon = const Icon(
    CupertinoIcons.device_phone_landscape,
    size: 40,
  );

  bool directionState = true;
  var Carpostionstatus = false;
  String displayImg = 'https://www.colorhexa.com/000000.png';
  Timer? timer2;
  StreamSubscription<Position>? _positionStreamSubscription;
  late List<Placemark> placemarks;
  var positionNow;
  String speed = '0';
  var fontSize;
  bool showCMS = true;
  bool showSpeed = false;
  bool _showCMS = false;
  final _firebaseMess = FirebaseMessaging.instance;
  @override
  void initState() {
    super.initState();
    _stopTrackingPosition();

    initNotifications();
    controller = PageController();
  }

//即時訊息緊急推播
  Future<void> initNotifications() async {
    prefs = await SharedPreferences.getInstance();
    await _firebaseMess.requestPermission();
    final fCMToken = await _firebaseMess.getToken();
    print('Token:$fCMToken');

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('App opened from onMessageOpenedApp message:');
      print('title: ${message.notification?.title}');
      print('body: ${message.notification?.body}');
      print('payload: ${message.data}');

      final newMessage = {
        'title': message.notification?.title,
        'body': message.notification?.body,
        'payload': message.data
      };

      try {
        saveList(newMessage);
      } catch (e) {
        print(e);
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('App opened from onMessage message:');
      print('title: ${message.notification?.title}');
      print('body: ${message.notification?.body}');
      print('payload: ${message.data}');

      if (message.notification?.title == '即時訊息推播') {
        _stopTrackingPosition();

        var body123 = message.notification?.body.toList;
        print(body123);
        setState(() {
          showCMS = false;
          _showCMS = true;
        });
        await FlutterTts().speak('前方龍潭路道路封閉，請改走四維路');
      }

      // 初始化 messageList，以防它為 null
      // 使用 Map 類型來構建新的訊息
      final newMessage = {
        'title': message.notification?.title,
        'body': message.notification?.body,
        'payload': message.data
      };
    });
  }



//當頁面創造時執行
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _stopTrackingPosition();
    state = Provider.of<stateManager>(context, listen: false);
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    fontSize = screenWidth * 0.05;
    position = state.positionNow;
    position1 = state.positionNow;
    await getSpeedEnforcement();
    _getSpeed();
    updateCMSList_Car();
    updateCMS_Sidbar_List_Car();

    prefs = await SharedPreferences.getInstance();
  }

  @override
  void dispose() {
    super.dispose();
    print('離開頁面');
    _stopTrackingPosition(); // 停止追踪位置更新
    _speedStreamController.close();
    controller.dispose();
    print(controller.isBlank);
    print(timer2?.isActive);
  }

  changeMode(mode) {
    if (mode == 'car') {
      return 'Car';
    } else if (mode == 'scooter') {
      return 'Scooter';
    }
  }

  //快速尋找地點
  findPlacesQuickly(url) async {
    try {
      position = await geolocator().updataPosition(context);

      var response;
      var res;
      var urlPosition = url +
          '?os=${prefs.get('system')}&mode=${changeMode(state.modeName)}&longitude=${position.longitude}&latitude=${position.latitude}';

      print(urlPosition);
      var jwt = ',${state.accountState}';
      try {
        response = await api().apiGet(urlPosition, jwt);
        print(jsonDecode(utf8.decode(response.bodyBytes)));
        res = jsonDecode(utf8.decode(response.bodyBytes))['url'];
        if (response.statusCode == 200) {
          EasyLoading.dismiss();
          try {
            print(res);
            await launch(res);
          } catch (e) {
            print(e.toString());
            EasyLoading.showError(e.toString());
          }
        } else {
          EasyLoading.dismiss();
          print(jsonDecode(utf8.decode(response.bodyBytes)));
        }
      } catch (e) {
        print(e);
      }
    } catch (e) {
      print(e);
    }
  }

  //Save Position
  savePosition() async {
    print('儲存停車開始存取');
    EasyLoading.show(status: '儲存中');
    var position = await geolocator().updataPosition(context);
    var body = {
      "longitude": position.longitude.toString(),
      "latitude": position.latitude.toString()
    };
    var url = dotenv.env['SaveCarPosition'];
    var jwt = ',' + state.accountState;
    var response;
    try {
      response = await api().apiPut(body, url, jwt);
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        EasyLoading.showSuccess(responseBody['message']);
        Carpostionstatus = true;
        print('儲存停車成功');
        EasyLoading.dismiss();
      }
    } catch (e) {
      print(e);
      EasyLoading.showError('存取失敗');
      print('儲存停車失敗');
      EasyLoading.dismiss();
    }
  }

  getPosition() async {
    print('儲存停車開始存取');
    EasyLoading.show(status: '儲存中');
    var position = await geolocator().updataPosition(context);
    var url = '${dotenv.env['GetCarPosition']}?os=${prefs.get('system')}';
    print(url);
    var jwt = ',' + state.accountState;
    var response;
    try {
      response = await api().apiGet(url, jwt);
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        EasyLoading.showSuccess(responseBody['message']);
        print('儲存停車成功');
        EasyLoading.dismiss();
      }
    } catch (e) {
      print(e);
      EasyLoading.showError('存取失敗');
      print('儲存停車失敗');
      EasyLoading.dismiss();
    }
  }

  void _stopTrackingPosition() async {
    // 取消位置更新的訂閱
    if (timer2 != null) {
      try {
        timer2?.cancel();
      } catch (e) {
        print('Error while canceling timer2: $e');
      }
    }
    _positionStreamSubscription?.cancel();
  }


// 時速、判斷播報訊息距離
    Future<void> _getSpeed() async {
    print('開始抓取速率');
    final LocationSettings locationSettings = LocationSettings(
      distanceFilter: 0,
      accuracy: LocationAccuracy.bestForNavigation,
    );
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      double speedInMps = position.speed;
      int speedInKmh = (speedInMps * 3.6).toInt();
      print(speedInKmh);
      setState(() {
        _speed = speedInKmh;
        positionNow = position;
        print(_speed);
      });

      //25.068250, 121.529460
      double distance = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        position1.latitude,
        position1.longitude,
      );

      double direction = Geolocator.bearingBetween(
        position1.latitude,
        position1.longitude,
        position.latitude,
        position.longitude,
      );
      print(distance);
      print(direction);
      String directionString = getDirectionString(direction);
      print(directionString);

      print((_speed > 100 ? 10000 : 5000));
      if (distance < (_speed > 100 ? 1000 : 500)) {
        print(true);
      } else {
        print(distance);
        getSpeedEnforcement();
        _stopTrackingPosition();
        updateCMSList_Car();
        updateCMS_Sidbar_List_Car();
      }
      var last;

      for (var i = 0; i < SpeedEnforcement.length; i++) {
        double SpeedEnforcementDistance = Geolocator.distanceBetween(
          SpeedEnforcement[i]['location']['latitude'],
          SpeedEnforcement[i]['location']['longitude'],
          position.latitude,
          position.longitude,
        );

        try {
          // if (SpeedEnforcement[i]['direction'] == directionString) {
          print('SpeedEnforcementDistance < 600:' +
              (SpeedEnforcementDistance < 600).toString());
          print('最近測速照相距離' + SpeedEnforcementDistance.toString());
          if (SpeedEnforcementDistance < 300 &&
              SpeedEnforcementDistance > 200) {
            setState(() {
              ShowSpeedEnforcement = [];
            });
            ShowSpeedEnforcement.add(SpeedEnforcement[i]);

            print('前方有測速照相600公尺');
          }

          setState(() {
            last = SpeedEnforcementDistance;
          });

          // }
        } catch (e) {
          print(e);
        }
      }

      for (var i = 0; i < ShowSpeedEnforcement.length; i++) {
        double SpeedEnforcementDistance2 = Geolocator.distanceBetween(
          ShowSpeedEnforcement[i]['location']['latitude'],
          ShowSpeedEnforcement[i]['location']['longitude'],
          position.latitude,
          position.longitude,
        );
        if (SpeedEnforcementDistance2 < 290 &&
            SpeedEnforcementDistance2 > 100) {
          setState(() {
            showCMS = false;
            showSpeed = true;
            _showCMS = false;
            _stopTrackingPosition();

            FlutterTts().speak(ShowSpeedEnforcement[i]['voice'] +
                (speedInKmh > int.parse(ShowSpeedEnforcement[i]['speed_limit'])
                    ? '您已超速'
                    : ''));
          });

          print(ShowSpeedEnforcement[i]['voice'] +
              (speedInKmh > int.parse(ShowSpeedEnforcement[i]['speed_limit'])
                  ? '您已超速'
                  : ''));
          print('前方有測速照相600公尺');
        } else {
          setState(() {
            showCMS = true;
            showSpeed = false;
          });
        }
      }

      print('showCMS:' + showCMS.toString());
      print('showSpeed:' + showSpeed.toString());

      _speedStreamController.add(speedInKmh.toDouble());
    });
  }

//判斷行走方向
  String getDirectionString(double direction) {
    if ((direction >= 337.5 && direction <= 360) ||
        (direction >= 0 && direction < 22.5)) {
      return '南向北';
    } else if (direction >= 22.5 && direction < 112.5) {
      return '西向東';
    } else if (direction >= 112.5 && direction < 202.5) {
      return '北向南';
    } else if (direction >= 202.5 && direction < 292.5) {
      return '東向西';
    } else {
      return '未知方向';
    }
  }

  // 更新CMS_car資訊
  Future<void> updateCMSList_Car() async {
    // 讀取API上即時訊息推播-汽車模式
    print('開始抓取ＣＭＳ');
    _stopTrackingPosition();
    try {
      var url = (state.modeName == 'car'
              ? dotenv.env['CMS_Main_Car'].toString()
              : dotenv.env['CMS_Main_Scooter'].toString().toString()) +
          '?longitude=${position1.longitude}&latitude=${position1.latitude}';
      // '?longitude=all&latitude=all';
      var jwt = ',${state.accountState}';
      var response;
      try {
        print(url);
        response = await api().apiGet(url, jwt);
      } catch (e) {
        print(e);
      }

      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        print('抓取ＣＭＳ成功');
        state.updateCMSList_Car(responseBody);
        try {
          setState(() {
            if (responseBody != []) {
              setState(() {
                cmsList_car = responseBody;
                print("CMS:" + cmsList_car.toString());
              });
            } else {
              List<dynamic> cmsList_car = [
                {
                  "type": "",
                  "icon": "https://www.colorhexa.com/000000.png",
                  "content": [
                    {
                      "text": [""],
                      "color": ["#FFFFFF"]
                    },
                    {
                      "text": ["", ""],
                      "color": ["#FFFFFF", "#FFFFFF"]
                    },
                    {
                      "text": [""],
                      "color": ["#FFFFFF"]
                    }
                  ],
                  "voice": "",
                  "longitude": "121.000000",
                  "latitude": "25.000000",
                  "direction": "string",
                  "distance": 2.5,
                  "priority": "1",
                  "start": "2023-11-15T12:27:16.874000",
                  "end": "2025-01-05T04:27:16.874000",
                  "active": true,
                  "id": "655448a4c9dca141521c3630"
                },
              ];
            }
          });
          setState(() {
            index1 = 0;
          });
          setDisplay();
        } catch (e) {
          print('CMS抓取失敗：' + e.toString());
        }
      } else {
        print('CMS抓取失敗');
      }
    } catch (e) {
      print(e);
    }
  }

  //更新測速照相
  getSpeedEnforcement() async {
    print('開始抓取測速照相');
    position1 = await geolocator().updataPosition(context);
    var response,
        responseBody,
        url = dotenv.env['SpeedEnforcement'].toString() +
            '?longitude=${position1.longitude}&latitude=${position1.latitude}&max_distance=10',
        jwt = ',${state.accountState}';

    try {
      response = await api().apiGet(url, jwt);
      responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      setState(() {
        SpeedEnforcement = responseBody;
      });
      print('測速照相抓取成功');
      print(responseBody);
    } catch (e) {
      print(e);
    }
  }

  //UpDate CMS Sidebar
  void updateCMS_Sidbar_List_Car() async {
    // 讀取API上即時訊息推播-汽車模式
    try {
      print('開始抓取ＣＭＳ_Sidbar');

      var url = (state.modeName == 'car'
              ? dotenv.env['CMS_Sidebar_Car'].toString()
              : dotenv.env['CMS_Sidebar_Scooter'].toString().toString()) +
          '?longitude=${position1.longitude}&latitude=${position1.latitude}';
      // '?longitude=all&latitude=all';
      var jwt = ',${state.accountState}';
      var response;
      try {
        print(url);
        response = await api().apiGet(url, jwt);
      } catch (e) {
        print(e);
      }

      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        print('抓取CMS_Sidbar成功');

        try {
          setState(() {
            if (responseBody != []) {
              print(responseBody);
              stringList = responseBody[0]['content'][0]['text'][0].split('');
            } else {
              stringList = [];
            }

            print("CMS_Sidbar:" + stringList.toString());
          });
        } catch (e) {}
      } else {
        print('CMS_Sidbar抓取失敗');
      }
    } catch (e) {
      print(e);
    }
  }

  void setDisplay() async {
    // 每10秒向後端要求一次CMS資料
    int index = 0;

    timer2 = Timer.periodic(const Duration(seconds: 10), (timer) async {
      print(index);

      if (index >= 0 && index < cmsList_car.length) {
        try {
          await FlutterTts().speak(cmsList_car[index]['voice']);
          print(cmsList_car[index]);
          controller.animateToPage(
            index,
            duration: Duration(milliseconds: 1000),
            curve: Curves.easeInOut,
          );
        } catch (e) {
          print(e);
        }
        setState(() {
          index++;
        });
      } else {
        setState(() {
          index = 0;
        });
      }
    });
  }

  changeWidget() {
    if (directionState) {
      print('2');
      //設置垂直
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      setState(() {
        phoneIcon = const Icon(
          CupertinoIcons.device_phone_landscape,
          size: 40,
        );
        directionState = true;
      });
    } else {
      print("1");
      //設置橫向
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      setState(() {
        phoneIcon = const Icon(
          CupertinoIcons.device_phone_portrait,
          size: 40,
        );
        directionState = false;
      });
    }
  }

//向後端抓取顏色編碼，重新編碼
  Color changeColorCode(color) {
    return Color(int.parse(('FF' + color.replaceAll("#", "")), radix: 16));
  }


//View Code
  //Widget
  Widget CMS_Content() {
    return Container(
      width: screenWidth - 150,
      height: 400,
      child: PageView.builder(
        controller: controller,
        itemCount: cmsList_car.length,
        itemBuilder: (context, index) {
          final pageList = cmsList_car[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                pageList['icon'],
                width: 130,
                height: 130,
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true, // 添加這一行
                  itemCount: pageList['content'].length,
                  itemBuilder: (context, index) {
                    var list1 = pageList['content'][index];
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              list1['text'].length,
                              (index) {
                                var list2text = list1['text'][index];
                                var list2color = list1['color'][index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    list2text,
                                    style: TextStyle(
                                      color: changeColorCode(list2color),
                                      fontSize: screenWidth * 0.07,
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget CMS() {
    return Container(
        width: screenWidth - 150,
        height: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://www.web-rentacar.com/img/helpful/road_signs_3.png',
              width: 130,
              height: 130,
            ),
            Expanded(
                child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '道路封閉',
                    style: TextStyle(
                        color: Colors.white, fontSize: screenWidth * 0.07),
                  ),
                  Text(
                    '龍潭路',
                    style: TextStyle(
                        color: Colors.white, fontSize: screenWidth * 0.07),
                  ),
                  Text(
                    '請改走四維路',
                    style: TextStyle(
                        color: Colors.white, fontSize: screenWidth * 0.07),
                  )
                ],
              ),
            )),
          ],
        ));
  }

  Widget SpeedEnforcement_Content() {
    return Container(
      width: screenWidth - 150,
      height: 300,
      child: PageView.builder(
        controller: controller,
        itemCount: ShowSpeedEnforcement.length,
        itemBuilder: (context, index) {
          final pageList = ShowSpeedEnforcement[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                pageList['icon'],
                width: 130,
                height: 130,
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true, // 添加這一行
                  itemCount: pageList['content'].length,
                  itemBuilder: (context, index) {
                    var list1 = pageList['content'][index];
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              list1['text'].length,
                              (index) {
                                var list2text = list1['text'][index];
                                var list2color = list1['color'][index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    list2text,
                                    style: TextStyle(
                                      color: changeColorCode(list2color),
                                      fontSize: screenWidth * 0.07,
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget CMS_Content2() {
    return Container(
      width: screenWidth - 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: PageView.builder(
              controller: controller,
              itemCount: cmsList_car.length,
              itemBuilder: (context, index) {
                final pageList = cmsList_car[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Image.network(
                        pageList['icon'],
                        width: 130,
                        height: 130,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: screenHeight, // 這裡的寬度可能需要調整，根據你的需求
                        child: ListView.builder(
                          itemCount: pageList['content'].length,
                          itemBuilder: (context, index) {
                            var list1 = pageList['content'][index];
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: List.generate(
                                      list1['text'].length,
                                      (index) {
                                        var list2text = list1['text'][index];
                                        var list2color = list1['color'][index];
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            list2text,
                                            style: TextStyle(
                                              color:
                                                  changeColorCode(list2color),
                                              fontSize: 30,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

//App Widget
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return (directionState == true)
        ? straightPage(context)
        : horizontalPage(context);
  }

  @override
  Widget straightPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const Text(''),
      ),
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  _speed.toString(),
                  style: const TextStyle(fontSize: 80, color: Colors.yellow),
                  textAlign: TextAlign.right,
                ),
                const Text(
                  'km/h',
                  style: TextStyle(fontSize: 30, color: Colors.yellow),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: screenWidth - 150,
              height: screenHeight - 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: showSpeed,
                    child: SpeedEnforcement_Content(),
                  ),
                  Visibility(
                    visible: showCMS,
                    child: CMS_Content(),
                  ),
                  Visibility(
                    visible: _showCMS,
                    child: CMS(),
                  )
                ],
              ),
            ),
          ),
          Visibility(
              visible: stringList != [] ? false : true,
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  color: Colors.green,
                  height: screenHeight,
                  width: 50,
                  child: Center(
                    child: Container(
                      height: 300,
                      child: ListView.builder(
                        itemCount: stringList.length,
                        itemBuilder: (context, index) {
                          final list = stringList[index];
                          return Text(
                            list,
                            style: TextStyle(color: Colors.white, fontSize: 40),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              )),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              width: 300,
              height: 100,
              child: GridView(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, //横轴三个子widget
                  childAspectRatio: 0.01,
                ),
                children: List.generate(
                  Tool.fastLocationCarCms.length,
                  (index) {
                    final tool = Tool.fastLocationCarCms[index];
                    return SizedBox(
                      height: 70,
                      child: InkWell(
                        child: Column(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              margin: const EdgeInsets.all(3.0),
                              child: Card(
                                color: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                child: Image.asset(
                                  tool['img'].toString(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        onTap: () async {
                          EasyLoading.show(status: 'loading...');
                          print(tool['url']);
                          if (tool['title'] == '停車場') {
                            launch(tool['url'].toString());
                            EasyLoading.dismiss();
                          } else {
                            findPlacesQuickly(tool['url']);
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Visibility(
                  visible: showIcon,
                  child: Column(
                    children: [
                      FloatingActionButton(
                        heroTag: "btn1",
                        child: const Icon(
                          CupertinoIcons.placemark_fill,
                          size: 40,
                        ),
                        backgroundColor: Colors.blueAccent,
                        onPressed: () {
                          if (Carpostionstatus == false) {
                            savePosition();
                          } else {
                            getPosition();
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FloatingActionButton(
                        heroTag: "btn2",
                        child: phoneIcon,
                        backgroundColor: Colors.blueAccent,
                        onPressed: () {
                          SystemChrome.setPreferredOrientations([
                            DeviceOrientation.landscapeLeft,
                            DeviceOrientation.landscapeRight,
                          ]);
                          setState(() {
                            directionState = false;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FloatingActionButton(
                        heroTag: "btn3",
                        child: const Icon(
                          Icons.output_outlined,
                          size: 40,
                        ),
                        backgroundColor: Colors.blueAccent,
                        onPressed: () async {
                          _stopTrackingPosition();
                          _speedStreamController.close();
                          Firebase_message().initNotifications();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AllPage(),
                            ),
                            (router) => false,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                FloatingActionButton(
                  heroTag: "btn32",
                  child: const Icon(
                    Icons.menu,
                    size: 40,
                  ),
                  backgroundColor: Colors.blueAccent,
                  onPressed: () {
                    setState(() {
                      showIcon = !showIcon;
                    });
                  },
                ),
                SizedBox(
                  width: 150,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget horizontalPage(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _speed.toString(),
                    style: const TextStyle(fontSize: 80, color: Colors.yellow),
                    textAlign: TextAlign.right,
                  ),
                  const Text(
                    'km/h',
                    style: TextStyle(fontSize: 30, color: Colors.yellow),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: screenWidth - 150,
                height: 200,
                child: CMS_Content2(),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                color: Colors.green,
                height: screenHeight,
                width: 50,
                child: Center(
                  child: Container(
                    height: 300,
                    child: ListView.builder(
                      itemCount: stringList.length,
                      itemBuilder: (context, index) {
                        final list = stringList[index];
                        return Text(
                          list,
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: 300,
                height: 100,
                child: GridView(
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, //横轴三个子widget
                    childAspectRatio: 0.01,
                  ),
                  children: List.generate(
                    Tool.fastLocationCarCms.length,
                    (index) {
                      final tool = Tool.fastLocationCarCms[index];
                      return SizedBox(
                        height: 70,
                        child: InkWell(
                          child: Column(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                margin: const EdgeInsets.all(3.0),
                                child: Card(
                                  color: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  child: Image.asset(
                                    tool['img'].toString(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          onTap: () async {
                            EasyLoading.show(status: 'loading...');
                            findPlacesQuickly(tool['url']);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: "btn1",
              child: const Icon(
                CupertinoIcons.placemark_fill,
                size: 40,
              ),
              backgroundColor: Colors.blueAccent,
              onPressed: () {
                if (Carpostionstatus == false) {
                  savePosition();
                } else {
                  getPosition();
                }
              },
            ),
            const SizedBox(
              width: 10,
            ),
            FloatingActionButton(
              heroTag: "btn2",
              child: phoneIcon,
              backgroundColor: Colors.blueAccent,
              onPressed: () {
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.portraitUp,
                  DeviceOrientation.portraitDown,
                ]);
                setState(() {
                  phoneIcon = const Icon(
                    CupertinoIcons.device_phone_landscape,
                    size: 40,
                  );
                  directionState = true;
                });
              },
            ),
            const SizedBox(
              width: 10,
            ),
            FloatingActionButton(
              heroTag: "btn3",
              child: const Icon(
                Icons.output_outlined,
                size: 40,
              ),
              backgroundColor: Colors.blueAccent,
              onPressed: () {
                if (!directionState) {
                  SystemChrome.setPreferredOrientations([
                    DeviceOrientation.portraitUp,
                    DeviceOrientation.portraitDown,
                  ]);
                } else {
                  SystemChrome.setPreferredOrientations([
                    DeviceOrientation.portraitUp,
                    DeviceOrientation.portraitDown,
                    DeviceOrientation.landscapeLeft,
                    DeviceOrientation.landscapeRight,
                  ]);
                }
                SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
                _stopTrackingPosition();
                _speedStreamController.close();
                Navigator.pop(context);
              },
            ),
            const SizedBox(
              width: 40,
            ),
          ],
        ),
      ),
    );
  }
}

class HexColor extends Color {
  static int getColorFromHex(String hexColor) {
    // 將讀到的顏色轉成大寫，並刪除所有井字號
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(getColorFromHex(hexColor));
}
