// ignore_for_file: file_names, prefer_typing_uninitialized_variables, non_constant_identifier_names, camel_case_types, unnecessary_brace_in_string_interps, avoid_print

import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
import 'package:traffic_hero/App_Page/App_Function_Page/Public_Transport_Information_Page/TRA_TimeTableSearch_CarNum_Result.dart';
import 'package:traffic_hero/imports.dart';

var carNum;
String dateTime_date = DateTime.now().toString().substring(0, 10);
String dateTime_time = DateFormat('HH:mm').format(DateTime.now());

class TRA_TimeTableSearch_CarNumSearch extends StatefulWidget {
  const TRA_TimeTableSearch_CarNumSearch({super.key});

  @override
  State<TRA_TimeTableSearch_CarNumSearch> createState() =>
      _TRA_TimeTableSearch_CarNumSearchState();
}

class _TRA_TimeTableSearch_CarNumSearchState
    extends State<TRA_TimeTableSearch_CarNumSearch> {
  @override
  Widget build(BuildContext context) {
    var state = Provider.of<stateManager>(context, listen: false);
    var screenWidth = MediaQuery.of(context).size.width;
    //根據車次取得火車時刻表
    getStationTimeTableByNum() async {
      var url =
          '${dotenv.env['TRA_DailyTimeTable_ByCarNum']}?CarNum=${carNum}&TrainDate=${dateTime_date}';
      var jwt = ',${state.accountState}';
      print(url);
      var response = await api().apiGet(url, jwt);
      if (response.statusCode == 200) {
        print(jsonDecode(utf8.decode(response.bodyBytes)));
        var TrainTypeName =
            jsonDecode(utf8.decode(response.bodyBytes))[0]['TrainTypeName'];
        setState(() {
          state.updateTRA_TimeTableSearch_CarNum(carNum);
          state.updateTRA_TimeTableSearch_CarType(TrainTypeName);
          state.updateTRA_TimeTableSearch_CarNum_Result(
              jsonDecode(utf8.decode(response.bodyBytes))[0]['StopTimes']);
        });
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const TRA_TimeTableSearch_CarNum_Result()));
        });
      }
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(221, 235, 247, 1),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10, top: 10),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(165, 201, 233, 1),
              borderRadius: BorderRadius.all(Radius.circular(14)),
            ),
            width: screenWidth - 30 > 600 ? 600 : screenWidth - 30,
            child: const Text(
              '車次查詢',
              style: TextStyle(
                  color: Color.fromRGBO(29, 73, 153, 1), fontSize: 25),
              textAlign: TextAlign.center,
            ),
          ),
          //輸入車次框
          SizedBox(
              width: screenWidth - 30 > 600 ? 600 : screenWidth - 30,
              height: 60,
              child: TextField(
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  fillColor: Color.fromRGBO(221, 235, 247, 1),
                  hintText: "輸入車次",
                  hintStyle: TextStyle(
                      color: Color.fromRGBO(24, 60, 126, 1), fontSize: 20),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2, color: Color.fromRGBO(24, 60, 126, 1)),
                  ),
                ),
                onChanged: (text) {
                  carNum = text;
                },
              )),
          Container(
            margin: const EdgeInsets.only(bottom: 10, top: 10),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(165, 201, 233, 1),
              borderRadius: BorderRadius.all(Radius.circular(14)),
            ),
            width: screenWidth - 30 > 600 ? 600 : screenWidth - 30,
            child: const Text(
              '日期時間',
              style: TextStyle(
                  color: Color.fromRGBO(29, 73, 153, 1), fontSize: 25),
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10, right: 5),
                width: screenWidth * 0.6,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromRGBO(24, 60, 126, 1),
                          width: 2),
                      borderRadius: BorderRadius.circular(15),
                      color: const Color.fromRGBO(221, 235, 247, 1)),
                  child: TextButton(
                    onPressed: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          maxTime:
                              DateTime.now().add(const Duration(days: 120)),
                          minTime: DateTime.now(), onConfirm: (date) async {
                        setState(() {
                          dateTime_date = date.toString().substring(0, 10);
                        });
                      });
                    },
                    child: Text(
                      dateTime_date,
                      style: const TextStyle(
                          color: Color.fromRGBO(24, 60, 126, 1), fontSize: 20),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 5, right: 10),
                width: screenWidth * 0.4,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromRGBO(24, 60, 126, 1),
                          width: 2),
                      borderRadius: BorderRadius.circular(15),
                      color: const Color.fromRGBO(24, 60, 126, 1)),
                  child: TextButton(
                    onPressed: () {
                      DatePicker.showTime12hPicker(context,
                          showTitleActions: true, onConfirm: (time) async {
                        print(DateFormat('HH:mm').format(time));
                        setState(() {
                          dateTime_time =
                              DateFormat('HH:mm').format(time).toString();
                        });
                      });
                    },
                    child: Text(
                      dateTime_time,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
              margin: const EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(24, 60, 126, 1),
                borderRadius: BorderRadius.all(Radius.circular(14)),
              ),
              width: screenWidth - 30 > 600 ? 600 : screenWidth - 30,
              child: TextButton(
                onPressed: () async {
                  await getStationTimeTableByNum();
                },
                child: const Text(
                  '搜尋',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )),
        ],
      ),
    );
  }
}
