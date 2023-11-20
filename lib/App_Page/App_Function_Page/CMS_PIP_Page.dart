import 'package:traffic_hero/Imports.dart';

class CMSPIP extends StatefulWidget {
  const CMSPIP({Key? key}) : super(key: key);

  @override
  State<CMSPIP> createState() => _CMSPIPState();
}

class _CMSPIPState extends State<CMSPIP> {
  late stateManager state;
  late SharedPreferences prefs;
  var screenWidth;
  var screenHeight;
  var cmsListCar = [];
  var fontSize;

  bool directionState = true;
  var test;
  var carPositionStatus = false;
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
    // updateCMSListCar();

    setDisplay();
  }

  @override
  void initState() {
    super.initState();
    FlPiP().status.addListener(listener);

    FlPiP().enable(
      ios: const FlPiPiOSConfig(
        enablePlayback: true,
        enableControls: true,
        path: 'assets/landscape.mp4',
        packageName: null,
      ),
      android: const FlPiPAndroidConfig(aspectRatio: Rational.maxLandscape()),
    );
    print(FlPiP().status);
    // FlPiP().toggle(AppState.background);
    listener();
  }

  void listener() {
    print(FlPiP().status);
    if (FlPiP().status.value == PiPStatus.enabled) {
      print(FlPiP().status.value);
      print('1');
      FlPiP().toggle(AppState.background);
    } else {
      print(FlPiP().status.value);
      print('2');
      FlPiP().toggle(AppState.foreground);
    }
  }

  void updateCMSListCar() async {
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
      cmsListCar = responseBody;
      print(cmsListCar);
    }
  }

  @override
  void dispose() {
    super.dispose();
    FlPiP().status.removeListener(listener);
    timer?.cancel(); // 取消計時器以避免內存洩漏
  }

  void setDisplay() {
    int index = 0;

    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (index < 100) {
        setState(() {
          test = index;
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
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    test.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
