// ignore_for_file: file_names, sort_child_properties_last, unused_element, unused_local_variable, override_on_non_overriding_member, prefer_typing_uninitialized_variables, avoid_print, duplicate_ignore, avoid_unnecessary_containers
import 'package:traffic_hero/Imports.dart';
import 'package:geocoding/geocoding.dart';

class CMS extends StatefulWidget {
  const CMS({super.key});

  @override
  State<CMS> createState() => _CMSState();
}

class _CMSState extends State<CMS> {
    var screenWidth;
  var cmsList_car = [];
  late stateManager state;
  late SharedPreferences prefs;

  late Icon phoneIcon = const Icon(
    CupertinoIcons.device_phone_landscape,
    size: 40,
  );

  @override
  void initState() {
    super.initState();
    FlPiP().status.addListener(listener);
    setDisplay();
  }

  void listener() {
    if (FlPiP().status.value == PiPStatus.enabled) {
      FlPiP().toggle(AppState.background);
    }
  }

  @override
  void dispose() {
    super.dispose();
    FlPiP().status.removeListener(listener);
    _stopTrackingPosition(); // 停止追踪位置更新
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
  String displayImg =
      'https://www.colorhexa.com/000000.png';
  Timer? timer;
  StreamSubscription<Position>? _positionStreamSubscription;
  late List<Placemark> placemarks;
  var positionNow;
  String speed = '0';
  var fontSize ;

//當頁面創造時執行
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    prefs = await SharedPreferences.getInstance();
    state = Provider.of<stateManager>(context, listen: false);
        screenWidth = MediaQuery.of(context).size.width;
        fontSize = screenWidth * 0.05;
    _startTrackingPosition();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    updateCMSList_Car();
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
      EasyLoading.showError(e.toString());
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
    var url = dotenv.env['CMS_Car'];
    var jwt = ',${state.accountState}';
    var response;
    try {
      response = await api().apiGet(url, jwt);
    } catch (e) {
      print(e);
    }

    var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      state.updateCMSList_Car(responseBody);
      cmsList_car = responseBody;
    }
  }

  void setDisplay() {
    int index = 0;
    // 每5秒向後端要求一次CMS資料
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (index < cmsList_car.length) {
        final cmsNews = cmsList_car[index];
        setState(() {
          displayText1 = cmsNews['main_content'][0][0][0].toString();
          Text1Color = cmsNews['main_color'][0][0][0].toString();

          displayText2 = cmsNews['main_content'][1][0][0].toString();
          Text2Color = cmsNews['main_color'][1][0][0];

          displayText3 = cmsNews['main_content'][1][1][0].toString();
          Text3Color = cmsNews['main_color'][1][1][0];

          displayImg = cmsNews['icon'].toString();
          try {
            displayText4 = '';
            displayText5 = '';
            displayText6 = '';
            Text4Color = 'FFFFFFFF';
            if (cmsNews['main_content'][2][0][0] != null) {
              displayText4 = cmsNews['main_content'][2][0][0];
              Text4Color = cmsNews['main_color'][2][0][0];
              if (cmsNews['main_content'][2][1][0] != null) {
                displayText5 = cmsNews['main_content'][2][1][0];
                Text5Color = cmsNews['main_color'][2][1][0];
              }
              if (cmsNews['main_content'][2][2][0] != null) {
                displayText6 = cmsNews['main_content'][2][2][0];
                Text6Color = cmsNews['main_color'][2][2][0];
              }
            }
          } catch (e) {
            //print(e);
          }
        });
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
      body: Column(
        children: [
          Expanded(
            flex: 2,
            //時速表
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  speed,
                  style: const TextStyle(fontSize: 80, color: Colors.yellow),
                  textAlign: TextAlign.right,
                ),
                const Text('km/h',
                    style: TextStyle(fontSize: 30, color: Colors.yellow),
                    textAlign: TextAlign.right)
              ],
            ),
          ),
          Expanded(
              flex: 8,
              //CMS
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // 垂直方向置中
                crossAxisAlignment: CrossAxisAlignment.center, // 水平方向置中
                children: [
                  Image.network(
                    displayImg,
                    height: 80,
                  ),
                  Text(
                    displayText1,
                    style: TextStyle(
                      fontSize: fontSize,
                      color: HexColor(Text1Color),
                    ),
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        displayText2,
                        style: TextStyle(
                          fontSize: fontSize,
                          color: HexColor(Text2Color),
                        ),
                        softWrap: true,
                      ),
                      Text(
                        displayText3,
                        style: TextStyle(
                          fontSize: fontSize,
                          color: HexColor(Text3Color),
                        ),
                        softWrap: true,
                      ),
                    ],
                  ),
                  Text(
                    displayText4,
                    style: TextStyle(
                      fontSize: fontSize,
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
                      fontSize: fontSize,
                      color: HexColor(Text6Color),
                    ),
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                ],
              )),
        ],
      ),
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
          context,
          MaterialPageRoute(
              builder: (context) =>CMSPIP()));
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start, // 垂直方向置中
        crossAxisAlignment: CrossAxisAlignment.center, // 水平方向置中
        children: [
          Expanded(
            
            //時速表
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  speed,
                  style: const TextStyle(fontSize: 80, color: Colors.yellow),
                  textAlign: TextAlign.right,
                ),
                const Text('km/h',
                    style: TextStyle(fontSize: 30, color: Colors.yellow),
                    textAlign: TextAlign.right)
              ],
            ),
          ),
          Expanded(
              //CMS
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, // 垂直方向置中
                crossAxisAlignment: CrossAxisAlignment.start, // 水平方向置中
                children: [
                  Image.network(
                    displayImg,
                    height: 80,
                  ),
                  SizedBox(width: 10,),
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
                  ],),

                 
                  
           
                ],
              )),
        ],
      ),
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
        )
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
