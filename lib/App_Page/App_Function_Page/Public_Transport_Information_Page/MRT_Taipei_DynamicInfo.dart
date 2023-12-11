// ignore_for_file: file_names, prefer_typing_uninitialized_variables, non_constant_identifier_names, camel_case_types, use_super_parameters, no_leading_underscores_for_local_identifiers, unnecessary_brace_in_string_interps, avoid_print, prefer_const_constructors, avoid_unnecessary_containers

import 'package:traffic_hero/Imports.dart';

var screenWidth;
var state ;
List<dynamic> MRT_DynamicInfo = [];
List<dynamic> outBound = [];
List<dynamic> inBound = [];
var stopName_BR = ["BR01 動物園站","BR02 木柵站","BR03 萬芳社區站","BR04 萬芳醫院站","BR05 辛亥站","BR06 麟光站","BR07 六張犁站","BR08 科技大樓站","BR09/R05 大安站","BR10/BL15 忠孝復興站","BR11/G16 南京復興站","BR12 中山國中站","BR13 松山機場站","BR14 大直站","BR15 劍南路站","BR16 西湖站","BR17 港墘站","BR18 文德站","BR19 內湖站","BR20 大湖公園站","BR21 葫洲站","BR22 東湖站","BR23 南港軟體園區站","BR24/BL23 南港展覽館站"];
var stopName_R = ["R02 象山","R03 台北101/世貿","R04 信義安和","R05	大安","R06	大安森林公園","R07 東門","R08/G10 中正紀念堂站","R09 台大醫院站","R10/BL12 台北車站","R11/G14 中山站","R12 雙連站","R13/O11 民權西路站","R14 圓山站","R15 劍潭站","R16 士林站","R17 芝山站","R18 明德站","R19 石牌站","R20 唭哩岸站","R21 奇岩站","R22 北投站","R23 復興崗站","R24 忠義站","R25 關渡站","R26 竹圍站","R27 紅樹林站","R28 淡水站"];
var stopName_G = ["G01 新店站","G02 新店區公所站","G03 七張站","G04/Y07 大坪林站","G05 景美站","G06 萬隆站","G07 公館站","G08 台電大樓站","G09/O05 古亭站","G10 中正紀念堂","G11 小南門站","G12/BL11 西門站","G13 北門站","G14/R11 中山站","G15/O08 松江南京站","G16/BR11 南京復興站","G17 台北小巨蛋站","G18 南京三民站","G19 松山站"];
var stopName_O = ["O01 南勢角站","O02/Y11 景安站","O03 永安市場站","O04 頂溪站","O05/G09 古亭站","O06/ R07 東門站","O07/ BL14 忠孝新生站","O08/ G15 松江南京站","O09 行天宮站","O10 中山國小站","O11/ R13 民權西路站","O12 大橋頭站","O13 臺北橋站","O14 菜寮站","O15 三重站","O16 先嗇宮站","O17/Y18 頭前庄站","O18 新莊站","O19 輔大站","O20 丹鳳站","O21 迴龍站","O50 三重國小站","O51 三和國中站","O52 徐匯中學站","O53 三民高中站","O54 蘆洲站"];
var stopName_BL = ["BL01 頂埔站","BL02 永寧站","BL03 土城站","BL04 海山站","BL05 亞東醫院站","BL06 府中站","BL07/Y16 板橋站","BL08 新埔站","BL09 江子翠站","BL10 龍山寺站","BL11/G12 西門站","BL12/R10 台北車站","BL13 善導寺站","BL14/O07 忠孝新生站","BL15/BR10 忠孝復興站","BL16 忠孝敦化站","BL17 國父紀念館站","BL18 市政府站","BL19 永春站","BL20 後山埤站","BL21 昆陽站","BL22 南港站","BL23/BR24 南港展覽館站"];
var stopName_Y = ["Y07/G04大坪林站","Y08/K9 十四張站","Y09秀朗橋站","Y10景平站","Y11/O02景安站","Y12/LG06 中和站","Y13橋和站","Y14中原站","Y15板新站","Y16/BL07板橋站","Y17新埔民生站","Y18/O17頭前庄站","Y19幸福站","Y20新北產業園區站"];

var stopID_BR = ["BR01","BR02","BR03","BR04","BR05","BR06","BR07","BR08","BR09","BR10","BR11","BR12","BR13","BR14","BR15","BR16","BR17","BR18","BR19","BR20","BR21","BR22","BR23","BR24"];
var stopID_R = ["R02","R03","R04","R05","R06","R07","R08","R09","R10","R11","R12","R13","R14","R15","R16","R17","R18","R19","R20","R21","R22","R23","R24","R25","R26","R27","R28"];
var stopID_G = ["G01","G02","G03","G04","G05","G06","G07","G08","G09","G10","G11","G12","G13","G14","G15","G16","G17","G18","G19"];
var stopID_O = ["O01","O02","O03","O04","O05","O06","O07","O08","O09","O10","O11","O12","O13","O14","O15","O16","O17","O18","O19","O20","O21","O50","O51","O52","O53","O54"];
var stopID_BL = ["BL01","BL02","BL03","BL04","BL05","BL06","BL07","BL08","BL09","BL10","BL11","BL12","BL13","BL14","BL15","BL16","BL17","BL18","BL19","BL20","BL21","BL22","BL23"];
var stopID_Y = ["Y07","Y08","Y09","Y10","Y11","Y12","Y13","Y14","Y15","Y16","Y17","Y18","Y19","Y20"];
//文湖線、淡水信義線、松山新店線、中和新蘆線、板南線、環狀線
Timer? timer;


class MRT_Taipei_DynamicInfo extends StatefulWidget {
  const MRT_Taipei_DynamicInfo({Key? key}) : super(key: key);

  @override
  State<MRT_Taipei_DynamicInfo> createState() => _MRT_Taipei_DynamicInfoState();
}

class _MRT_Taipei_DynamicInfoState extends State<MRT_Taipei_DynamicInfo> {

  //抓站點動態
  updateStationState(String _selectedItem) async {
    var response;
    var url = '${dotenv.env['MRT_TRTC']}?LineName=${_selectedItem}';
    var jwt = ',${state.accountState}';
    try {
      response = await api().apiGet(url, jwt);
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        setState(() {
          outBound.clear();
          inBound.clear();
        });

        var destinationArray = []; // 儲存該線的終點站及起點站
        for(var data in responseBody){
          if(destinationArray.contains(data['DestinationStationName']) != true){
            setState(() {
              destinationArray.add(data['DestinationStationName']);
            });
          }
        }
        // 透過各輛列車的終點站判斷，分出順向(outBound)及逆向(inBound)
        for (var detail in responseBody){
          if(destinationArray[0] == detail['DestinationStationName']){
            setState(() {
              outBound.add(detail);
            });
          }
          else{
            setState(() {
              inBound.add(detail);
            });
          }
        }
        // MRT_DynamicInfo = responseBody;

      } else {
        print(jsonDecode(utf8.decode(response.bodyBytes)).toString());
      }
    } catch (e) {
      print(e);
    }
  }

  //判斷車輛位置動態
  stationCurrentLocate(List dynamicInfo,List stationID,int direction){
    List locateArray;
    if(direction == 0){
      locateArray = List.filled(stationID.length,CupertinoIcons.arrow_down);
    }
    else{
      locateArray = List.filled(stationID.length,CupertinoIcons.arrow_up);
    }

    for(int pos=0;pos<locateArray.length;pos++){
      for(var info in dynamicInfo){
        if(stationID[pos] == info['LocateID']){
          locateArray[pos] = CupertinoIcons.train_style_two;
          break;
        }
      }
    }
    return locateArray;
  }

  // 文湖線
  Widget BR_DynamicInfo(){
    var trainOutBound = stationCurrentLocate(outBound,stopID_BR,0);
    var trainInBound = stationCurrentLocate(inBound,stopID_BR,1);
    return Scaffold(
        backgroundColor: Color.fromRGBO(221, 235, 247, 1),
        body: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 10,),
              Expanded(
                flex: 5,
                child: Text("文湖線",style: TextStyle(color: Color.fromRGBO(29, 73, 153, 1),fontSize: 30),textAlign: TextAlign.left,),
              ),
              Expanded(
                flex: 3,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color.fromRGBO(29, 73, 153, 1),),
                    iconColor: MaterialStateProperty.all(Colors.white,),
                  ),
                  onPressed: (){
                    updateStationState("BR");
                  },
                  child: Text('Update',style: TextStyle(color: Colors.white,fontSize: 20),),
                ),
              ),
            ],
          ),
          Flexible(
            child: ListView.builder(
                itemCount: stopName_BR.length,
                itemBuilder: (context, index){
                  var stopName = stopName_BR[index];
                  var outBoundLine = trainOutBound[index];
                  var inBoundLine = trainInBound[index];
                  return ListTile(
                    title:Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: ListTile(
                              title: Container(
                                child: Icon(outBoundLine),
                              )
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: ListTile(
                              title: Container(
                                child: Text(stopName,style: TextStyle(color: Colors.black,fontSize: 20),textAlign: TextAlign.center,),
                              )
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: ListTile(
                              title: Container(
                                child: Icon(inBoundLine),
                              )
                          ),
                        ),
                      ],
                    ),
                  );
                }
            ),
          ),
        ],
      )
    );
  }
  // 淡水信義線
  Widget R_DynamicInfo(){
    var trainOutBound = stationCurrentLocate(outBound,stopID_R,0);
    var trainInBound = stationCurrentLocate(inBound,stopID_R,1);
    return Scaffold(
        backgroundColor: Color.fromRGBO(221, 235, 247, 1),
        body: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 10,),
                Expanded(
                  flex: 5,
                  child: Text("淡水信義線",style: TextStyle(color: Color.fromRGBO(29, 73, 153, 1),fontSize: 30),textAlign: TextAlign.left,),
                ),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color.fromRGBO(29, 73, 153, 1),),
                      iconColor: MaterialStateProperty.all(Colors.white,),
                    ),
                    onPressed: (){
                      updateStationState("R");
                    },
                    child: Text('Update',style: TextStyle(color: Colors.white,fontSize: 20),),
                  ),
                ),
              ],
            ),
            Flexible(
              child: ListView.builder(
                  itemCount: stopName_R.length,
                  itemBuilder: (context, index){
                    var stopName = stopName_R[index];
                    var outBoundLine = trainOutBound[index];
                    var inBoundLine = trainInBound[index];
                    return ListTile(
                      title:Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: ListTile(
                                title: Container(
                                  child: Icon(outBoundLine),
                                )
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: ListTile(
                                title: Container(
                                  child: Text(stopName,style: TextStyle(color: Colors.black,fontSize: 20),textAlign: TextAlign.center,),
                                )
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: ListTile(
                                title: Container(
                                  child: Icon(inBoundLine),
                                )
                            ),
                          ),
                        ],
                      ),
                    );
                  }
              ),
            ),
          ],
        )
    );
  }
  // 松山新店線
  Widget G_DynamicInfo(){
    var trainOutBound = stationCurrentLocate(outBound,stopID_G,0);
    var trainInBound = stationCurrentLocate(inBound,stopID_G,1);
    return Scaffold(
        backgroundColor: Color.fromRGBO(221, 235, 247, 1),
        body: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 10,),
                Expanded(
                  flex: 5,
                  child: Text("松山新店線",style: TextStyle(color: Color.fromRGBO(29, 73, 153, 1),fontSize: 30),textAlign: TextAlign.left,),
                ),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color.fromRGBO(29, 73, 153, 1),),
                      iconColor: MaterialStateProperty.all(Colors.white,),
                    ),
                    onPressed: (){
                      updateStationState("G");
                    },
                    child: Text('Update',style: TextStyle(color: Colors.white,fontSize: 20),),
                  ),
                ),
              ],
            ),
            Flexible(
              child: ListView.builder(
                  itemCount: stopName_G.length,
                  itemBuilder: (context, index){
                    var stopName = stopName_G[index];
                    var outBoundLine = trainOutBound[index];
                    var inBoundLine = trainInBound[index];
                    return ListTile(
                      title:Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: ListTile(
                                title: Container(
                                  child: Icon(outBoundLine),
                                )
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: ListTile(
                                title: Container(
                                  child: Text(stopName,style: TextStyle(color: Colors.black,fontSize: 20),textAlign: TextAlign.center,),
                                )
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: ListTile(
                                title: Container(
                                  child: Icon(inBoundLine),
                                )
                            ),
                          ),
                        ],
                      ),
                    );
                  }
              ),
            ),
          ],
        )
    );
  }
  // 中和新蘆線
  Widget O_DynamicInfo(){
    var trainOutBound = stationCurrentLocate(outBound,stopID_O,0);
    var trainInBound = stationCurrentLocate(inBound,stopID_O,1);
    return Scaffold(
        backgroundColor: Color.fromRGBO(221, 235, 247, 1),
        body: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 10,),
                Expanded(
                  flex: 5,
                  child: Text("中和新蘆線",style: TextStyle(color: Color.fromRGBO(29, 73, 153, 1),fontSize: 30),textAlign: TextAlign.left,),
                ),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color.fromRGBO(29, 73, 153, 1),),
                      iconColor: MaterialStateProperty.all(Colors.white,),
                    ),
                    onPressed: (){
                      updateStationState("O");
                    },
                    child: Text('Update',style: TextStyle(color: Colors.white,fontSize: 20),),
                  ),
                ),
              ],
            ),
            Flexible(
              child: ListView.builder(
                  itemCount: stopName_O.length,
                  itemBuilder: (context, index){
                    var stopName = stopName_O[index];
                    var outBoundLine = trainOutBound[index];
                    var inBoundLine = trainInBound[index];
                    return ListTile(
                      title:Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: ListTile(
                                title: Container(
                                  child: Icon(outBoundLine),
                                )
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: ListTile(
                                title: Container(
                                  child: Text(stopName,style: TextStyle(color: Colors.black,fontSize: 20),textAlign: TextAlign.center,),
                                )
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: ListTile(
                                title: Container(
                                  child: Icon(inBoundLine),
                                )
                            ),
                          ),
                        ],
                      ),
                    );
                  }
              ),
            ),
          ],
        )
    );
  }
  // 板南線
  Widget BL_DynamicInfo(){
    var trainOutBound = stationCurrentLocate(outBound,stopID_BL,0);
    var trainInBound = stationCurrentLocate(inBound,stopID_BL,1);
    return Scaffold(
        backgroundColor: Color.fromRGBO(221, 235, 247, 1),
        body: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 10,),
                Expanded(
                  flex: 5,
                  child: Text("板南線",style: TextStyle(color: Color.fromRGBO(29, 73, 153, 1),fontSize: 30),textAlign: TextAlign.left,),
                ),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color.fromRGBO(29, 73, 153, 1),),
                      iconColor: MaterialStateProperty.all(Colors.white,),
                    ),
                    onPressed: (){
                      updateStationState("BL");
                    },
                    child: Text('Update',style: TextStyle(color: Colors.white,fontSize: 20),),
                  ),
                ),
              ],
            ),
            Flexible(
              child: ListView.builder(
                  itemCount: stopName_BL.length,
                  itemBuilder: (context, index){
                    var stopName = stopName_BL[index];
                    var outBoundLine = trainOutBound[index];
                    var inBoundLine = trainInBound[index];
                    return ListTile(
                      title:Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: ListTile(
                                title: Container(
                                  child: Icon(outBoundLine),
                                )
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: ListTile(
                                title: Container(
                                  child: Text(stopName,style: TextStyle(color: Colors.black,fontSize: 20),textAlign: TextAlign.center,),
                                )
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: ListTile(
                                title: Container(
                                  child: Icon(inBoundLine),
                                )
                            ),
                          ),
                        ],
                      ),
                    );
                  }
              ),
            ),
          ],
        )
    );
  }
  // 環狀線
  Widget Y_DynamicInfo(){
    var trainOutBound = stationCurrentLocate(outBound,stopID_Y,0);
    var trainInBound = stationCurrentLocate(inBound,stopID_Y,1);
    return Scaffold(
        backgroundColor: Color.fromRGBO(221, 235, 247, 1),
        body: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 10,),
                Expanded(
                  flex: 5,
                  child: Text("環狀線",style: TextStyle(color: Color.fromRGBO(29, 73, 153, 1),fontSize: 30),textAlign: TextAlign.left,),
                ),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color.fromRGBO(29, 73, 153, 1),),
                      iconColor: MaterialStateProperty.all(Colors.white,),
                    ),
                    onPressed: (){
                      updateStationState("Y");
                    },
                    child: Text('Update',style: TextStyle(color: Colors.white,fontSize: 20),),
                  ),
                ),
              ],
            ),
            Flexible(
              child: ListView.builder(
                  itemCount: stopName_Y.length,
                  itemBuilder: (context, index){
                    var stopName = stopName_Y[index];
                    var outBoundLine = trainOutBound[index];
                    var inBoundLine = trainInBound[index];
                    return ListTile(
                      title:Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: ListTile(
                                title: Container(
                                  child: Icon(outBoundLine),
                                )
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: ListTile(
                                title: Container(
                                  child: Text(stopName,style: TextStyle(color: Colors.black,fontSize: 20),textAlign: TextAlign.center,),
                                )
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: ListTile(
                                title: Container(
                                  child: Icon(inBoundLine),
                                )
                            ),
                          ),
                        ],
                      ),
                    );
                  }
              ),
            ),
          ],
        )
    );
  }


  @override
  Widget build(BuildContext context) {
  state = Provider.of<stateManager>(context, listen: false);
  screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
            length:6,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: const Color.fromRGBO(113, 170, 221, 1),
                toolbarHeight: 0,
                titleTextStyle: TextStyle(color: Colors.white),
                bottom: TabBar(
                  labelColor:Colors.white,//被選中文字顏色,
                  labelStyle: TextStyle(fontSize: 18),
                  indicator: UnderlineTabIndicator( // 被選中底線顏色
                      borderSide: BorderSide(color: Color.fromRGBO(29, 73, 153, 1))
                  ),
                  overlayColor: MaterialStateProperty.all(Color.fromRGBO(113, 170, 221, 1)),
                  tabs: const [
                    Tab(text: 'BR'),
                    Tab(text: 'R'),
                    Tab(text: 'G'),
                    Tab(text: 'O'),
                    Tab(text: 'BL'),
                    Tab(text: 'Y'),
                  ],
                ),
              ),
              body: TabBarView(
                //禁止左右滑動
                children: [
                  BR_DynamicInfo(),
                  R_DynamicInfo(),
                  G_DynamicInfo(),
                  O_DynamicInfo(),
                  BL_DynamicInfo(),
                  Y_DynamicInfo()
                ],
              ),
              floatingActionButton: FloatingActionButton(
                  backgroundColor: Color.fromRGBO(187, 214, 239, 1),
                  onPressed: (){{
                    Navigator.pop(context);
                  }},
                  child: Icon(Icons.arrow_back)
              ),
            )
        )
    );
  }
}
