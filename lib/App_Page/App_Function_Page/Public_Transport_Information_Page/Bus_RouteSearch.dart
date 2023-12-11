// ignore_for_file: unused_import, file_names, constant_identifier_names, prefer_typing_uninitialized_variables, non_constant_identifier_names, use_super_parameters, unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings, avoid_print, prefer_is_empty, prefer_const_constructors, unnecessary_new

import 'package:traffic_hero/App_Page/App_Function_Page/Public_Transport_Information_Page/Bus_RouteDetail.dart';
import 'package:traffic_hero/imports.dart';

const List<String> countyName_Cn = <String>['請選擇縣市','新北市','台北市','桃園市','台中市','台南市','高雄市','基隆市','新竹市','新竹縣','苗栗縣','彰化縣','南投縣','雲林縣','嘉義縣','嘉義市','屏東縣','宜蘭縣','花蓮縣','台東縣','金門縣','澎湖縣','連江縣'];
const List<String> countyName_En = <String>['None','NewTaipei','Taipei','Taoyuan','Taichung','Tainan','Kaohsiung','Keelung','Hsinchu','HsinchuCounty','MiaoliCounty','ChanghuaCounty','NantouCounty','YunlinCounty','ChiayiCounty','Chiayi','PingtungCounty','YilanCounty','HualienCounty','TaitungCounty','KinmenCounty','PenghuCounty','LienchiangCounty'];
String dropdownValue = countyName_Cn.first;
var dropDownValue_En;
var searchResult = [];
var routeNum;


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

  //根據"關鍵字"搜尋該路線站點及預估到站時間
  resultDetail(String routeID, String area) async{
    var url = dotenv.env['BusRouteStopby'].toString() + '?area=${area}&route_id=${routeID}';
    var jwt = ',' + state.accountState.toString();
    var response = await api().apiGet(url, jwt);
    if (response.statusCode == 200) {
      // print(jsonDecode(utf8.decode(response.bodyBytes)));
      setState(() {
        state.updateBusRouteDetail(jsonDecode(utf8.decode(response.bodyBytes)));
      });
    } else {
      print(jsonDecode(utf8.decode(response.bodyBytes)));
    }
  }

  // 回傳公車圖示
  IconData? busIcon(String route){
    if(route.length == 0){
      return null;
    }
    else{
      return Icons.directions_bus_rounded;
    }
  }

  // 公車路線搜尋
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
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromRGBO(113, 170, 221, 1),
        title: Container(
          margin: EdgeInsets.only(top: 20,bottom: 20),
          decoration: BoxDecoration(
              color: const Color.fromRGBO(187, 214, 239, 1),
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
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 45,
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  cursorColor:  Color.fromRGBO(29, 73, 153, 1),
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    fillColor: Color.fromRGBO(120, 173, 222, 1),
                    hintText: "搜尋公車班次或號碼",
                    hintStyle: TextStyle(color: Colors.white,fontSize: 20),
                    filled: true,
                    enabledBorder:  OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color:  Color.fromRGBO(120, 173, 222, 1)),
                      borderRadius: BorderRadius.circular(80),
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
                      setState(() {
                        routeNum = inputText;
                      });
                      busRouteSearch(inputText);
                    }
                  },
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
                  // leading: Icon(Icons.directions_bus_rounded,size: 50,color:Color.fromRGBO(29, 73, 153, 1),),
                  title:TextButton(
                    onPressed: (){
                      resultDetail(data['route'],dropDownValue_En);
                      //透過延遲進入頁面，使頁面能夠順利讀取
                      Future.delayed(Duration(seconds: 3),(){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => BusRouteDetail()));
                      });
                    },
                    child: Row(
                      children: [
                        Icon(busIcon(data['route']),size: 50,color:Color.fromRGBO(29, 73, 153, 1),),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data['route'],style: TextStyle(color: Color.fromRGBO(29, 73, 153, 1),fontSize: 20),),
                            Text(data['description'],style: TextStyle(color: Colors.black,fontSize: 18)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // trailing: 收藏圖示,
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
      elevation: 10,//设置阴影
      style: new TextStyle(//设置文本框里面文字的样式
          color: Colors.black,
          fontSize: 20
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


