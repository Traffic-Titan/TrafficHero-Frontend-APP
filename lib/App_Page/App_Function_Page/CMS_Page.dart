// ignore_for_file: file_names, sort_child_properties_last, unused_element, unused_local_variable, override_on_non_overriding_member, prefer_typing_uninitialized_variables, avoid_print, duplicate_ignore, avoid_unnecessary_containers
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

  PageController controller = PageController();
  List<dynamic> cmsList_car = [
    {
      "type": "高速公路服務區停車位狀態",
      "icon":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b1/ROC_Taiwan_Area_National_Freeway_Bureau_Logo.svg/200px-ROC_Taiwan_Area_National_Freeway_Bureau_Logo.svg.png",
      "content": [
        {
          "text": ["清水服務區"],
          "color": ["#FFFFFF"]
        },
        {
          "text": ["狀態:", "未滿"],
          "color": ["#FFFFFF", "#FFFFFF"]
        },
        {
          "text": ["尚有479格停車位"],
          "color": ["#FFFFFF"]
        }
      ],
      "voice": "前方清水服務區，目前還有479格停車位，停車位未滿",
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

  late Icon phoneIcon = const Icon(
    CupertinoIcons.device_phone_landscape,
    size: 40,
  );

  @override
  void initState() {
    super.initState();
    FlPiP().status.addListener(listener);
    // setDisplay();
  }

  void listener() {
    if (FlPiP().status.value == PiPStatus.enabled) {
      FlPiP().toggle(AppState.background);
    } else {
      FlPiP().toggle(AppState.foreground);
    }
  }

  Future<void> _getSpeed() async {
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 0,
    );
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      double speedInMps = position.speed ?? 0.0;
      int speedInKmh = (speedInMps * 3.6).toInt();
      setState(() {
        _speed = speedInKmh;
        print(_speed);
      });

      _speedStreamController.add(speedInKmh.toDouble());
    });
  }

  @override
  void dispose() {
    super.dispose();
    FlPiP().status.removeListener(listener);
    _stopTrackingPosition(); // 停止追踪位置更新
    _speedStreamController.close();
  }

  bool directionState = true;
  String displayText1 = '';
  String displayText2 = '';
  String displayText3 = '';
  String displayText4 = '';
  String displayText5 = '';
  String displayText6 = '';
  var Text1Color = 'FFFFFFFF';
  var Text2Color = 'FFFFFFFF';
  var Text3Color = 'FFFFFFFF';
  var Text4Color = 'FFFFFFFF';
  var Text5Color = 'FFFFFFFF';
  var Text6Color = 'FFFFFFFF';
  var Carpostionstatus = false;
  // String displayImg='assets/fastLocation/transparent.png';
  // 預設圖片：全黑背景圖片
  String displayImg = 'https://www.colorhexa.com/000000.png';
  Timer? timer;
  StreamSubscription<Position>? _positionStreamSubscription;
  late List<Placemark> placemarks;
  var positionNow;
  String speed = '0';
  var fontSize;

//當頁面創造時執行
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    state = Provider.of<stateManager>(context, listen: false);
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    fontSize = screenWidth * 0.05;
    _startTrackingPosition();
    _getSpeed();
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //     overlays: [SystemUiOverlay.top]);
    updateCMSList_Car();
    prefs = await SharedPreferences.getInstance();
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
    var position = await geolocator().updataPosition();
    var urlPosition = url +
        '?os=${prefs.get('system')}&mode=${changeMode(state.modeName)}&latitude=${position.latitude}&longitude=${position.longitude}';

    print(urlPosition);
    var jwt = ',${state.accountState}';

    var response = await api().apiGet(urlPosition, jwt);
    var res = jsonDecode(utf8.decode(response.bodyBytes))['url'];
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
  }

  savePosition() async {
    print('儲存停車開始存取');
    EasyLoading.show(status: '儲存中');
    var position = await geolocator().updataPosition();
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
    var position = await geolocator().updataPosition();
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

  location() async {
    try {
      positionNow = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
      setState(() {
        var speed1 = positionNow!.speed.toInt().ceil() <= 0
            ? 0
            : positionNow!.speed.toInt().ceil();
        if (speed1 >= 20) {
          // FlutterTts().speak('限速10公里，您已超速！');
        }
        speed = speed1.toString();
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      // 取得目前位置
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      location();
    } catch (e) {
      // ignore: avoid_print
      print('Error getting current location: $e');
    }
  }

  void _startTrackingPosition() {
    // 订阅位置更新的流
    _positionStreamSubscription = Geolocator.getPositionStream().listen(
      (Position position) {
        location();
      },
      onError: (error) {
        // ignore: avoid_print
        print('Position stream error: $error');
      },
    );
  }

  void _stopTrackingPosition() {
    // 取消位置更新的订阅
    timer?.cancel();
    _positionStreamSubscription?.cancel();
  }

  // 更新CMS_car資訊
  void updateCMSList_Car() async {
    // 讀取API上即時訊息推播-汽車模式
    print('開始抓取ＣＭＳ');
    var url =
        dotenv.env['CMS_Main_Car'].toString() + '?longitude=all&latitude=all';
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
      setState(() {
        cmsList_car = responseBody;
      });

      setDisplay();
      print(cmsList_car);
      print(cmsList_car[0]['content'][0]['text'][0]);
      print(cmsList_car[0]['content'][0]['color'][0]);
      print(changeColorCode(cmsList_car[0]['content'][0]['color'][0]));
    }
  }

  void setDisplay() {
    int index = 0;
    // 每5秒向後端要求一次CMS資料
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (index < cmsList_car.length) {
        controller.animateToPage(
          index,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        index++;
      } else {
        index = 0;
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

  Color changeColorCode(color) {
    return Color(int.parse(('FF' + color.replaceAll("#", "")), radix: 16));
  }

  //Widget
  Widget CMS_Content() {
    return Container(
      width: screenWidth - 200,
      child: Column(
        // 將Expanded包裹在Column中
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: PageView.builder(
              controller: controller,
              itemCount: cmsList_car.length, // 更新itemCount，確保與數據源的長度一致
              itemBuilder: (context, index) {
                final pageList = cmsList_car[index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      pageList['icon'],
                      width: 100,
                      height: 100,
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount: pageList['content'].length,
                            itemBuilder: (context, index) {
                              var list1 = pageList['content'][index];
                              return Center(
                                child: Text(
                                  list1['text'][0],
                                  style: TextStyle(
                                      color: changeColorCode(
                                        list1['color'][0],
                                      ),
                                      fontSize: 20),
                                ),
                              );
                            }))
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
                const Text('km/h',
                    style: TextStyle(fontSize: 30, color: Colors.yellow),
                    textAlign: TextAlign.right)
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // 垂直方向置中
              // crossAxisAlignment: CrossAxisAlignment.center, // 水平方向置中
              children: [
                // for (var k = 0; k < cmsList_car.length; k++)
                //   for (var j = 0; j < cmsList_car[k]['content'].length; j++)
                //     for (var i = 0;
                //         i < cmsList_car[k]['content'][j]['text'].length;
                //         i++)
                //       Text(cmsList_car[k]['content'][j]['text'][i].toString(),
                //           style: TextStyle(
                //             color: changeColorCode(
                //                 cmsList_car[k]['content'][j]['color'][i]),
                //           )),
                Container(
                  width: screenWidth - 200,
                  height: 300,
                  child: Column(
                    children: [
                      Expanded(child: CMS_Content()),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              color: Colors.green,
              height: screenHeight,
              width: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '路',
                    style: TextStyle(color: Colors.white, fontSize: 50),
                  ),
                  Text(
                    '肩',
                    style: TextStyle(color: Colors.white, fontSize: 50),
                  ),
                  Text(
                    '開',
                    style: TextStyle(color: Colors.white, fontSize: 50),
                  ),
                  Text(
                    '放',
                    style: TextStyle(color: Colors.white, fontSize: 50),
                  ),
                ],
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
                      childAspectRatio: 0.01),
                  children: List.generate(
                    Tool.fastLocationCarCms.length,
                    (index) {
                      final tool = Tool.fastLocationCar[index];
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
                                  )),
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
              ))
        ],
      )),
      floatingActionButton: Container(
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          heroTag: "btn13",
          child: const Icon(
            Icons.picture_in_picture,
            size: 40,
          ),
          backgroundColor: Colors.blueAccent,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CMSPIP()));
          },
        ),
        const SizedBox(
          height: 10,
        ),
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
          onPressed: () {
            //顯示導航及最頂端列
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
            Navigator.pop(context);
          },
        )
      ])),
    );
  }

  Widget horizontalPage(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // 垂直方向置中
              crossAxisAlignment: CrossAxisAlignment.center, // 水平方向置中
              children: [
                SizedBox(
                  height: 0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      speed,
                      style:
                          const TextStyle(fontSize: 80, color: Colors.yellow),
                      textAlign: TextAlign.right,
                    ),
                    const Text('km/h',
                        style: TextStyle(fontSize: 30, color: Colors.yellow),
                        textAlign: TextAlign.right)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center, // 垂直方向置中
                  crossAxisAlignment: CrossAxisAlignment.center, // 水平方向置中
                  children: [
                    Image.network(
                      displayImg,
                      height: 80,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          displayText1,
                          style: TextStyle(
                            fontSize: 35,
                            color: HexColor(Text1Color),
                          ),
                          textAlign: TextAlign.center,
                          softWrap: true,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              displayText2,
                              style: TextStyle(
                                fontSize: 35,
                                color: HexColor(Text2Color),
                              ),
                              softWrap: true,
                            ),
                            Text(
                              displayText3,
                              style: TextStyle(
                                fontSize: 35,
                                color: HexColor(Text3Color),
                              ),
                              softWrap: true,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              displayText4,
                              style: TextStyle(
                                fontSize: 35,
                                color: HexColor(Text4Color),
                              ),
                              textAlign: TextAlign.center,
                              softWrap: true,
                            ),
                            Text(
                              displayText5,
                              style: TextStyle(
                                fontSize: 35,
                                color: HexColor(Text5Color),
                              ),
                              textAlign: TextAlign.center,
                              softWrap: true,
                            ),
                            Text(
                              displayText6,
                              style: TextStyle(
                                fontSize: 35,
                                color: HexColor(Text6Color),
                              ),
                              textAlign: TextAlign.center,
                              softWrap: true,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              color: Colors.green,
              height: screenHeight,
              width: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '路',
                    style: TextStyle(color: Colors.white, fontSize: 50),
                  ),
                  Text(
                    '肩',
                    style: TextStyle(color: Colors.white, fontSize: 50),
                  ),
                  Text(
                    '開',
                    style: TextStyle(color: Colors.white, fontSize: 50),
                  ),
                  Text(
                    '放',
                    style: TextStyle(color: Colors.white, fontSize: 50),
                  ),
                ],
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
                      childAspectRatio: 0.01),
                  children: List.generate(
                    Tool.fastLocationCarCms.length,
                    (index) {
                      final tool = Tool.fastLocationCar[index];
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
                                  )),
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
              ))
        ],
      )),
      floatingActionButton: Container(
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
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
              // changeWidget();
              phoneIcon = const Icon(
                CupertinoIcons.device_phone_landscape,
                size: 40,
              );
              directionState = true;
            });

            // changeWidget(context);
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
              //設置垂直
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
                DeviceOrientation.portraitDown,
              ]);
            } else {
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
                DeviceOrientation.portraitDown,
              ]);
            }
            //顯示導航及最頂端列
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
            Navigator.pop(context);
          },
        ),
        const SizedBox(
          width: 40,
        ),
      ])),
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
