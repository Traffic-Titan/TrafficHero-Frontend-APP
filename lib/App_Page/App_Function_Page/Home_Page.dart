// ignore_for_file: file_names, avoid_unnecessary_containers, prefer_final_fields, sort_child_properties_last, unused_import, library_prefixes, avoid_print, await_only_futures, unused_local_variable, prefer_typing_uninitialized_variables, prefer_const_constructors, deprecated_member_use, use_build_context_synchronously

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
  var weather;
  Color colorStatus = Colors.green;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    state = Provider.of<stateManager>(context, listen: false);
    print(state.accountState);
    print(state.OperationalStatus);
    setState(() {
      weather = state.weather;
      operationalStatus = state.OperationalStatus;
    });

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

  changeColor(color) {
    if (color == 'green') {
      return Colors.green;
    } else if (color == 'red') {
      return Colors.red;
    } else if (color == 'yellow') {
      return Colors.yellow;
    }
  }

  goLicensePlateInput() async {
    EasyLoading.show(status: '查詢中...');
    var licensePlate;
    var response;
    var url = dotenv.env['Vehicle'];
    var jwt = ',${state.accountState}';
    try {
      response = await api().apiGet(url, jwt);
    } catch (e) {
      print(e);
    }
    var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      licensePlate = responseBody['vehicle'];
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => LicensePlateInput(vehicle: licensePlate,)));
    }
  }

  findPlacesQuickly(url) async {
    var position = await geolocator().updataPosition();
    var urlPosition =
        url + '?longitude=${position.longitude}&latitude=${position.latitude}';
    var jwt = ',${state.accountState}';

    var response = await api().apiGet(urlPosition, jwt);
    print(jsonDecode(utf8.decode(response.bodyBytes)));
    var res = jsonDecode(utf8.decode(response.bodyBytes))['url'];
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      try{
        await launch(res);
      }catch(e){
        print(e.toString());
        EasyLoading.showError(e.toString());
      }
    } else {
      EasyLoading.dismiss();
      print(jsonDecode(utf8.decode(response.bodyBytes)));
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
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebView(tt: weather['url'])));
            },
            child: SizedBox(
              height: 100,
              width: 600,
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${weather['temperature']}°',
                          style: TextStyle(
                            fontSize: 75,
                            color: Color.fromRGBO(46, 117, 182, 1),
                          ),
                        ),
                        //今日溫度
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(weather['area'].toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromRGBO(46, 117, 182, 1),
                                )),
                            Row(
                              children: [
                                Text(
                                  '最高 ${weather['the_highest_temperature']}°',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromRGBO(46, 117, 182, 1),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '最低 ${weather['the_lowest_temperature']}°',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromRGBO(46, 117, 182, 1),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.network(
                              weather['weather_icon_url'].toString(),
                              height: 100,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
            child: Container(
              height: 300,
              color: const Color.fromRGBO(221, 235, 247, 1),
              // padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.only(bottom: 20),
              child: Expanded(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: const Color.fromRGBO(47, 125, 195, 1),
                      child: Text(
                        "工具列",
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 110,
                      child: GridView(
                        padding: EdgeInsets.zero,
                        // scrollDirection: Axis.horizontal,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4, //横轴三个子widget
                            childAspectRatio: 0.01),
                        children: List.generate(
                          toolList.length,
                          (index) {
                            final tool = toolList[index];
                            return SizedBox(
                              height: 70,
                              child: Expanded(
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
                                  onTap: () async {
                                    EasyLoading.show(status: 'loading...');
                                    if (tool['value'] == '路邊停車費') {
                                      await goLicensePlateInput();
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => WebView(
                                                  tt: tool['url'].toString())));
                                    }
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: const Color.fromRGBO(47, 125, 195, 1),
                      child: Text(
                        "快速尋找地點",
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    SizedBox(
                      height: 130,
                      child: GridView(
                        padding: EdgeInsets.zero,
                        // scrollDirection: Axis.horizontal,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4, //横轴三个子widget
                            childAspectRatio: 0.01),
                        children: List.generate(
                          fastLocation.length,
                          (index) {
                            final fastList = fastLocation[index];
                            return SizedBox(
                              height: 70,
                              child: Expanded(
                                child: InkWell(
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 85,
                                        height: 85,
                                        margin: const EdgeInsets.all(3.0),
                                        child: Image.asset(
                                          fastList['img'].toString(),
                                        ),
                                      ),
                                      // Text(
                                      //   tool['title'].toString(),
                                      //   textAlign: TextAlign.center,
                                      // )
                                    ],
                                  ),
                                  onTap: () {
                                    EasyLoading.show(status: 'loading...');
                                    print(fastList['url']);
                                    findPlacesQuickly(fastList['url']);
                                    // launch(fastList['value'].toString());
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    // ),
                  ],
                ),
              ),
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
                      return Expanded(
                          child: Column(
                        children: [
                          Container(
                              width: 40,
                              height: 40,
                              margin: const EdgeInsets.all(3.0),
                              child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: changeColor(
                                            operationNews["status"]),
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                  ))),
                          Text(
                            splitTextIntoChunks(
                                operationNews["name"].toString(), 3), // 每行兩個字
                            style: const TextStyle(fontSize: 20),
                          )
                        ],
                      ));
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
