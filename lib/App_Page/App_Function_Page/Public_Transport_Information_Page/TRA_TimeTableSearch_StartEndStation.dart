import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
import 'package:traffic_hero/App_Page/App_Function_Page/Public_Transport_Information_Page/TRA_TimeTableSearch_StartEndStation_Result.dart';
import 'package:traffic_hero/imports.dart';



class TRA_TimeTableSearch_StartEndStation extends StatefulWidget {
  const TRA_TimeTableSearch_StartEndStation({Key? key}) : super(key: key);

  @override
  State<TRA_TimeTableSearch_StartEndStation> createState() => _TRA_TimeTableSearch_StartEndStationState();
}
String dropDownValue_Start = stopName.first;
String dropDownValue_End = stopName.first;
// 全台火車站名
const List<String> stopName =  <String>["八堵","板橋","樹林","埔心","北新竹","竹東","九讚頭","合興","大山","通霄","日南",
  "大甲","臺中港","清水","苗栗","豐原","栗林","頭家厝","松竹","太原","精武","臺中","五權","大慶","成功","大村","社頭","林內",
  "石榴","民雄","嘉北","柳營","隆田","善化","新市","大橋","保安","仁德","中洲","路竹","岡山","橋頭","新左營","左營","美術館",
  "民族","後庄","潮州","林邊","枋寮","內獅","金崙","知本","康樂","臺東","山里","關山","海端","池上","三民","大富","光復","北埔",
  "南澳","新馬","中里","宜蘭","牡丹","十分","四腳亭","三坑","七堵","五堵","南港","南樹林","中壢","富岡","新富","北湖","千甲",
  "新莊","上員","橫山","新竹","龍港","沙鹿","追分","豐富","南勢","銅鑼","三義",
  "花壇",
  "員林",
  "源泉",
  "龍泉",
  "車埕",
  "斗南",
  "石龜",
  "嘉義",
  "拔林",
  "南科",
  "長榮大學",
  "高雄",
  "九曲堂",
  "屏東",
  "麟洛",
  "南州",
  "鹿野",
  "瑞源",
  "東竹",
  "玉里",
  "富源",
  "萬榮",
  "南平",
  "豐田",
  "吉安",
  "景美",
  "新城",
  "崇德",
  "武塔",
  "蘇澳新",
  "羅東",
  "二結",
  "外澳",
  "石城",
  "福隆",
  "雙溪",
  "三貂嶺",
  "大華",
  "望古",
  "菁桐",
  "暖暖",
  "臺北-環島",
  "山佳",
  "內壢",
  "新豐",
  "竹北",
  "六家",
  "榮華",
  "富貴",
  "香山",
  "竹南",
  "白沙屯",
  "新埔",
  "苑裡",
  "大肚",
  "造橋",
  "潭子",
  "濁水",
  "集集",
  "斗六",
  "大林",
  "水上",
  "南靖",
  "林鳳營",
  "沙崙",
  "楠梓",
  "鼓山",
  "科工館",
  "六塊厝",
  "竹田",
  "崁頂",
  "鎮安",
  "佳冬",
  "枋山",
  "枋野",
  "大武",
  "瀧溪",
  "太麻里",
  "瑞和",
  "富里",
  "東里",
  "瑞穗",
  "林榮新光",
  "平和",
  "志學",
  "花蓮",
  "和仁",
  "東澳",
  "永樂",
  "蘇澳",
  "冬山",
  "礁溪",
  "龜山",
  "大溪",
  "貢寮",
  "嶺腳",
  "猴硐",
  "八斗子",
  "基隆",
  "百福",
  "汐止",
  "汐科",
  "松山",
  "臺北",
  "萬華",
  "浮洲",
  "鶯歌",
  "桃園",
  "楊梅",
  "湖口",
  "竹中",
  "內灣",
  "三姓橋",
  "崎頂",
  "談文",
  "後龍",
  "龍井",
  "泰安",
  "后里",
  "烏日",
  "新烏日",
  "彰化",
  "永靖",
  "田中",
  "二水",
  "水里",
  "後壁",
  "新營",
  "永康",
  "臺南",
  "大湖",
  "內惟",
  "三塊厝",
  "正義",
  "鳳山",
  "歸來",
  "西勢",
  "東海",
  "加祿",
  "南方小站",
  "潮州基地",
  "鳳林",
  "壽豐",
  "和平",
  "漢本",
  "四城",
  "頂埔",
  "頭城",
  "大里",
  "平溪",
  "瑞芳",
  "海科館"];
// 全台火車站點ID
const List<String> stationID = <String>["0920",
  "1020",
  "1040",
  "1110",
  "1190",
  "1203",
  "1205",
  "1206",
  "2120",
  "2170",
  "2190",
  "2200",
  "2210",
  "2220",
  "3160",
  "3230",
  "3240",
  "3260",
  "3270",
  "3280",
  "3290",
  "3300",
  "3310",
  "3320",
  "3350",
  "3380",
  "3410",
  "3450",
  "3460",
  "4060",
  "4070",
  "4130",
  "4150",
  "4170",
  "4190",
  "4210",
  "4250",
  "4260",
  "4270",
  "4300",
  "4310",
  "4320",
  "4340",
  "4350",
  "4370",
  "4410",
  "4450",
  "5050",
  "5090",
  "5120",
  "5140",
  "5210",
  "5230",
  "5240",
  "6000",
  "6010",
  "6050",
  "6060",
  "6070",
  "6120",
  "6150",
  "6160",
  "7010",
  "7090",
  "7140",
  "7170",
  "7190",
  "7320",
  "7332",
  "7380",
  "0910",
  "0930",
  "0950",
  "0980",
  "1050",
  "1100",
  "1130",
  "1140",
  "1150",
  "1191",
  "1192",
  "1201",
  "1204",
  "1210",
  "2140",
  "2230",
  "2260",
  "3150",
  "3170",
  "3180",
  "3190",
  "3370",
  "3390",
  "3431",
  "3433",
  "3436",
  "3480",
  "3490",
  "4080",
  "4160",
  "4180",
  "4271",
  "4400",
  "4460",
  "5000",
  "5020",
  "5070",
  "6020",
  "6030",
  "6090",
  "6110",
  "6140",
  "6170",
  "6190",
  "6210",
  "6250",
  "7020",
  "7030",
  "7040",
  "7080",
  "7130",
  "7160",
  "7180",
  "7240",
  "7280",
  "7290",
  "7310",
  "7330",
  "7331",
  "7333",
  "7336",
  "7390",
  "1001",
  "1060",
  "1090",
  "1170",
  "1180",
  "1194",
  "1202",
  "1207",
  "1230",
  "1250",
  "2150",
  "2160",
  "2180",
  "2250",
  "3140",
  "3250",
  "3432",
  "3434",
  "3470",
  "4050",
  "4090",
  "4100",
  "4140",
  "4272",
  "4330",
  "4380",
  "4420",
  "4470",
  "5040",
  "5060",
  "5080",
  "5100",
  "5160",
  "5170",
  "5190",
  "5200",
  "5220",
  "6040",
  "6080",
  "6100",
  "6130",
  "6200",
  "6230",
  "6240",
  "7000",
  "7050",
  "7100",
  "7110",
  "7120",
  "7150",
  "7210",
  "7250",
  "7260",
  "7300",
  "7334",
  "7350",
  "7362",
  "0900",
  "0940",
  "0960",
  "0970",
  "0990",
  "1000",
  "1010",
  "1030",
  "1070",
  "1080",
  "1120",
  "1160",
  "1193",
  "1208",
  "1220",
  "1240",
  "2110",
  "2130",
  "2240",
  "3210",
  "3220",
  "3330",
  "3340",
  "3360",
  "3400",
  "3420",
  "3430",
  "3435",
  "4110",
  "4120",
  "4200",
  "4220",
  "4290",
  "4360",
  "4390",
  "4430",
  "4440",
  "5010",
  "5030",
  "5110",
  "5130",
  "5998",
  "5999",
  "6180",
  "6220",
  "7060",
  "7070",
  "7200",
  "7220",
  "7230",
  "7270",
  "7335",
  "7360",
  "7361"];
String dateTime_date=DateTime.now().toString().substring(0, 10);
String dateTime_time =  DateFormat('HH:mm').format(DateTime.now());
var screenWidth;
class _TRA_TimeTableSearch_StartEndStationState extends State<TRA_TimeTableSearch_StartEndStation> {
  @override
  Widget build(BuildContext context) {
    var state = Provider.of<stateManager>(context, listen: false);
    screenWidth = MediaQuery. of(context). size. width ;
    //根據起訖點取得火車時刻表
    getStationTimeTable() async{
      // ?OriginStationID=0920&DestinationStationID=1020&TrainDate=2023-11-24&TrainTime=20%3A00
      // var url = 'https://app.traffic-hero.eddie.tw/APP/Information/PublicTransport/TaiwanRailway/DailyTimeTable_ByStartEndStation?OriginStationID=4170&DestinationStationID=4440&TrainDate=2023-11-24&TrainTime=09:09';
      var url = dotenv.env['TRA_DailyTimeTable_ByStartEndStation'].toString() +
          '?OriginStationID=${stationID[stopName.indexOf(dropDownValue_Start)]}&DestinationStationID=${stationID[stopName.indexOf(dropDownValue_End)]}&TrainDate=${dateTime_date}&TrainTime=${dateTime_time}';
      var jwt = ',' + state.accountState.toString();
      var response = await api().apiGet(url, jwt);
      var responseBody;
      print(url);
      if (response.statusCode == 200) {
        print(url);
        setState(() {
          responseBody=jsonDecode(utf8.decode(response.bodyBytes));
          state.updateTRA_TimeTableSearch_StartStation(dropDownValue_Start);
          state.updateTRA_TimeTableSearch_EndStation(dropDownValue_End);
          state.updateTRA_TimeTableSearch_StartEndStation_Result(responseBody);
        });
        Future.delayed(Duration(seconds: 1),(){
          Navigator.push(context, MaterialPageRoute(builder: (context) => TRA_TimeTableSearch_StartEndStation_Result()));
        });

      }
    }

    return Scaffold(
      body: Scaffold(
        backgroundColor: Color.fromRGBO(221, 235, 247, 1),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10,top: 10),
              decoration: BoxDecoration(
                color: Color.fromRGBO(165, 201, 233, 1),
                borderRadius: BorderRadius.all(Radius.circular(14)),
              ),
              width: screenWidth - 30 > 600 ? 600 : screenWidth - 30,
              child: Text('起訖站查詢',style: TextStyle(color: Color.fromRGBO(29, 73, 153, 1),fontSize: 25),textAlign:TextAlign.center,),
            ),
            //起訖站查詢按鈕
            Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //選擇起始地
                  DecoratedBox(
                      decoration: BoxDecoration(
                          border: Border.all(color: Color.fromRGBO(24, 60, 126, 1),width: 2),
                          borderRadius: BorderRadius.circular(15),
                          color: Color.fromRGBO(221, 235, 247, 1)
                      ),
                      child: Container(
                        height: 60,
                        width: 150,
                        alignment: Alignment.center,
                        child: DropdownButton(
                            value: dropDownValue_Start,
                            items: stopName.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,style: const TextStyle(
                                  fontSize: 20,
                                ),),
                              );
                            }).toList(),
                            onChanged:(String? value){
                              setState(() {
                                dropDownValue_Start = value!;
                              });
                            }
                        ),
                      )
                  ),
                  //交換按鈕
                  Icon(Icons.cached,size: 20,),
                  //選擇目的地
                  DecoratedBox(
                      decoration: BoxDecoration(
                          border: Border.all(color: Color.fromRGBO(24, 60, 126, 1),width: 2),
                          borderRadius: BorderRadius.circular(15),
                          color: Color.fromRGBO(24, 60, 126, 1)
                      ),
                      child:Container(
                        height: 60,
                        width: 150,
                        alignment: Alignment.center,
                        child: DropdownButton(
                            dropdownColor: Color.fromRGBO(24, 60, 126, 1),
                            value: dropDownValue_End,
                            items: stopName.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,style: const TextStyle(fontSize: 20,color: Colors.white),),
                              );
                            }).toList(),
                            onChanged:(String? value){
                              setState(() {
                                dropDownValue_End = value!;
                              });
                            }
                        ),
                      )
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10,top: 10),
              decoration: BoxDecoration(
                color: Color.fromRGBO(165, 201, 233, 1),
                borderRadius: BorderRadius.all(Radius.circular(14)),
              ),
              width: screenWidth - 30 > 600 ? 600 : screenWidth - 30,
              child: Text('日期時間',style: TextStyle(color: Color.fromRGBO(29, 73, 153, 1),fontSize: 25),textAlign:TextAlign.center,),
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10,right: 5),
                  width: screenWidth*0.6,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        border: Border.all(color: Color.fromRGBO(24, 60, 126, 1),width: 2),
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromRGBO(221, 235, 247, 1)
                    ),
                    child:TextButton(
                      onPressed: () {
                        DatePicker.showDatePicker(context, showTitleActions: true,
                            maxTime: DateTime.now().add(Duration(days: 120)),
                            minTime: DateTime.now(),
                            onConfirm: (date) async {
                              setState(() {
                                dateTime_date = date.toString().substring(0, 10);
                              });
                            }
                        );
                      },
                      child: Text(dateTime_date!,style: TextStyle(color:  Color.fromRGBO(24, 60, 126, 1),fontSize: 20),),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 5,right: 10),
                  width: screenWidth*0.4,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        border: Border.all(color: Color.fromRGBO(24, 60, 126, 1),width: 2),
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromRGBO(24, 60, 126, 1)
                    ),
                    child:TextButton(
                      onPressed: () {
                        DatePicker.showTime12hPicker(context, showTitleActions: true,
                            onConfirm: (time) async {
                              print(DateFormat('HH:mm').format(time));
                              setState(() {
                                dateTime_time = DateFormat('HH:mm').format(time).toString();
                              });
                            }
                        );
                      },
                      child: Text(dateTime_time!,style: TextStyle(color: Colors.white,fontSize: 20),),
                    ),
                  ),
                ),
              ],
            ),
            Container(
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(24, 60, 126, 1),
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                ),
                width: screenWidth - 30 > 600 ? 600 : screenWidth - 30,
                child: TextButton(
                  onPressed: () async {
                    await getStationTimeTable();
                  },
                  child: Text('搜尋',style: TextStyle(color: Colors.white,fontSize: 20),),
                )
            ),
          ],
        ),
      ),
    );
  }
}
