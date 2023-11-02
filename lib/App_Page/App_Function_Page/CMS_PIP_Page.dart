import 'package:traffic_hero/Imports.dart';

class CMSPIP extends StatefulWidget {
  const CMSPIP({super.key});

  @override
  State<CMSPIP> createState() => _CMSPIPState();
}

class _CMSPIPState extends State<CMSPIP> {
  late stateManager state;
  late SharedPreferences prefs;
  var screenWidth;
  var screenHeight;
  var cmsList_car = [];
  var fontSize;

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

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    prefs = await SharedPreferences.getInstance();
    state = Provider.of<stateManager>(context, listen: false);
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    fontSize = screenWidth * 0.05;
    updateCMSList_Car();
  }

  @override
  void initState() {
    super.initState();
     setDisplay();
    FlPiP().status.addListener(listener);
    FlPiP().enable(
        ios: const FlPiPiOSConfig(
            path: 'assets/landscape.mp4', packageName: null),
        android:
            const FlPiPAndroidConfig(aspectRatio: Rational.maxLandscape()));
  }

  void listener() {
    if (FlPiP().status.value == PiPStatus.enabled) {
      FlPiP().toggle(AppState.background);
    }
  }



   void updateCMSList_Car() async {
    // 讀取API上即時訊息推播-汽車模式
    print('開始抓取ＣＭＳ');
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
       print('抓取ＣＭＳ成功');
      state.updateCMSList_Car(responseBody);
      cmsList_car = responseBody;
      print(cmsList_car);
    }
  }

  @override
  void dispose() {
    super.dispose();
    FlPiP().status.removeListener(listener);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
     
        body: Center(
          child: Center(
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
                  mainAxisAlignment: MainAxisAlignment.center, // 垂直方向置中
                  crossAxisAlignment: CrossAxisAlignment.center, // 水平方向置中
                  children: [
                   
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
         
         
        ],
      )),
        ));
  }
}


//回家做