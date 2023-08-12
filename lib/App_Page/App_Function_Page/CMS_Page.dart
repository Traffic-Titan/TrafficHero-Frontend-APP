
// ignore_for_file: file_names

import 'package:traffic_hero/Imports.dart';

class CMS extends StatefulWidget {
  const CMS({Key? key}) : super(key: key);

  @override
  State<CMS> createState() => _CMSState();
}

class _CMSState extends State<CMS> {
  late stateManager state;
  late Icon phoneIcon = const Icon(CupertinoIcons.device_phone_landscape, size: 40);
  bool directionState = true;
  String displayText = '';
  String displayImg = '';
  Timer? timer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top,
    ]);
  }

  @override
  void initState() {
    super.initState();
    setDisplay();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void setDisplay() {
    int index = 0;
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (index < cmsList.length) {
        final cmsNews = cmsList[index];
        setState(() {
          displayText = cmsNews['title'].toString();
          displayImg = cmsNews['img'].toString();
        });
        index++;
      } else {
        index = 0;
      }
    });
  }

  void setDirection() {
    if (directionState) {
      // 設置橫向
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      setState(() {
        phoneIcon = const Icon(CupertinoIcons.device_phone_portrait, size: 40);
        directionState = false;
      });
    } else {
      // 設置垂直
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      setState(() {
        phoneIcon = const Icon(CupertinoIcons.device_phone_landscape, size: 40);
        directionState = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Text("65km/h", style: TextStyle(fontSize: 80, color: Colors.yellow), textAlign: TextAlign.right),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  displayImg,
                  height: 80,
                ),
                Text(
                  displayText,
                  style: TextStyle(fontSize: 35, color: Colors.red),
                  softWrap: true,
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(
                fastLocation.length,
                (index) {
                  final fastList = fastLocation[index];
                  return InkWell(
                    child: Container(
                      width: 50,
                      margin: const EdgeInsets.all(3.0),
                      child: Image.asset(
                        fastList['img'].toString(),
                      ),
                    ),
                    onTap: () {
                      print(fastList['value'].toString());
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: Icon(CupertinoIcons.placemark_fill, size: 40),
            backgroundColor: Colors.blueAccent,
            onPressed: () {},
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            child: phoneIcon,
            backgroundColor: Colors.blueAccent,
            onPressed: setDirection,
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            child: Icon(Icons.output_outlined, size: 40),
            backgroundColor: Colors.blueAccent,
            onPressed: () {
              if (!directionState) {
                setDirection();
              }
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
