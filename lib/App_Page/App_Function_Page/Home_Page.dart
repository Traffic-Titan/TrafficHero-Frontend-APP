// ignore_for_file: file_names, avoid_unnecessary_containers, prefer_final_fields, sort_child_properties_last, unused_import, library_prefixes, avoid_print, await_only_futures, unused_local_variable, prefer_typing_uninitialized_variables, prefer_const_constructors, deprecated_member_use
import 'package:geocoding/geocoding.dart';
import 'package:traffic_hero/Imports.dart';
import 'package:traffic_hero/Components/Tool.dart' as Tool;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  late stateManager state;
  late var positionNow;
  late String display1, display2;
  late bool _toolList,
      _trafficReport,
      _nearbyStop,
      _operationCondition,
      _operationConditionLight;
        var operationalStatus = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    state = Provider.of<stateManager>(context, listen: false);
    print(state.accountState);
    setState(() {
       operationalStatus = state.OperationalStatus;
    });
   
    ii();
    //依照模式判斷顯示內容
    if (state.modeName == 'car') {
      int index =
          fastLocation.indexWhere((location) => location['value'] == '換電站');
      int index2 =
          fastLocation.indexWhere((location) => location['value'] == '充電站');
      setState(() {
        display1 = "工具列";
        display2 = "路況速報";
        _toolList = true;
        _trafficReport = true;
        _nearbyStop = false;
        _operationCondition = false;
        _operationConditionLight = false;
        if (index != -1) {
          fastLocation.removeAt(index);
          if (index2 == -1) {
            fastLocation.add(Tool.fastLocation_chargingStation);
          }
        }
      });
    } else if (state.modeName == 'scooter') {
      int index =
          fastLocation.indexWhere((location) => location['value'] == '充電站');
      int index2 =
          fastLocation.indexWhere((location) => location['value'] == '換電站');

      setState(() {
        display1 = "工具列";
        display2 = "路況速報";
        _toolList = true;
        _trafficReport = true;
        _nearbyStop = false;
        _operationCondition = false;
        _operationConditionLight = false;
        if (index != -1) {
          fastLocation.removeAt(index);
          if (index2 == -1) {
            fastLocation.add(Tool.fastLocation_batterystop);
          }
        }

        print(fastLocation);
        // fastLocation[1] = _batterystop;
      });
    } else {
      setState(() {
        display1 = "附近站點";
        display2 = "營運狀況";
        _toolList = false;
        _trafficReport = false;
        _nearbyStop = true;
        _operationCondition = true;
        _operationConditionLight = true;
         
      });
    }
  }

  ii() async {
    positionNow = await geolocator().updataPosition();
    List<Placemark> placemarks =
        await placemarkFromCoordinates(positionNow.latitude, positionNow.longitude);
    print((placemarks.isNotEmpty
        ? placemarks[0].administrativeArea.toString()
        : null)!);
  }

   changeColor(color) {
    if (color == 'green') {
      return 'assets/home/light_normal.png';
    } else if (color == 'red') {
      return 'assets/home/light_abnormal.png';
    } else {
      return 'assets/home/light_partialAdnormal.png';
    }
  }

    String splitTextIntoChunks(String text, int chunkSize) {
    List<String> chunks = [];
    for (int i = 0; i < text.length; i += chunkSize) {
      int endIndex = i + chunkSize;
      if (endIndex > text.length) {
        endIndex = text.length;
      }
      chunks.add(text.substring(i, endIndex));
    }

    return chunks.join('\n'); // 使用換行符串起每組文字
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          const Row(
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
                '23°',
                style: TextStyle(
                  fontSize: 80,
                  color: Color.fromRGBO(46, 117, 182, 1),
                ),
              ),
              //今日溫度
              Text('雲林縣斗六市',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromRGBO(46, 117, 182, 1),
                  )),
            ],
          ),
          Visibility(
            visible: !_toolList,
            child: Container(
                width: MediaQuery.of(context).size.width,
                color: const Color.fromRGBO(47, 125, 195, 1),
                child: Text(
                  display1,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
          ),
          Visibility(
            visible: _toolList,
            child: Expanded(
              child: Container(
                  height: 20,
                  color: const Color.fromRGBO(221, 235, 247, 1),
                  // padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: const Color.fromRGBO(47, 125, 195, 1),
                        // decoration: BoxDecoration(
                        //   color: const Color.fromRGBO(47, 125, 195, 1),
                        //   borderRadius: new BorderRadius.circular(20),
                        // ),
                        child: Text(
                          "工具列",
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                        SizedBox(
                          height: 120,
                          child: GridView(
                            padding: EdgeInsets.zero,
                            // scrollDirection: Axis.horizontal,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4, //横轴三个子widget
                                childAspectRatio: 0.95
                            ),
                            children: List.generate(
                              toolList.length,
                              (index) {
                                final tool = toolList[index];
                                return Container(
                                  // height: 30,
                                  child: InkWell(
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 70,
                                          height: 70,
                                          margin: const EdgeInsets.all(3.0),
                                          child: Image.asset(
                                            tool['img'].toString(),
                                          ),
                                        ),
                                        Text(
                                          tool['title'].toString(),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                    onTap: () {
                                      EasyLoading.show(status: 'loading...');
                                      // launch("https://www.google.com/maps/dir/?api=1&destination=%E8%87%BA%E4%B8%AD%E5%B8%82%E7%83%8F%E6%97%A5%E5%8D%80%E6%A6%AE%E6%B3%89%E9%87%8C%E4%B8%AD%E5%B1%B1%E8%B7%AF3%E6%AE%B51165%E8%99%9F&travelmode=driving");
                                      // launch('https://www.google.com/maps/dir/25.1737288,121.4341894/414%E5%8F%B0%E4%B8%AD%E5%B8%82%E7%83%8F%E6%97%A5%E5%8D%80%E4%B8%AD%E5%B1%B1%E8%B7%AF%E4%B8%89%E6%AE%B51165%E8%99%9F/@24.6413693,120.3359623,9z/data=!3m1!4b1!4m9!4m8!1m1!4e1!1m5!1m1!1s0x34693ec40c7103e3:0xcd8e2812aa561111!2m2!1d120.590033!2d24.1133503!11m1!6b1?entry=ttu');
                                      // FlutterTts().speak('限速60公里您已超速');
                                      if (tool['value'] == '路邊停車費') {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LicensePlateInput()));
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => WebView(
                                                    tt: tool['url']
                                                        .toString())));
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: const Color.fromRGBO(47, 125, 195, 1),
                        // decoration: BoxDecoration(
                        //   color: Color.fromRGBO(190, 210, 238, 1),
                        //   borderRadius: new BorderRadius.circular(20),
                        // ),
                        child: Text(
                          "快速尋找地點",
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      Container(
                        height: 100,
                        padding: const EdgeInsets.all(10),
                        // margin: const EdgeInsets.only(bottom: 30),
                        child: GridView(
                          scrollDirection: Axis.horizontal,
                          gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 3 / 2,
                              //按鈕彼此間距
                              mainAxisSpacing: 20),
                          children: List.generate(
                            fastLocation.length,
                                (index) {
                              final fastList = fastLocation[index];
                              return Container(
                                // height: 30,
                                child: InkWell(
                                  child: Column(
                                    children: [
                                      Container(
                                        width:70,
                                        height: 70,
                                        // margin: const EdgeInsets.all(3.0),
                                        child: Image.asset(
                                          fastList['img'].toString(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    launch(fastList['value'].toString());
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ) ,
                      // ),
                    ],
                  )),
            ),
          ),
          Visibility(
            visible: _nearbyStop,
            child: Expanded(
              //附近站點內容
              flex: 6, //附近站點內容
              child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  color: const Color.fromRGBO(221, 235, 247, 1),
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    itemCount: stationList.length,
                    itemBuilder: (context, index) {
                      final stationNews = stationList[index];
                      return ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: const Color.fromRGBO(29, 73, 153, 1)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            '${stationNews["time"].toString()}分',
                            style: const TextStyle(fontSize: 30),
                          ),
                        ),
                        title: Text(
                          stationNews["id"].toString(),
                          style:
                              const TextStyle(fontSize: 20, color: Colors.red),
                        ),
                        subtitle: Text(
                          '往${stationNews["station"].toString()}',
                          style: const TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(29, 73, 153, 1)),
                        ),
                      );
                    },
                  )),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            color: const Color.fromRGBO(47, 125, 195, 1),
            child: Text(
              display2,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          Visibility(
            visible: _trafficReport,
            child: Expanded(
              child: Container(
                color: const Color.fromRGBO(221, 235, 247, 1),
                padding: const EdgeInsets.only(top: 8, left: 8),
                margin: const EdgeInsets.only(bottom: 15),
                child: Row(children: [
                  Image.asset(
                    "assets/roadSign_icon/countyRoad/countyRoad_7.png",
                    height: 80,
                  ),
                  const Expanded(
                    child: Text(
                      "台7線84K+100上邊坡刷坡工程",
                      style: TextStyle(fontSize: 35),
                      softWrap: true,
                    ),
                  ),
                ]),
              ),
            ),
          ),
           Visibility(
            visible: _operationCondition,
            child: Expanded(
              flex: 2,
              child: Container(
                color: const Color.fromRGBO(221, 235, 247, 1),
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(top: 20),
                child: GridView(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 2,
                      mainAxisSpacing: 20),
                  children: List.generate(
                    operationalStatus.length,
                    (index) {
                      final operationNews = operationalStatus[index];
                      return InkWell(
                        child: Column(
                          children: [
                            Container(
                              width: 70,
                              margin: const EdgeInsets.all(3.0),
                              child: Image.asset(
                                changeColor(operationNews["Status"].toString()),
                                height: 40,
                              ),
                            ),
                            Text(
                              splitTextIntoChunks(
                                  operationNews["Name"].toString(), 3), // 每行兩個字
                              style: const TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                        onTap: () {},
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: _operationConditionLight,
            child: Container(
                margin: const EdgeInsets.only(bottom: 15),
                padding: const EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                color: const Color.fromRGBO(193, 219, 241, 1),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/home/light_normal.png",
                      height: 15,
                    ),
                    const Text(
                      " 正常營運  ",
                      style: TextStyle(color: Color.fromRGBO(0, 32, 96, 1)),
                    ),
                    Image.asset("assets/home/light_partialAdnormal.png",
                        height: 15),
                    const Text(
                      " 部分營運  ",
                      style: TextStyle(color: Color.fromRGBO(0, 32, 96, 1)),
                    ),
                    Image.asset(
                      "assets/home/light_abnormal.png",
                      height: 15,
                    ),
                    const Text(
                      " 停止營運",
                      style: TextStyle(color: Color.fromRGBO(0, 32, 96, 1)),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
