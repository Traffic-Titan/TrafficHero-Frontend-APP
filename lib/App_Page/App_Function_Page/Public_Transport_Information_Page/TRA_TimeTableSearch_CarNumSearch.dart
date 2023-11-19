import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:traffic_hero/App_Page/App_Function_Page/Public_Transport_Information_Page/TRA_TimeTableSearch_CarNum_Result.dart';
import 'package:traffic_hero/imports.dart';
var carNum;
var dateTime_date;
var dateTime_time;
class TRA_TimeTableSearch_CarNumSearch extends StatefulWidget {
  const TRA_TimeTableSearch_CarNumSearch({Key? key}) : super(key: key);

  @override
  State<TRA_TimeTableSearch_CarNumSearch> createState() => _TRA_TimeTableSearch_CarNumSearchState();
}

class _TRA_TimeTableSearch_CarNumSearchState extends State<TRA_TimeTableSearch_CarNumSearch> {

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<stateManager>(context, listen: false);
    var screenWidth = MediaQuery. of(context). size. width ;
    return Scaffold(
      backgroundColor: Color.fromRGBO(221, 235, 247, 1),
      body: Column(
        children: [
          SizedBox(height: 10,),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(14)),
            child: Container(
              width: screenWidth - 30 > 600 ? 600 : screenWidth - 30,
              color: Color.fromRGBO(165, 201, 233, 1),
              child: Text('查詢條件(條件擇一即可)',style: TextStyle(color: Color.fromRGBO(29, 73, 153, 1),fontSize: 25),textAlign:TextAlign.center,),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child:Text('2.車次查詢',style: TextStyle(color: Color.fromRGBO(29, 73, 153, 1),fontSize: 20),textAlign:TextAlign.left,),
          ),
          SizedBox(height: 10,),

          //輸入車次框
          Container(
              width: screenWidth - 30 > 600 ? 600 : screenWidth - 30,
              height: 60,
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  fillColor: Color.fromRGBO(221, 235, 247, 1),
                  hintText: "輸入車次",
                  hintStyle: TextStyle(color: Color.fromRGBO(24, 60, 126, 1),fontSize: 20),
                  filled: true,
                  enabledBorder:  OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color:  Color.fromRGBO(24, 60, 126, 1)),
                  ),

                ),
                onChanged: (text){
                  carNum = text;
                },
              )
          ),
          SizedBox(height: 10,),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(14)),
            child: Container(
              width: screenWidth - 30 > 600 ? 600 : screenWidth - 30,
              color: Color.fromRGBO(165, 201, 233, 1),
              child: Text('日期時間',style: TextStyle(color: Color.fromRGBO(29, 73, 153, 1),fontSize: 25),textAlign:TextAlign.center,),
            ),
          ),
          Container(
            child: TextButton(
                onPressed: () {
                  DatePicker.showDatePicker(context, showTitleActions: true,
                      onConfirm: (date) async {
                        print(date.toString().substring(0, 10));
                        setState(() {
                          dateTime_date = date.toString().substring(0, 10);
                        });
                      }
                  );
                },
                child: Row(
                  children: [
                    Icon(Icons.add_chart),
                    Text("日期")
                  ],
                )
            ),
          ),
          Container(
            child: TextButton(
                onPressed: () {
                  DatePicker.showTime12hPicker(context, showTitleActions: true,
                      onConfirm: (time) async {
                        print(time.toString().substring(11,time.toString().length));
                        setState(() {
                          dateTime_time = time.toString().substring(11,time.toString().length-3);
                        });
                      }
                  );
                },
                child: Row(
                  children: [
                    Icon(Icons.access_time_filled_rounded),
                    Text("時間")
                  ],
                )
            ),
          ),
          TextButton(
              onPressed: () async {
                var url = dotenv.env['TRA_DailyTimeTable_ByCarNum'].toString() +
                    '?CarNum=${carNum}&TrainDate=${dateTime_date}';
                var jwt = ',' + state.accountState.toString();
                print(url);
                var response = await api().apiGet(url, jwt);
                if (response.statusCode == 200) {
                  print(jsonDecode(utf8.decode(response.bodyBytes)));
                  var TrainTypeName = jsonDecode(utf8.decode(response.bodyBytes))[0]['TrainTypeName'];
                  setState(() {
                    state.updateTRA_TimeTableSearch_CarNum(carNum);
                    state.updateTRA_TimeTableSearch_CarType(TrainTypeName);
                    state.updateTRA_TimeTableSearch_CarNum_Result(jsonDecode(utf8.decode(response.bodyBytes))[0]['StopTimes']);
                  });
                  Future.delayed(Duration(seconds: 1),(){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TRA_TimeTableSearch_CarNum_Result()));
                  });
                }
              },
              child: Text("搜尋")
          )
        ],
      ),
    );
  }
}
