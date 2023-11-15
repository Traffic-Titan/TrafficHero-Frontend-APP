import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
import 'package:traffic_hero/App_Page/App_Function_Page/Public_Transport_Information_Page/THSR_StartEndStationSearch_Result.dart';
import 'package:traffic_hero/Imports.dart';
class THSR_StartEndStationSearch extends StatefulWidget {
  const THSR_StartEndStationSearch({Key? key}) : super(key: key);

  @override
  State<THSR_StartEndStationSearch> createState() => _THSR_StartEndStationSearchState();
}
var dateTime_date;
var dateTime_time;

const List<String> stopName = <String>['起始地','南港','台北','板橋','桃園','新竹','苗栗','台中','彰化','雲林','嘉義','台南','左營','目的地'];
final DateFormat formatter = DateFormat('yyyy/MM/dd');
String dropDownValue_Start = stopName.first;
String dropDownValue_End = stopName.last;

class _THSR_StartEndStationSearchState extends State<THSR_StartEndStationSearch> {
  @override
  Widget build(BuildContext context) {

    var state = Provider.of<stateManager>(context, listen: false);
    var  screenWidth = MediaQuery. of(context). size. width ;
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
            child:Text('1.起訖站查詢',style: TextStyle(color: Color.fromRGBO(29, 73, 153, 1),fontSize: 20),textAlign:TextAlign.left,),
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
                              child: Text(value),
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
                    child:
                    Container(
                      height: 60,
                      width: 150,
                      alignment: Alignment.center,
                      child: DropdownButton(
                          value: dropDownValue_End,
                          items: stopName.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
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
                var url = dotenv.env['THSR_SearchBy_Date_Stop'].toString() +
                    '?OriginStationName=${dropDownValue_Start}&DestinationStationName=${dropDownValue_End}&TrainDate=${dateTime_date}';
                var jwt = ',' + state.accountState.toString();
                print(url);
                var response = await api().apiGet(url, jwt);
                if (response.statusCode == 200) {
                  // print(jsonDecode(utf8.decode(response.bodyBytes)));
                  setState(() {
                    state.updateTHSR_StartEndSearch_StartName(dropDownValue_Start);
                    state.updateTHSR_StartEndSearch_EndName(dropDownValue_End);
                    state.updateTHSR_StartEndSearchResult(jsonDecode(utf8.decode(response.bodyBytes)));
                  });
                  Future.delayed(Duration(seconds: 1),(){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => THSR_StartEndStationSearch_Result()));
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
