// ignore_for_file: file_names, sort_child_properties_last, unused_element, unused_local_variable, override_on_non_overriding_member, prefer_typing_uninitialized_variables, avoid_print, duplicate_ignore, avoid_unnecessary_containers, deprecated_member_use

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
  var position;

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

  late Icon phoneIcon = const Icon(
    CupertinoIcons.device_phone_landscape,
    size: 40,
  );

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

  bool directionState = true;
  var Carpostionstatus = false;
  String displayImg = 'https://www.colorhexa.com/000000.png';
  Timer? timer2;
  StreamSubscription<Position>? _positionStreamSubscription;
  late List<Placemark> placemarks;
  var positionNow;
  String speed = '0';
  var fontSize;

  @override
  void initState() {
    super.initState();
    _stopTrackingPosition();
    _getSpeed();
    controller = PageController();
  }

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
        print(_speed);
      });

      

      _speedStreamController.add(speedInKmh.toDouble());
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
    updateCMSList_Car();
    updateCMS_Sidbar_List_Car();
    getSpeedEnforcement();
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
    var position = await geolocator().updataPosition(context);
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
  }

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
    // 取消位置更新的订阅
    //  timer2?.cancel();
    if (timer2 != null) {
      try {
        timer2?.cancel();
      } catch (e) {
        print('Error while canceling timer2: $e');
      }
    }
    _positionStreamSubscription?.cancel();
  }

  // 更新CMS_car資訊
  Future<void> updateCMSList_Car() async {
    // 讀取API上即時訊息推播-汽車模式
    print('開始抓取ＣＭＳ');
    // var position = await geolocator().updataPosition();
    var url = (state.modeName == 'car'
            ? dotenv.env['CMS_Main_Car'].toString()
            : dotenv.env['CMS_Main_Scooter'].toString().toString()) +
        // '?longitude=${position.longitude}&latitude=${position.latitude}';
        '?longitude=all&latitude=all';
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
          cmsList_car = responseBody;
        });
        setDisplay();
      } catch (e) {}

      // setDisplay();
      print(cmsList_car);
      print(cmsList_car[0]['content'][0]['text'][0]);
      print(cmsList_car[0]['content'][0]['color'][0]);
      print(changeColorCode(cmsList_car[0]['content'][0]['color'][0]));
    } else {
      print('CMS抓取失敗');
    }
  }

  getSpeedEnforcement() async {
    print('開始抓取測速照相');
    position = await geolocator().updataPosition(context);
    var response,
        responseBody,
        url = dotenv.env['SpeedEnforcement'].toString() +
            '?longitude=${position.longitude}&latitude=${position.latitude}&max_distance=5',
        jwt = ',${state.accountState}';

    try {
      response = await api().apiGet(url, jwt);
      responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      print('測速照相抓取成功');
      print(responseBody);
    } catch (e) {
      print(e);
    }
  }

  void updateCMS_Sidbar_List_Car() async {
    // 讀取API上即時訊息推播-汽車模式
    print('開始抓取ＣＭＳ');
    // var position = await geolocator().updataPosition();
    var url = (state.modeName == 'car'
            ? dotenv.env['CMS_Sidebar_Car'].toString()
            : dotenv.env['CMS_Sidebar_Scooter'].toString().toString()) +
        // '?longitude=${position.longitude}&latitude=${position.latitude}';
        '?longitude=all&latitude=all';
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

      try {
        setState(() {
          stringList = responseBody[0]['content'][0]['text'][0].split('');
          print(stringList);
        });
      } catch (e) {}
    } else {
      print('CMS抓取失敗');
    }
  }

  void setDisplay() {
    int index = 0;
    // 每5秒向後端要求一次CMS資料
    timer2 = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (index < cmsList_car.length) {
        try {
          FlutterTts().speak(cmsList_car[index]['voice']);

          //  FlutterTts().speak('測試');
          controller.animateToPage(
            index,
            duration: Duration(milliseconds: 1000),
            curve: Curves.easeInOut,
          );
        } catch (e) {
          print(e);
        }

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
      width: screenWidth - 150,
      height: screenHeight - 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
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
                  ],
                );
              },
            ),
          ),
        ],
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
                    Container(
                      width: screenHeight,
                      child: Expanded(
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
                crossAxisAlignment: CrossAxisAlignment.center, // 水平方向置中
                children: [
                  Container(
                    width: screenWidth - 150,
                    height: screenHeight - 600,
                    child: Column(
                      children: [
                        Expanded(child: CMS_Content()),
                      ],
                    ),
                  )
                ],
              )),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              color: Colors.green,
              height: screenHeight,
              width: 50,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 300,
                      child: Expanded(
                          child: ListView.builder(
                              itemCount: stringList.length,
                              itemBuilder: (context, index) {
                                final list = stringList[index];
                                return Text(
                                  list,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 40),
                                );
                              })),
                    )
                  ],
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
                      childAspectRatio: 0.01),
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
                                  )),
                            ],
                          ),
                          onTap: () async {
                            EasyLoading.show(status: 'loading...');
                            print(tool['url']);
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
          child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Visibility(
                visible: showIcon,
                child: Column(
                  children: [
                    // FloatingActionButton(
                    //   heroTag: "btn13",
                    //   child: const Icon(
                    //     Icons.picture_in_picture,
                    //     size: 40,
                    //   ),
                    //   backgroundColor: Colors.blueAccent,
                    //   onPressed: () {
                    //     Navigator.push(context,
                    //         MaterialPageRoute(builder: (context) => CMSPIP()));
                    //   },
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
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
                        //顯示導航及最頂端列
                        _stopTrackingPosition(); // 停止追踪位置更新
                        _speedStreamController.close();

                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AllPage()),
                            (router) => false);
                      },
                    ),
                  ],
                )),
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
                //顯示導航及最頂端列
                setState(() {
                  showIcon = showIcon == true ? false : true;
                });
              },
            ),
            SizedBox(
              width: 150,
            ),
          ]),
        ],
      )),
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
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // 垂直方向置中
              crossAxisAlignment: CrossAxisAlignment.center, // 水平方向置中
              children: [
                Container(
                  width: screenWidth - 150,
                  height: 200,
                  child: Column(
                    children: [
                      Expanded(child: CMS_Content2()),
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
            _stopTrackingPosition(); // 停止追踪位置更新
            _speedStreamController.close();
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
