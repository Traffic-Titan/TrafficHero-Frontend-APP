import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
import 'package:traffic_hero/App_Page/App_Function_Page/Public_Transport_Information_Page/THSR_StartEndStationSearch_Result.dart';
import 'package:traffic_hero/Imports.dart';
class THSR_StartEndStationSearch extends StatefulWidget {
  const THSR_StartEndStationSearch({Key? key}) : super(key: key);

  @override
  State<THSR_StartEndStationSearch> createState() => _THSR_StartEndStationSearchState();
}

const List<String> stopName = <String>['起始地','南港','台北','板橋','桃園','新竹','苗栗','台中','彰化','雲林','嘉義','台南','左營','目的地'];
final DateFormat formatter = DateFormat('yyyy/MM/dd');
String? dropDownValue_Start;
String? dropDownValue_End ;
String selectedDate =DateTime.now().toString().substring(0, 10);
String selectTime = DateFormat('HH:mm:ss').format(DateTime.now());

class _THSR_StartEndStationSearchState extends State<THSR_StartEndStationSearch> {


  @override
  Widget build(BuildContext context) {
    var state = Provider.of<stateManager>(context, listen: false);
    var  screenWidth = MediaQuery. of(context). size. width ;

    //根據起訖點搜尋
    getStationList() async{
      var url = dotenv.env['THSR_SearchBy_Date_Stop'].toString() +
          '?OriginStationName=${dropDownValue_Start}&DestinationStationName=${dropDownValue_End}&TrainDate=${selectedDate}';
      var jwt = ',' + state.accountState.toString();
      print(url);
      var response = await api().apiGet(url, jwt);
      if (response.statusCode == 200) {
        setState(() {
          state.updateTHSR_StartEndSearch_StartName(dropDownValue_Start!);
          state.updateTHSR_StartEndSearch_EndName(dropDownValue_End!);
          state.updateTHSR_StartEndSearchResult(jsonDecode(utf8.decode(response.bodyBytes)));
        });
        Future.delayed(Duration(seconds: 1),(){
          Navigator.push(context, MaterialPageRoute(builder: (context) => THSR_StartEndStationSearch_Result()));
        });

      }
    }
    return Scaffold(
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
                        hint: Text('起始地'),
                          value: dropDownValue_Start,
                          items: stopName.map((String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          )).toList(),
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
                          hint: Text('目的地'),
                          value: dropDownValue_End,
                          items: stopName.map((String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(fontSize: 20,color: Colors.white),
                            ),
                          )).toList(),
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
          Container(
            margin: EdgeInsets.only(bottom: 10),
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
                              selectedDate = date.toString().substring(0, 10);
                            });
                          }
                      );
                    },
                    child: Text(selectedDate,style: TextStyle(color:  Color.fromRGBO(24, 60, 126, 1),fontSize: 20),),
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
                            print(DateFormat('HH:mm:ss').format(time));
                            setState(() {
                              selectTime = DateFormat('HH:mm:ss').format(time);
                            });
                          }
                      );
                    },
                    child: Text(selectTime,style: TextStyle(color: Colors.white,fontSize: 20),),
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
                  await getStationList();
                },
                child: Text('搜尋',style: TextStyle(color: Colors.white,fontSize: 20),),
            )
          ),

        ],
      ),
    );
  }
}
