import 'package:traffic_hero/imports.dart';

class TRA_TimeTableSearch_ByStation_OutBound extends StatefulWidget {
  const TRA_TimeTableSearch_ByStation_OutBound({Key? key}) : super(key: key);

  @override
  State<TRA_TimeTableSearch_ByStation_OutBound> createState() => _TRA_TimeTableSearch_ByStation_OutBoundState();
}

class _TRA_TimeTableSearch_ByStation_OutBoundState extends State<TRA_TimeTableSearch_ByStation_OutBound> {
    var screenWidth;
    var StationName;
    var DailyTimeTable_Result;
    var state;
  @override
  Widget build(BuildContext context) {
    state = Provider.of<stateManager>(context, listen: false);
    DailyTimeTable_Result = state.TRA_TimeTableSearch_Station_Result_OutBound;
    StationName = state.TRA_TimeTableSearch_Station;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromRGBO(221, 235, 247, 1),
      appBar: AppBar(
        title: Text(StationName+"車站"),
        backgroundColor: Color.fromRGBO(113, 170, 221, 1),
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Container(
            child: Row(
              children: [
                Icon(Icons.add_business,size: 20,),
                Text("山線"),
                Icon(Icons.add_business,size: 20,),
                Text("海線"),
                Icon(Icons.add_business,size: 20,),
                Text("身障座"),
                Icon(Icons.add_business,size: 20,),
                Text("哺乳室"),
                Icon(Icons.add_business,size: 20,),
                Text("每日行駛"),
                Icon(Icons.add_business,size: 20,),
                Text("便當"),
              ],
            ),
          ),
          Divider(),
          Container(
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Text("車號", textScaleFactor: 1.5, style: TextStyle(color: Colors.black),)
                ),
                Expanded(
                    flex: 3,
                    child: Text("到站時間", textScaleFactor: 1.5, style: TextStyle(color: Colors.black),)
                ),
                Expanded(
                    flex: 3,
                    child: Text("終點站", textScaleFactor: 1.5, style: TextStyle(color: Colors.black),)
                ),
                Expanded(
                    flex: 2,
                    child: Text("車種", textScaleFactor: 1.5, style: TextStyle(color: Colors.black),)
                ),
              ],
            ),
          ),
          Divider(),
          // 內容
          Flexible(
            child: ListView.builder(
                itemCount: DailyTimeTable_Result.length,
                itemBuilder: (context, index){
                  var list = DailyTimeTable_Result[index];
                  return ListTile(
                    title: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: ListTile(
                            title: Container(
                                height: 30,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromRGBO(24, 60, 126, 1),
                                  ),
                                  child: Text(list['TrainNo'],style: TextStyle(color: Colors.white,fontSize: 20),textAlign: TextAlign.center,),
                                )
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(list['ArrivalTime'],style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(list['DestinationStationName'],style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(list['TrainTypeName'],style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
                        ),
                      ],
                    ),
                  );
                }
            ),
          ),
        ],
      ),
    );
  }
}
