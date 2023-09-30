// ignore_for_file: file_names, avoid_unnecessary_containers, prefer_final_fields, sort_child_properties_last, unused_import, library_prefixes, avoid_print, await_only_futures, unused_local_variable, prefer_typing_uninitialized_variables, prefer_const_constructors, deprecated_member_use, use_build_context_synchronously, unused_field

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
  var operationalStatus;
  var weather;
  var homePageModel;
  var screenWidth;
  var fastTool;
  Color colorStatus = Colors.green;
  final PageController _controller = PageController();
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    screenWidth = MediaQuery.of(context).size.width;

    state = Provider.of<stateManager>(context, listen: false);
    setState(() {
      weather = state.weather;
      operationalStatus = state.OperationalStatus;
    });
    print(state.accountState);
    print(state.OperationalStatus);
    //依照模式判斷顯示內容
    if (state.modeName == 'car') {
      setState(() {
        fastTool = Tool.fastLocationCar;
        print(fastTool);
        homePageModel = carHomePage(context);
        _toolList = true;
        _trafficReport = true;
        _nearbyStop = false;
        _operationCondition = false;
        _operationConditionLight = false;
      });
    } else if (state.modeName == 'scooter') {
      setState(() {
        homePageModel = scooterHomePage(context);
        // fastTool = Tool.fastLocationCar ?? {};
        display1 = "工具列";
        display2 = "路況速報";
        _toolList = true;
        _trafficReport = true;
        _nearbyStop = false;
        _operationCondition = false;
        _operationConditionLight = false;
      });
    } else {
      setState(() {
        homePageModel = publicTransportPageHomePage(context);
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
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LicensePlateInput(
                    vehicle: licensePlate,
                  )));
    }
  }

  changeMode(mode) {
    if (mode == 'car') {
      return 'Car';
    } else if (mode == 'scooter') {
      return 'Scooter';
    }
  }

  findPlacesQuickly(url) async {
    var position = await geolocator().updataPosition();
    var urlPosition = url +
        '?mode=${changeMode(state.modeName)}&latitude=${position.latitude}&longitude=${position.longitude}';

    print(urlPosition);
    var jwt = ',${state.accountState}';

    var response = await api().apiGet(urlPosition, jwt);
    var res = jsonDecode(utf8.decode(response.bodyBytes))['url'];
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      try {
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

//頁面組件

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
                  '${weather['temperature']}°',
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
                    // Image.network(
                    //   weather['weather_icon_url'].toString(),
                    //   width: screenWidth - 30 > 600 ? 170 : screenWidth * 0.25,
                    //   fit: BoxFit.contain,
                    // ),
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
                builder: (context) => WebView(tt: weather['url'])));
      },
    );
  }

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

  Widget trafficWarningWidget() {
    return Card(
      color: Color.fromARGB(255, 255, 255, 255),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
      ),
      elevation: 1,
      child: SizedBox(
          height: 250,
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('等待資料'),
                    ],
                  )),
            ],
          )),
    );
  }

  Widget operationalWidget() {
    return Card(
      color: Color.fromARGB(255, 255, 255, 255),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
      ),
      elevation: 1,
      child: SizedBox(
          height: (operationalStatus['intercity'].length * 50).toDouble() + (operationalStatus['local'].length * 50).toDouble() + 100,
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
                      (operationalStatus['intercity'].length * 55).toDouble(),
                  child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: operationalStatus['intercity'].length,
                          itemBuilder: (context, index) {
                            final intercity =
                                operationalStatus['intercity'][index];
                            return ListTile(
                              title: Text(intercity['name']),
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
                  height:
                      (operationalStatus['local'].length * 55).toDouble(),
                  child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: operationalStatus['local'].length,
                          itemBuilder: (context, index) {
                            final intercity =
                                operationalStatus['local'][index];
                            return ListTile(
                              title: Text(intercity['name']),
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
            ],
          )),
    );
  }

  Widget localoperationalWidget() {
    return Card(
      color: Color.fromARGB(255, 255, 255, 255),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
      ),
      elevation: 1,
      child: SizedBox(
          height: 250,
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
                      '地方運輸營運狀況',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
              SizedBox(
                  height: 220,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                          child: ListView.builder(
                              itemCount: operationalStatus['local'].length,
                              itemBuilder: (context, index) {
                                final local = operationalStatus['local'][index];
                                return ListTile(
                                  title: Text(local['name']),
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
                                                    color: changeColor(
                                                        local["status"]),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                              ))),
                                    ],
                                  ),
                                );
                              }))
                    ],
                  )),
            ],
          )),
    );
  }

//創建首頁頁面
  @override
  Widget build(BuildContext context) {
    return homePageModel;
  }

//編輯首頁不同模式頁面
  Widget carHomePage(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(230, 240, 255, 1),
      body: SingleChildScrollView(
        child: Center(
            child: Container(
          child: Column(children: [
            SizedBox(
              height: 10,
            ),
            weatherWidget(),
            toolWidget(),
            trafficWarningWidget(),
          ]),
        )),
      ),
    );
  }

  Widget scooterHomePage(BuildContext context) {
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
              weatherWidget(),
              toolScooterWidget(),
              trafficWarningWidget()
            ],
          )),
        ),
      ),
    );
  }

  Widget publicTransportPageHomePage(BuildContext context) {
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
              weatherWidget(),
              operationalWidget(),
            ],
          )),
        ),
      ),
    );
  }
}
