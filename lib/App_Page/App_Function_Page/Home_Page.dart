// ignore_for_file: file_names, avoid_unnecessary_containers, prefer_final_fields
import 'package:traffic_hero/Imports.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  late stateManager state;
  late String display1, display2;
  late bool _toolList,
      _trafficReport,
      _nearbyStop,
      _operationCondition,
      _operationConditionLight;


  Map<String, String> _chargingStation = {
    'value': '充電站',
    'title': '充電站',
    'img': 'assets/home/chargingStation.png',
    'url': '後端API'
  };
  Map<String, String> _batterystop = {
    'value': '換電站',
    'title': '換電站',
    'img': 'assets/home/batterystop.png',
    'url': '後端API'
  };

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
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
            fastLocation.add(_chargingStation);
          }
        }

        // fastLocation[1] = _chargingStation;
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
            fastLocation.add(_batterystop);
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
          Container(
            width: MediaQuery.of(context).size.width,
            color: const Color.fromRGBO(47, 125, 195, 1),
            child: Text(
              display1,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          Visibility(
            visible: _toolList,
            child: Expanded(
              child: Container(
                  color: const Color.fromRGBO(221, 235, 247, 1),
                  padding: const EdgeInsets.only(top: 8, left: 8),
                  margin: const EdgeInsets.only(bottom: 15),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 5,
                        child: GridView(
                          scrollDirection: Axis.horizontal,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 3 / 2,
                                  mainAxisSpacing: 20),
                          children: List.generate(
                            toolList.length,
                            (index) {
                              final tool = toolList[index];
                              return InkWell(
                                child: Column(
                                  children: [
                                    Container(
                                      width: 70,
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
                                  print(tool['value'].toString());
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: Text(
                          "快速尋找地點",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color.fromRGBO(0, 32, 96, 1)),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: GridView(
                          scrollDirection: Axis.horizontal,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 3 / 2,
                                  mainAxisSpacing: 20),
                          children: List.generate(
                            fastLocation.length,
                            (index) {
                              final fastList = fastLocation[index];
                              return InkWell(
                                child: Column(
                                  children: [
                                    Container(
                                      width: 70,
                                      margin: const EdgeInsets.all(3.0),
                                      child: Image.asset(
                                        fastList['img'].toString(),
                                      ),
                                    ),
                                    Text(
                                      fastList['title'].toString(),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
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
                    operationList.length,
                    (index) {
                      final operationNews = operationList[index];
                      return InkWell(
                        child: Column(
                          children: [
                            Container(
                              width: 70,
                              margin: const EdgeInsets.all(3.0),
                              child: Image.asset(
                                operationNews["state"].toString(),
                                height: 30,
                              ),
                            ),
                            Text(
                              operationNews["type"].toString(),
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        onTap: () {
                          print(operationNews["url"].toString());
                        },
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
                      "正常行駛  ",
                      style: TextStyle(color: Color.fromRGBO(0, 32, 96, 1)),
                    ),
                    Image.asset("assets/home/light_partialAdnormal.png",
                        height: 15),
                    const Text(
                      "部分行駛  ",
                      style: TextStyle(color: Color.fromRGBO(0, 32, 96, 1)),
                    ),
                    Image.asset(
                      "assets/home/light_abnormal.png",
                      height: 15,
                    ),
                    const Text(
                      "全部行駛",
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
