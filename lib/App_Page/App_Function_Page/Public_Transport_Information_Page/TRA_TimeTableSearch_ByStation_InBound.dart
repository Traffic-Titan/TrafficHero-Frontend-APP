// ignore_for_file: deprecated_member_use, file_names, camel_case_types, use_super_parameters, prefer_typing_uninitialized_variables, non_constant_identifier_names, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:traffic_hero/imports.dart';

class TRA_TimeTableSearch_ByStation_InBound extends StatefulWidget {
  const TRA_TimeTableSearch_ByStation_InBound({Key? key}) : super(key: key);

  @override
  State<TRA_TimeTableSearch_ByStation_InBound> createState() =>
      _TRA_TimeTableSearch_ByStation_InBoundState();
}

class _TRA_TimeTableSearch_ByStation_InBoundState
    extends State<TRA_TimeTableSearch_ByStation_InBound> {
  var screenWidth;
  var StationName;
  var DailyTimeTable_Result;
  var state;
  @override
  Widget build(BuildContext context) {
    state = Provider.of<stateManager>(context, listen: false);
    DailyTimeTable_Result = state.TRA_TimeTableSearch_Station_Result_InBound;
    StationName = state.TRA_TimeTableSearch_Station;
    screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          child: const Row(
            children: [
              Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: 10,
                  )),
              Expanded(
                  flex: 3,
                  child: Text(
                    "車號",
                    textScaleFactor: 1.5,
                    style: TextStyle(color: Colors.black),
                  )),
              Expanded(
                  flex: 3,
                  child: Text(
                    "到站時間",
                    textScaleFactor: 1.5,
                    style: TextStyle(color: Colors.black),
                  )),
              Expanded(
                  flex: 2,
                  child: Text(
                    "終點站",
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
                  leading: Container(
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
                  title: Text(
                    list['ArrivalTime'],
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  trailing: Text(
                    list['DestinationStationName'],
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                );
              }),
        ),
      ],
    );
  }
}
