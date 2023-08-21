// ignore_for_file: file_names
import 'package:traffic_hero/imports.dart';

class CMS extends StatefulWidget {
  const CMS({super.key});

  @override
  State<CMS> createState() => _CMSState();
}

class _CMSState extends State<CMS> {
  late stateManager state;
  late Icon phoneIcon = const Icon(CupertinoIcons.device_phone_landscape,size: 40,);
  bool directionState = true;
  String displayText='';
  String displayImg='assets/fastLocation/transparent.png';
  Timer? timer;

//當頁面創造時執行
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top
    ]);
  }
  @override
  void initState() {
    super.initState();
    setDisplay();
  }
  void setDisplay(){
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

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      if(directionState){
        //設置垂直
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        setState(() {
          phoneIcon = const Icon(CupertinoIcons.device_phone_landscape,size: 40,);
          directionState = true;
        });
        return straightPage(context);
      }else{
        //設置橫向
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
        setState(() {
          phoneIcon = const Icon(CupertinoIcons.device_phone_portrait,size: 40,);
          directionState = false;
        });
        return horizontalPage(context);
      }
  }

  @override
  Widget straightPage(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const Expanded(
            //時速表
            child:Text("65km/h",style: TextStyle(fontSize: 80,color: Colors.yellow) , textAlign: TextAlign.right, ),
          ),
          Expanded(
            //CMS
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // 垂直方向置中
                crossAxisAlignment: CrossAxisAlignment.center,// 水平方向置中
                  children: [
                    Image.asset(
                      displayImg,
                      height: 80,
                    ),
                    Padding(//與螢幕距離
                      padding: EdgeInsets.all(8.0),
                      child:Text(
                        displayText,
                        style: TextStyle(fontSize: 35,color: Colors.red,),
                        textAlign: TextAlign.center,
                        softWrap: true,
                      ),
                    ),
              ],
            )
          ),
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
                      child:
                      Container(
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
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  child: Icon(CupertinoIcons.placemark_fill,size: 40,),
                  backgroundColor: Colors.blueAccent,
                  onPressed: () {
                  },
                ),
                const SizedBox(height: 10,),
                FloatingActionButton(
                  child: phoneIcon,
                  backgroundColor: Colors.blueAccent,
                  onPressed: () {
                    directionState=false;
                  },
                ),
                const SizedBox(height: 10,),
                FloatingActionButton(
                  child: Icon(Icons.output_outlined,size: 40,),
                  backgroundColor: Colors.blueAccent,
                  onPressed: () {
                    //顯示導航及最頂端列
                    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
                    Navigator.pop(context);
                  },
                )
              ]
          )
      ),
    );
  }

  Widget horizontalPage(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const Expanded(
            //時速表
            child:Text("75km/h",style: TextStyle(fontSize: 80,color: Colors.yellow) , textAlign: TextAlign.right, ),
          ),
          Expanded(
            //CMS
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, // 垂直方向置中
                crossAxisAlignment: CrossAxisAlignment.center, // 水平方向置中
                children: [
                  Image.asset(
                    displayImg,
                    height: 100,
                  ),
                  SizedBox(width: 20,),
                  Text(
                    displayText,
                    style: TextStyle(fontSize: 50,color: Colors.red),
                    softWrap: true,
                  ),
                ],
              )
          ),
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
                    child:
                    Container(
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
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  child: Icon(CupertinoIcons.placemark_fill,size: 40,),
                  backgroundColor: Colors.blueAccent,
                  onPressed: () {
                  },
                ),
                const SizedBox(height: 10,),
                FloatingActionButton(
                  child: phoneIcon,
                  backgroundColor: Colors.blueAccent,
                  onPressed: () {
                    directionState=true;
                  },
                ),
                const SizedBox(height: 10,),
                FloatingActionButton(
                  child: Icon(Icons.output_outlined,size: 40,),
                  backgroundColor: Colors.blueAccent,
                  onPressed: () {
                    if(!directionState){
                      //設置垂直
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
              ]
          )
      ),
    );
  }
}