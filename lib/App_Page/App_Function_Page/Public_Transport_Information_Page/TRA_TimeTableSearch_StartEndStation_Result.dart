// ignore_for_file: deprecated_member_use, file_names, camel_case_types, prefer_typing_uninitialized_variables, non_constant_identifier_names, avoid_unnecessary_containers

import 'package:traffic_hero/imports.dart';

class TRA_TimeTableSearch_StartEndStation_Result extends StatefulWidget {
  const TRA_TimeTableSearch_StartEndStation_Result({super.key});

  @override
  State<TRA_TimeTableSearch_StartEndStation_Result> createState() =>
      _TRA_TimeTableSearch_StartEndStation_ResultState();
}

class _TRA_TimeTableSearch_StartEndStation_ResultState
    extends State<TRA_TimeTableSearch_StartEndStation_Result> {
  var screenWidth;
  var StartStation;
  var EndStation;
  var DailyTimeTable_Result;
  var state;
  @override
  Widget build(BuildContext context) {
    state = Provider.of<stateManager>(context, listen: false);
    DailyTimeTable_Result = state.TRA_TimeTableSearch_StartEndStation_Result;
    StartStation = state.TRA_TimeTableSearch_StartStation;
    EndStation = state.TRA_TimeTableSearch_EndStation;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(221, 235, 247, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(113, 170, 221, 1),
        iconTheme: const IconThemeData(
          //返回鍵顏色
          color: Colors.white, //change your color here
        ),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        title: Text(StartStation + "　－　" + EndStation),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            child: const Row(
              children: [
                Icon(
                  Icons.add_business,
                  size: 20,
                ),
                Text("山線"),
                Icon(
                  Icons.add_business,
                  size: 20,
                ),
                Text("海線"),
                Icon(
                  Icons.add_business,
                  size: 20,
                ),
                Text("身障座"),
                Icon(
                  Icons.add_business,
                  size: 20,
                ),
                Text("哺乳室"),
                Icon(
                  Icons.add_business,
                  size: 20,
                ),
                Text("每日行駛"),
                Icon(
                  Icons.add_business,
                  size: 20,
                ),
                Text("便當"),
              ],
            ),
          ),
          const Divider(),
          Container(
            child: const Row(
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: 10,
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Text(
                      "車次",
                      textScaleFactor: 1.5,
                      style: TextStyle(color: Colors.black),
                    )),
                Expanded(
                    flex: 3,
                    child: Text(
                      "出發時間",
                      textScaleFactor: 1.5,
                      style: TextStyle(color: Colors.black),
                    )),
                Expanded(
                    flex: 3,
                    child: Text(
                      "抵達時間",
                      textScaleFactor: 1.5,
                      style: TextStyle(color: Colors.black),
                    )),
                Expanded(
                    flex: 2,
                    child: Text(
                      "票價",
                      textScaleFactor: 1.5,
                      style: TextStyle(color: Colors.black),
                    )),
              ],
            ),
          ),
          const Divider(height: 5, color: Color.fromRGBO(24, 60, 126, 1)),
          // 內容
          Flexible(
            child: ListView.builder(
                itemCount: DailyTimeTable_Result.length,
                itemBuilder: (context, index) {
                  var list = DailyTimeTable_Result[index];
                  return ListTile(
                    minVerticalPadding: 15,
                    leading: SizedBox(
                        height: 50,
                        width: 80,
                        child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: (list['TrainTypeName']
                                      .toString()
                                      .contains('區間'))
                                  ? const Color.fromRGBO(24, 60, 126, 1)
                                  : Colors.red,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  list['TrainNo'],
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  list['TrainTypeName'],
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 13),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ))),
                    title: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            list['StopTimes'][0]['ArrivalTime'],
                            style: const TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Icon(Icons.arrow_forward),
                                // Text(list['Duration'])
                              ],
                            )),
                        Expanded(
                          flex: 2,
                          child: Text(
                            list['StopTimes'][list['StopTimes'].length - 1]
                                ['ArrivalTime'],
                            style: const TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    trailing: Text(
                      list['Fare'],
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
