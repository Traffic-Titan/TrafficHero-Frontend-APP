// ignore_for_file: file_names, sort_child_properties_last, avoid_print, avoid_unnecessary_containers
import 'package:traffic_hero/Imports.dart';

class CMS extends StatefulWidget {
  const CMS({super.key});

  @override
  State<CMS> createState() => _CMSState();
}

class _CMSState extends State<CMS> {
  late stateManager state;
  late Icon phoneIcon = const Icon(
    CupertinoIcons.device_phone_landscape,
    size: 40,
  );
  bool directionState = true;
  String displayText = '';
  String displayImg = 'assets/topbar/Mode_Car.png';
  Timer? timer;

//當頁面創造時執行
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
  }

  @override
  void initState() {
    super.initState();
    setDisplay();
  }

  void setDisplay() {
    int index = 0;
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (index < cmsList.length) {
        final cmsNews = cmsList[index];
        try {

            setState(() {
              displayText = cmsNews['title'].toString();
              displayImg = cmsNews['img'].toString();
            });

        } catch (e) {
          print(e);
        }

        index++;
      } else {
        index = 0;
      }
    });
  }

  void setDirection() {
    if (directionState) {
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
    } else {
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
    }
  }

  @override
  Widget build(BuildContext context) {
    //隱藏導航及最頂端列
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return Scaffold(
      appBar: AppBar(
        leading: const Text(''),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const Expanded(
            //時速表
            child: Text(
              "65km/h",
              style: TextStyle(fontSize: 80, color: Colors.yellow),
              textAlign: TextAlign.right,
            ),
          ),
          Expanded(
              //CMS
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                          mainAxisAlignment: MainAxisAlignment.center, // 垂直方向置中
                          crossAxisAlignment: CrossAxisAlignment.center, // 水平方向置中
                          children: [
                
                Image.asset(
                  displayImg ,
                  height: 80,
                ),
                Text(
                  displayText,
                  style: const TextStyle(fontSize: 35, color: Colors.red),
                  softWrap: true,
                ),
                          ],
                        ),
              )),
          Expanded(
            // flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start, // 垂直方向
              crossAxisAlignment: CrossAxisAlignment.end, // 水平方向
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
      floatingActionButton: Container(
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          heroTag: "btn1",
          child: const Icon(
            CupertinoIcons.placemark_fill,
            size: 40,
          ),
          backgroundColor: Colors.blueAccent,
          onPressed: () {},
        ),
        const SizedBox(
          height: 10,
        ),
        FloatingActionButton(
          heroTag: "btn2",
          child: phoneIcon,
          backgroundColor: Colors.blueAccent,
          onPressed: () {
            setDirection();
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
            if (!directionState) {
              setDirection();
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
