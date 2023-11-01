// ignore_for_file: file_names, avoid_unnecessary_containers, prefer_final_fields, sort_child_properties_last, unused_import, library_prefixes, avoid_print, await_only_futures, unused_local_variable, prefer_typing_uninitialized_variables, prefer_const_constructors, deprecated_member_use, use_build_context_synchronously, unused_field, unnecessary_null_comparison
import 'package:geocoding/geocoding.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:traffic_hero/Imports.dart';
import 'package:traffic_hero/Components/Tool.dart' as Tool;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> with SingleTickerProviderStateMixin {
  late stateManager state;
  late SharedPreferences prefs;
  late var positionNow;
  var carMode = false;
  var scooterMode = false;
  var publicTransportMode = false;
  var operationalStatus;
  var weather;
  var stationNearby;
  var homePageModel;
  var screenWidth;
  var fastTool;
  
  var nearbyRoadCondition;
  late AnimationController controller;
  var count = 0;
  var nearbyStationBus, nearbyStationBike, nearbyStationTrain;
  var second = 1;
  var trafficWarningWidgetCount;
   int currentIndex = 0;
  Timer? timers;
  var countss = 0;
   var secondroad = 2;
  final PageController _controller = PageController();

  Timer? timerBus, timerBike, timerTrain, timer,trafficWarningWidgettimer;
  Timer? counter;
  bool _timer = true;
  int timeCount = 1;



  @override
  void dispose() {
    super.dispose();
   
      stoptimer();
      trafficWarningWidgettimerStop();
   
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    EasyLoading.dismiss();
    startTimer();
    screenWidth = MediaQuery.of(context).size.width;
    state = Provider.of<stateManager>(context, listen: false);
    setState(() {
      weather = state.weather;
      nearbyRoadCondition = state.NearbyRoadCondition;
      operationalStatus = state.OperationalStatus;
      nearbyStationBus = state.nearbyStationBus;
      nearbyStationBike = state.nearbyStationBike;
      nearbyStationTrain = state.nearbyStationTrain;
    });
    //依照模式判斷顯示內容
    if (state.modeName == 'car') {
      stoptimer();
      startTimer();
     
      setState(() {
        fastTool = Tool.fastLocationCar;
        carMode = true;
        scooterMode = false;
        publicTransportMode = false;
        timeCount = 1;
      });
    } else if (state.modeName == 'scooter') {
      stoptimer();
      startTimer();

      setState(() {
        carMode = false;
        scooterMode = true;
        publicTransportMode = false;
        timeCount = 1;
      });
    } else {
      stoptimer();
      startTimer();
      setState(() {
        carMode = false;
        scooterMode = false;
        publicTransportMode = true;
        timeCount = 1;
      });
    }

    state.changePositionNow(await geolocator().updataPosition());
    prefs = await SharedPreferences.getInstance();
  }

  changeMode(mode) {
    if (mode == 'car') {
      return 'Car';
    } else if (mode == 'scooter') {
      return 'Scooter';
    }
  }

  void initState() {
    timerBus?.cancel();
     
    super.initState();


  }

  //修改大眾運輸頁面營運通組顏色
  changeColor(color) {
    if (color == 'green') {
      return Colors.green;
    } else if (color == 'red') {
      return Colors.red;
    } else if (color == 'yellow') {
      return Colors.yellow;
    }
  }

  //跳轉停車費頁面
  goLicensePlateInput() async {
    EasyLoading.show(status: '查詢中...');
    var licensePlate = [];
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
      licensePlate = responseBody['vehicle'] ?? [];
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LicensePlateInput(
                    vehicle: licensePlate,
                  )));
    }
  }

  //快速尋找地點
  findPlacesQuickly(url) async {
    var position = await geolocator().updataPosition();
    var urlPosition = url +
        '?os=${prefs.get('system')}&mode=${changeMode(state.modeName)}&latitude=${position.latitude}&longitude=${position.longitude}';

    print(urlPosition);
    var jwt = ',${state.accountState}';

    var response = await api().apiGet(urlPosition, jwt);
    var res = jsonDecode(utf8.decode(response.bodyBytes))['url'];
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

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) async {
      try {
        setState(() {
          print(second);
          second--;
        });
      } catch (e) {
        try {
          setState(() {
            second = 2;
          });
          stoptimer();
          startTimer();
        } catch (e) {}
      }

      if (second == 0) {
        stoptimer();
        try {
          await getHome().getWeather(context);
          update();
          await getHome().getUser(context);
          update();
          await getHome().getOperationalStatus(context);
          update();
          await getHome().stationNearbySearchTrain(context);
          update();
          await getHome().stationNearbySearchBus(context);
          update();
          await getHome().stationNearbySearchBike(context);
          update();
          await getHome().getNearbyRoadCondition(context);
          update();
          setState(() {
            second = 15;
          });
          startTimer();
        } catch (e) {
          try {
          setState(() {
            second = 15;
          });
          stoptimer();
          startTimer();
        } catch (e) {}
        }
      }
    });
  }




  int trafficWarningWidgetTimer(list) {
  var count = 0;
  trafficWarningWidgettimer = Timer.periodic(Duration(seconds: 1), (timer) {
    if (count == list.length) {
      setState(() {
        count = 0;
      });
     
    } else {
      setState(() {
        countss ++;
      });
    
    }
  });
  return count;
}


  void stoptimer() {
    timer?.cancel();
  }

void trafficWarningWidgettimerStop(){
  trafficWarningWidgettimer?.cancel();
}
  void update() async {
    try {
      setState(() {
        nearbyStationBus = state.nearbyStationBus;
        nearbyRoadCondition = state.NearbyRoadCondition;
        nearbyStationBike = state.nearbyStationBike;
        nearbyStationTrain = state.nearbyStationTrain;
        weather = state.weather;
        operationalStatus = state.OperationalStatus;
      });
      print('update finish');
    } catch (e) {
      second = 15;
      startTimer();
    }
  }

//頁面組件
  //天氣widget
  Widget weatherWidget() {
    return InkWell(
      child: SizedBox(
        width: screenWidth - 30 > 600 ? 600 : screenWidth - 30,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  weather['temperature'].toString() + '°',
                  style: TextStyle(
                    fontSize: screenWidth - 30 > 600 ? 80 : screenWidth * 0.18,
                    color: Color.fromRGBO(67, 150, 200, 1),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                //今日溫度
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(weather['area'].toString(),
                        style: TextStyle(
                          fontSize:
                              screenWidth - 30 > 600 ? 27 : screenWidth * 0.054,
                          color: Color.fromRGBO(67, 150, 200, 1),
                        )),
                    Row(
                      children: [
                        Text(
                          '最高 ${weather['the_highest_temperature']}°',
                          style: TextStyle(
                            fontSize: screenWidth - 30 > 600
                                ? 20
                                : screenWidth * 0.04,
                            color: Color.fromRGBO(67, 150, 200, 1),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '最低 ${weather['the_lowest_temperature']}°',
                          style: TextStyle(
                            fontSize: screenWidth - 30 > 600
                                ? 20
                                : screenWidth * 0.04,
                            color: Color.fromRGBO(67, 150, 200, 1),
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
                      width: screenWidth - 30 > 600 ? 170 : screenWidth * 0.25,
                      height: screenWidth - 30 > 600 ? 170 : screenWidth * 0.25,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
      onTap: () {
         
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebView(tt: state.weather['url'])));
      },
    );
  }




  //工具列widget
  Widget toolWidget() {
    return Card(
      color: Color.fromARGB(255, 255, 255, 255),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
      ),
      elevation: 1,
      child: SizedBox(
        height: 250,
        width: screenWidth - 30 > 600 ? 600 : screenWidth - 30,
        child: Column(children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14.0),
              topRight: Radius.circular(14.0),
            ),
            child: Container(
              height: 30,
              color: Color.fromRGBO(67, 150, 200, 1),
              child: Center(
                child: Text(
                  '工具列',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: screenWidth - 30 > 600 ? 600 : screenWidth - 30,
              height: 95,
              child: PageView(
                controller: _controller,
                children: <Widget>[
                  GridView(
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, childAspectRatio: 0.01),
                    children: List.generate(
                      toolList.length,
                      (index) {
                        final tool = toolList[index];
                        return SizedBox(
                          height: 70,
                          child: InkWell(
                            child: Column(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
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
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 30,
            color: Color.fromRGBO(67, 150, 200, 1),
            child: Center(
              child: Text(
                '快速尋找地點',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: screenWidth - 30 > 600 ? 600 : screenWidth - 30,
              height: 95,
              child: PageView(
                controller: _controller,
                children: <Widget>[
                  GridView(
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, //横轴三个子widget
                        childAspectRatio: 0.01),
                    children: List.generate(
                      Tool.fastLocationCar.length,
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
                              findPlacesQuickly(tool['url']);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  //工具列widget
  Widget toolScooterWidget() {
    return Card(
      color: Color.fromARGB(255, 255, 255, 255),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
      ),
      elevation: 1,
      child: SizedBox(
        height: 250,
        width: screenWidth - 30 > 600 ? 600 : screenWidth - 30,
        child: Column(children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14.0),
              topRight: Radius.circular(14.0),
            ),
            child: Container(
              height: 30,
              color: Color.fromRGBO(67, 150, 200, 1),
              child: Center(
                child: Text(
                  '工具列',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: screenWidth - 30 > 600 ? 600 : screenWidth - 30,
              height: 95,
              child: PageView(
                controller: _controller,
                children: <Widget>[
                  GridView(
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, childAspectRatio: 0.01),
                    children: List.generate(
                      toolList.length,
                      (index) {
                        final tool = toolList[index];
                        return SizedBox(
                          height: 70,
                          child: InkWell(
                            child: Column(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
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
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 30,
            color: Color.fromRGBO(67, 150, 200, 1),
            child: Center(
              child: Text(
                '快速尋找地點',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: screenWidth - 30 > 600 ? 600 : screenWidth - 30,
              height: 95,
              child: PageView(
                controller: _controller,
                children: <Widget>[
                  GridView(
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, //横轴三个子widget
                        childAspectRatio: 0.01),
                    children: List.generate(
                      Tool.fastLocationScooter.length,
                      (index) {
                        final tool = Tool.fastLocationScooter[index];
                        return SizedBox(
                          height: 70,
                          child: InkWell(
                            child: Column(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
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
                              findPlacesQuickly(tool['url']);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }


  len(list){
    var count = list.length;
    var start = 0;
    for(var i = 0;i<list.length;i++){
      return i;
    }
  }

  //路況速報
  Widget trafficWarningWidget() {
    return Card(
      color: Color.fromARGB(255, 255, 255, 255),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
      ),
      elevation: 1,
      child: SizedBox(
          height: 240 + 30,
          width: screenWidth - 30 > 600 ? 600 : screenWidth - 30,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14.0),
                  topRight: Radius.circular(14.0),
                ),
                child: Container(
                  height: 30,
                  color: Color.fromRGBO(67, 150, 200, 1),
                  child: Center(
                    child: Text(
                      '路況速報',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
              SizedBox(
                  height: 220,
                  child: ListView.builder(
                      itemCount: nearbyRoadCondition.length,
                      itemBuilder: (context, index) {
                        var list = nearbyRoadCondition[index];
                        return Column(
                          children: [
                            ListTile(
                              title: Text(
                                list['road_name'],
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            ListTile(
                              title:
                                  Column(children: [Text(list['content'][countss])]),
                            )
                          ],
                        );
                      })),
            ],
          )),
    );
  }

  //營運情況
  Widget operationalWidget() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    WebView(tt: operationalStatus['url'].toString())));
      },
      child: Card(
        color: Color.fromARGB(255, 255, 255, 255),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
        elevation: 1,
        child: SizedBox(
            height: (operationalStatus['intercity'].length * 70).toDouble() +
                (operationalStatus['local'].length * 70).toDouble() +
                100,
            width: screenWidth - 30 > 600 ? 600 : screenWidth - 30,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14.0),
                    topRight: Radius.circular(14.0),
                  ),
                  child: Container(
                    height: 30,
                    color: Color.fromRGBO(67, 150, 200, 1),
                    child: Center(
                      child: Text(
                        '跨縣市大眾運輸營運狀況',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: screenWidth - 30 > 600 ? 600 : screenWidth - 30,
                    height:
                        (operationalStatus['intercity'].length * 70).toDouble(),
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: operationalStatus['intercity'].length,
                        itemBuilder: (context, index) {
                          final intercity =
                              operationalStatus['intercity'][index];
                          return ListTile(
                            title: Text(intercity['name']),
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [Image.network(intercity['logo_url'],
                            width: (screenWidth - 30 > 600 ? 600 : screenWidth - 30) * 0.12,
                            )],) ,
                            subtitle: Text(intercity['status_text']),
                            trailing: Column(
                              children: [
                                // Text(intercity['status_text']),
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
                                                  intercity["status"]),
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                        ))),
                              ],
                            ),
                          );
                        }),
                  ),
                ),
                Container(
                  height: 30,
                  color: Color.fromRGBO(67, 150, 200, 1),
                  child: Center(
                    child: Text(
                      '地方大眾運輸營運狀況',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: screenWidth - 30 > 600 ? 600 : screenWidth - 30,
                    height: (operationalStatus['local'].length * 70).toDouble(),
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: operationalStatus['local'].length,
                        itemBuilder: (context, index) {
                          final local = operationalStatus['local'][index];
                          return ListTile(
                            title: Text(local['name']),
                            leading: Image.network(local['logo_url']),
                            subtitle: Text(local['status_text']),
                            trailing: Column(
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
                                              color:
                                                  changeColor(local["status"]),
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                        ))),
                              ],
                            ),
                          );
                        }),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  // 大眾運輸-附近站點
  Widget stationNearbyWidget() {
    return Card(
      color: Color.fromARGB(255, 255, 255, 255),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
      ),
      elevation: 1,
      child: SizedBox(
          height: 310,
          width: screenWidth - 30 > 600 ? 600 : screenWidth - 30,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14.0),
                  topRight: Radius.circular(14.0),
                ),
                child: Container(
                  height: 40,
                  width: screenWidth - 30 > 600 ? 600 : screenWidth - 30,
                  color: Color.fromRGBO(67, 150, 200, 1),
                  child: Column(
                    //水平置中
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '附近站點',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(14.0),
                  bottomRight: Radius.circular(14.0),
                ),
                child: Container(
                  height: 270,
                  width: screenWidth - 30 > 600 ? 600 : screenWidth - 30,
                  color: Color.fromRGBO(67, 150, 200, 1),
                  child: Row(
                    //水平置中
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: MaterialApp(
                        home: DefaultTabController(
                            length: 3,
                            child: Scaffold(
                              appBar: AppBar(
                                title: null,

                                elevation: 0,
                                backgroundColor:
                                    const Color.fromRGBO(67, 150, 200, 1),
                                //讓最上面的空白消失
                                toolbarHeight: 0,
                                bottom: TabBar(
                                  tabs: [
                                    Tab(text: '腳踏車'),
                                    Tab(text: '台鐵'),
                                    Tab(text: '公車'),
                                    // Tab(text: '公車'),
                                  ],
                                ),
                              ),
                              body: TabBarView(
                                children: [
                                  nearbyStationBikeView(),
                                  nearbyStationTrainView(),
                                  nearbyStationBusView(),
                                ],
                              ),
                            )),
                        debugShowCheckedModeBanner: false,
                      ))
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }

  //附近站點公車-Bus
  Widget nearbyStationBusView() {
    return ListView.builder(
        itemCount: nearbyStationBus.length,
        itemBuilder: (context, index) {
          var list = nearbyStationBus[index];
          return Column(
            children: [
              ListTile(
                leading: Container(
                  width: 75,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 3.0),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(14.0),
                      topRight: Radius.circular(14.0),
                      bottomLeft: Radius.circular(14.0),
                      bottomRight: Radius.circular(14.0),
                    ),
                  ),
                  child: Text(
                    (() {
                      if (list['預估到站時間 (min)'] == '0') {
                        return "進站中";
                      }
                      return list['預估到站時間 (min)'] + '分';
                    })(),
                    style: TextStyle(fontSize: 23),
                    textAlign: TextAlign.center,
                  ),
                ),
                title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(list['路線名稱'] + '( 即將抵達：' + list['站點名稱'] + ' )',
                          textAlign: TextAlign.left),
                      Text('往 ' + list['終點站'], textAlign: TextAlign.left),
                    ]),
              ),
              SizedBox(height: 10)
            ],
          );
        });
  }

  //附近站點台鐵-Train
  Widget nearbyStationTrainView() {
    return ListView.builder(
        itemCount: nearbyStationTrain.length,
        itemBuilder: (context, index) {
          var list = nearbyStationTrain[index];
          return Column(
            children: [
              SizedBox(
                height: 10,
              ),
              ListTile(
                leading: Container(
                    width: 75,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 3.0),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(14.0),
                        topRight: Radius.circular(14.0),
                        bottomLeft: Radius.circular(14.0),
                        bottomRight: Radius.circular(14.0),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          list['TrainTypeName'],
                          style: TextStyle(fontSize: 13),
                        ),
                        Text(
                          list['TrainNo'],
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    )),
                title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '往' + list['EndingStationName'],
                      ),
                      Text(
                          '${DateFormat("'於'H':'mm'抵達'").format(DateFormat("hh:mm:ss").parse(list['ScheduleDepartureTime'])).toString()}'),
                    ]),
              ),
            ],
          );
        });
  }

  //附近站點腳踏車-Bike
  Widget nearbyStationBikeView() {
    return Column(children: [
      Column(children: [
        Container(
          height: 50,
          color: Color.fromRGBO(47, 125, 195, 1),
          padding: EdgeInsets.only(left: 23),
          child: Row(
            children: [
              Container(
                width: screenWidth * 0.6,
                child: Text(
                  '附近站點',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              Container(
                width: screenWidth * 0.1,
                child: Text(
                  '可還',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                width: screenWidth * 0.1,
                child: Text(
                  '可借',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
      Expanded(
        child: ListView.builder(
            itemCount: nearbyStationBike.length,
            itemBuilder: (context, index) {
              var list = nearbyStationBike[index];
              return InkWell(
                child: ListTile(
                  leading: Container(
                    width: screenWidth * 0.6,
                    child: Text(
                      list['公共自行車']['StationName'],
                      style: TextStyle(
                          fontSize: 15, color: Color.fromRGBO(0, 32, 96, 1)),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  title: Row(
                    children: [
                      Container(
                        width: screenWidth * 0.1,
                        child: Text(
                          list['可借車位'].toString(),
                          style: TextStyle(fontSize: 18, color: Colors.red),
                        ),
                      ),
                      Container(
                        width: screenWidth * 0.1,
                        child: Text(
                          list['剩餘空位'].toString(),
                          style:
                              TextStyle(fontSize: 18, color: Colors.blueAccent),
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () {},
              );
            }),
      ),
    ]);
  }

//創建首頁頁面
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(230, 240, 255, 1),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
              child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Visibility(
                visible: carMode,
                child: Column(
                  children: [
                    weatherWidget(),
                    toolWidget(),
                    trafficWarningWidget()
                  ],
                ),
              ),
              Visibility(
                visible: scooterMode,
                child: Column(
                  children: [
                    weatherWidget(),
                    toolScooterWidget(),
                    trafficWarningWidget()
                  ],
                ),
              ),
              Visibility(
                visible: publicTransportMode,
                child: Column(
                  children: [
                    weatherWidget(),
                    stationNearbyWidget(),
                    operationalWidget(),
                  ],
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
