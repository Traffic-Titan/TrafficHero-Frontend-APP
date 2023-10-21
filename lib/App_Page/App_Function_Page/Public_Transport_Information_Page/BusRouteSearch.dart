import 'package:traffic_hero/imports.dart';
class BusRouteSearch extends StatefulWidget {
  const BusRouteSearch({Key? key}) : super(key: key);

  @override
  State<BusRouteSearch> createState() => _BusRouteSearchState();
}

class _BusRouteSearchState extends State<BusRouteSearch> {
  var countyName_Cn = ['新北市','台北市'];
  @override
  Widget build(BuildContext context) {
    String? selectedCounty = '新北市';
    return Scaffold(
      backgroundColor: const Color.fromRGBO(113, 170, 221, 1),
      appBar: new AppBar(),
      body: new Column(
        children: <Widget>[
          new Center(
            child: new DropdownButton(
              value: selectedCounty,// 设置初始值，要与列表中的value是相同的
              items: countyName_Cn
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              hint:new Text("請選擇縣市"),// 当没有初始值时显示
              onChanged: (selectValue){//选中后的回调
                setState(() {
                  selectedCounty = selectValue;
                });
              },
              elevation: 10,//设置阴影
              style: new TextStyle(//设置文本框里面文字的样式
                  color: Colors.black,
                  fontSize: 15
              ),
              iconSize: 30,//设置三角标icon的大小
              underline: Container(height: 1,color: Colors.blue,),// 下划线

            ),
          ),
        ],
      ),
    );
  }
}

