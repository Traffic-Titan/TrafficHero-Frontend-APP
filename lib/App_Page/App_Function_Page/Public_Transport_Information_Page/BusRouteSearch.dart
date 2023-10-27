// ignore_for_file: unused_import

import 'dart:ffi';

import 'package:traffic_hero/imports.dart';

const List<String> countyName_Cn = <String>['請選擇縣市','新北市','台北市','桃園市','台中市','台南市','高雄市','基隆市','新竹市','新竹縣','苗栗縣','彰化縣','南投縣','雲林縣','嘉義縣','嘉義市','屏東縣','宜蘭縣','花蓮縣','台東縣','金門縣','澎湖縣','連江縣'];
const List<String> countyName_En = <String>['None','NewTaipei','Taipei','Taoyuan','Taichung','Tainan','Kaohsiung','Keelung','Hsinchu','HsinchuCounty','MiaoliCounty','ChanghuaCounty','NantouCounty','YunlinCounty','ChiayiCounty','Chiayi','PingtungCounty','YilanCounty','HualienCounty','TaitungCounty','KinmenCounty','PenghuCounty','LienchiangCounty'];
String dropdownValue = countyName_Cn.first;
var dropDownValue_En;
var searchResult = [];

class BusRouteSearch extends StatefulWidget {
  const BusRouteSearch({Key? key}) : super(key: key);

  @override
  State<BusRouteSearch> createState() => _BusRouteSearchState();
}

class _BusRouteSearchState extends State<BusRouteSearch> {
  late stateManager state;
  String dropdownValue = countyName_Cn.first;

  @override
  void initState(){
    super.initState();
    searchResult =[{"route":"","description":""}];
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
  }

  busRouteSearch(String routeNum) async {
    var url = dotenv.env['BusRoute'].toString() + '?area=${dropDownValue_En}&route_id=${routeNum}';
    var jwt = ',' + state.accountState.toString();
    var response = await api().apiGet(url, jwt);
    if (response.statusCode == 200) {
      setState(() {
        searchResult = jsonDecode(utf8.decode(response.bodyBytes))['result'];
      });
    } else {
      print(jsonDecode(utf8.decode(response.bodyBytes)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(221, 235, 247, 1),
      appBar: new AppBar(
        backgroundColor: const Color.fromRGBO(113, 170, 221, 1),
        title: Container(
          decoration: BoxDecoration(
              color: const Color.fromRGBO(57, 136, 207, 1),
              borderRadius: BorderRadius.circular(30)),
          child: Center(
              child:DropdownButtonExample()
          ),
        ),
      ),
      body: new Column(
        children: <Widget>[
          // 與AppBar的間距
          SizedBox(
            height: 10,
          ),
          // 公車班次輸入框
          Expanded(
              flex:1,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: Color.fromRGBO(120, 173, 222, 1),
                    hintText: "搜尋公車班次或號碼",
                    filled: true,
                    enabledBorder:  OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Color.fromRGBO(24, 60, 126, 1),),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onChanged: (inputText)  {
                    if(inputText.length == 0){
                      searchResult =[{"route":"","description":""}];
                      setState(() {
                          searchResult;
                      });
                    }
                    else {
                      busRouteSearch(inputText);
                    }
                  },
                ),
              ),
          ),
          // 下排搜尋結果
          Expanded(
            flex: 9,
            child: ListView.builder(
              itemCount: searchResult.length,
              itemBuilder: (context,index){
                var data = searchResult[index];
                return ListTile(
                  title: Column(
                    children: [
                      Text(data['route']),
                      Text(data['description'])
                    ],
                  ),
                );
              },
            )
          )
        ],
      ),
    );
  }
}
class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}
class _DropdownButtonExampleState extends State<DropdownButtonExample> {


  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      // hint:new Text("請選擇縣市"),// 当没有初始值时显示
      elevation: 10,//设置阴影
      style: new TextStyle(//设置文本框里面文字的样式
          color: Colors.black,
          fontSize: 25
      ),
      iconSize: 30,//设置三角标icon的大小
      // underline: Container(height: 1,color: Colors.blue,),// 下划线
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          dropDownValue_En = countyName_En[countyName_Cn.indexOf(dropdownValue)];
        });
      },
      items: countyName_Cn.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}


