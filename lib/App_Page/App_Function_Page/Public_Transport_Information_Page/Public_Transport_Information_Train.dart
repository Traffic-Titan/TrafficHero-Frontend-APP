// ignore_for_file: unused_local_variable, file_names, camel_case_types, use_super_parameters, unnecessary_late, prefer_typing_uninitialized_variables, prefer_is_empty, avoid_unnecessary_containers

import 'package:dropdown_search/dropdown_search.dart';
import 'package:traffic_hero/Imports.dart';

class Public_Transport_Information_Train extends StatefulWidget {
  const Public_Transport_Information_Train({Key? key}) : super(key: key);

  @override
  State<Public_Transport_Information_Train> createState() =>
      _Public_Transport_Information_TrainState();
}

// 所有火車站 站點ID
const List<String> stationID = <String>[
  "0920",
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
  "7361"
];
// 所有火車站 站名
const List<String> stopName = <String>[
  "八堵",
  "板橋",
  "樹林",
  "埔心",
  "北新竹",
  "竹東",
  "九讚頭",
  "合興",
  "大山",
  "通霄",
  "日南",
  "大甲",
  "臺中港",
  "清水",
  "苗栗",
  "豐原",
  "栗林",
  "頭家厝",
  "松竹",
  "太原",
  "精武",
  "臺中",
  "五權",
  "大慶",
  "成功",
  "大村",
  "社頭",
  "林內",
  "石榴",
  "民雄",
  "嘉北",
  "柳營",
  "隆田",
  "善化",
  "新市",
  "大橋",
  "保安",
  "仁德",
  "中洲",
  "路竹",
  "岡山",
  "橋頭",
  "新左營",
  "左營",
  "美術館",
  "民族",
  "後庄",
  "潮州",
  "林邊",
  "枋寮",
  "內獅",
  "金崙",
  "知本",
  "康樂",
  "臺東",
  "山里",
  "關山",
  "海端",
  "池上",
  "三民",
  "大富",
  "光復",
  "北埔",
  "南澳",
  "新馬",
  "中里",
  "宜蘭",
  "牡丹",
  "十分",
  "四腳亭",
  "三坑",
  "七堵",
  "五堵",
  "南港",
  "南樹林",
  "中壢",
  "富岡",
  "新富",
  "北湖",
  "千甲",
  "新莊",
  "上員",
  "橫山",
  "新竹",
  "龍港",
  "沙鹿",
  "追分",
  "豐富",
  "南勢",
  "銅鑼",
  "三義",
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
  "海科館"
];
// 提供下拉式選單的預設值
String dropDownValue = stopName.first;
//順行
late List<Map<String, dynamic>> outBound = [
  {
    "方向": "順行",
    "起點站": "暫無發車",
    "終點站": "",
    "列車類型": "",
    "列車編號": "",
    "預估到站時間": "",
    "線路": ""
  }
];
//逆行
late List<Map<String, dynamic>> inBound = [
  {
    "方向": "逆行",
    "起點站": "暫無發車",
    "終點站": "",
    "列車類型": "",
    "列車編號": "",
    "預估到站時間": "",
    "線路": ""
  }
];
//該站資訊
var stationInfo = [];
var state;
var screenWidth;
var screenHeight;

class _Public_Transport_Information_TrainState
    extends State<Public_Transport_Information_Train> {
  //取得站點資料
  getStopList(value) async {
    // 利用站名與站點ID相對應，讓選到的站名轉換為對應的ID
    var pickedNum = stopName.indexOf(value!);
    var url =
        '${dotenv.env['TRA_StationLiveBoard']}?StationID=${stationID[pickedNum]}';
    var jwt = ',${state.accountState}';
    var response = await api().apiGet(url, jwt);
    if (response.statusCode == 200) {
      setState(() {
        stationInfo = jsonDecode(utf8.decode(response.bodyBytes));
      });
      if (stationInfo.length != 0) {
        outBound.clear();
        inBound.clear();
        for (int i = 0; i < stationInfo.length; i++) {
          if (stationInfo[i]['方向'] == "順行") {
            outBound.add(stationInfo[i]);
          } else if (stationInfo[i]['方向'] == "逆行") {
            inBound.add(stationInfo[i]);
          }
        }
        if (outBound.length == 0) {
          outBound = [
            {
              "方向": "順行",
              "起點站": "暫無發車",
              "終點站": "",
              "列車類型": "",
              "列車編號": "",
              "預估到站時間": "",
              "線路": ""
            }
          ];
        } else if (inBound.length == 0) {
          inBound = [
            {
              "方向": "逆行",
              "起點站": "暫無發車",
              "終點站": "",
              "列車類型": "",
              "列車編號": "",
              "預估到站時間": "",
              "線路": ""
            }
          ];
        }
      }
    }
  }

  //台鐵頁面
  @override
  Widget build(BuildContext context) {
    state = Provider.of<stateManager>(context, listen: false);
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Container(
      color: const Color.fromRGBO(230, 240, 255, 1),
      child: Column(
        children: [
          Container(
              height: 60,
              width: screenWidth * 0.9,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 10),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(47, 125, 195, 1),
                // borderRadius: BorderRadius.circular(5)
              ),
              child: Row(
                children: [
                  const Text('選擇車站：',
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                  SizedBox(
                      height: 60,
                      width: 150,
                      child: DropdownSearch<String>(
                        items: stopName,
                        popupProps: const PopupProps.menu(
                          showSearchBox: true, // add this line
                          // showSelectedItems: true,
                        ),
                        dropdownDecoratorProps: const DropDownDecoratorProps(
                            baseStyle:
                                TextStyle(fontSize: 20, color: Colors.white),
                            dropdownSearchDecoration: InputDecoration()),
                        onChanged: (String? value) => setState(() async {
                          dropDownValue = value!;
                          await getStopList(dropDownValue);
                        }),
                        selectedItem: stopName.first,
                      ))
                ],
              )),
          Container(
              width: screenWidth * 0.9,
              color: Colors.white,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: screenHeight * 0.25,
                        color: const Color.fromRGBO(47, 125, 195, 1),
                        padding: const EdgeInsets.only(left: 3),
                        alignment: AlignmentDirectional.centerStart,
                        child: const Text(
                          "順行",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.25,
                        width: screenWidth * 0.8 - 10,
                        child: ListView.builder(
                            itemCount: outBound.length,
                            itemBuilder: (context, index) {
                              var list = outBound[index];
                              return (list['起點站'] == '暫無發車')
                                  ? const Text('暫無發車')
                                  : ListTile(
                                      title: Container(
                                          child: Row(
                                      children: [
                                        SizedBox(
                                          height: 60,
                                          width: 100,
                                          child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                color: const Color.fromRGBO(
                                                    255, 0, 0, 1),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    list['列車類型'],
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    list['列車編號'],
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              )),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              list["起點站"] +
                                                  " － " +
                                                  list["終點站"] +
                                                  "(${list["線路"]})",
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              list["預估到站時間"]
                                                  .toString()
                                                  .substring(0, 5),
                                              textAlign: TextAlign.center,
                                            )
                                          ],
                                        ),
                                      ],
                                    )));
                            }),
                      )
                    ],
                  ),
                  const Divider(
                      height: 5, color: Color.fromRGBO(24, 60, 126, 1)),
                  Row(
                    children: [
                      Container(
                        height: screenHeight * 0.25,
                        color: const Color.fromRGBO(47, 125, 195, 1),
                        padding: const EdgeInsets.only(left: 3),
                        alignment: AlignmentDirectional.centerStart,
                        child: const Text(
                          "逆行",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: screenHeight * 0.25,
                            width: screenWidth * 0.8 - 10,
                            child: ListView.builder(
                                itemCount: inBound.length,
                                itemBuilder: (context, index) {
                                  var list = inBound[index];
                                  return (list['起點站'] == '暫無發車')
                                      ? const Text('暫無發車')
                                      : ListTile(
                                          title: Container(
                                              child: Row(
                                          children: [
                                            SizedBox(
                                              height: 60,
                                              width: 100,
                                              child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromRGBO(
                                                        255, 0, 0, 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        list['列車類型'],
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      Text(
                                                        list['列車編號'],
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ],
                                                  )),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  list["起點站"] +
                                                      " － " +
                                                      list["終點站"] +
                                                      "(${list["線路"]})",
                                                  textAlign: TextAlign.center,
                                                ),
                                                Text(
                                                  list["預估到站時間"]
                                                      .toString()
                                                      .substring(0, 5),
                                                  textAlign: TextAlign.center,
                                                )
                                              ],
                                            ),
                                          ],
                                        )));
                                }),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              )),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                const Color.fromRGBO(24, 60, 126, 1),
              ),
              shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              )),
              minimumSize: MaterialStateProperty.all(
                  Size(screenWidth - 30 > 600 ? 600 : screenWidth - 30, 50)),
            ),
            onPressed: () {
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TRA_TimeTableSearch()),
                );
              });
            },
            child: const Text(
              "火車時刻表條件查詢",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}
