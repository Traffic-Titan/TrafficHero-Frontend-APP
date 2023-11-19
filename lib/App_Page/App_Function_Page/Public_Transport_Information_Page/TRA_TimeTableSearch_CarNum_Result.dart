import 'package:traffic_hero/imports.dart';

class TRA_TimeTableSearch_CarNum_Result extends StatefulWidget {
  const TRA_TimeTableSearch_CarNum_Result({Key? key}) : super(key: key);

  @override
  State<TRA_TimeTableSearch_CarNum_Result> createState() => _TRA_TimeTableSearch_CarNum_ResultState();
}

class _TRA_TimeTableSearch_CarNum_ResultState extends State<TRA_TimeTableSearch_CarNum_Result> {
  var state;
  var screenWidth;
  var CarNum;
  var CarType;
  var DailyTimeTable_Result;
  @override
  Widget build(BuildContext context) {
    state = Provider.of<stateManager>(context, listen: false);
    screenWidth = MediaQuery. of(context). size. width ;
    DailyTimeTable_Result = state.TRA_TimeTableSearch_CarNum_Result;
    CarNum = state.TRA_TimeTableSearch_CarNum;
    CarType = state.TRA_TimeTableSearch_CarType;

    return Scaffold(
      backgroundColor: Color.fromRGBO(221, 235, 247, 1),
      appBar:AppBar(
        title:Text(CarNum+" "+CarType) ,
        backgroundColor: Color.fromRGBO(113, 170, 221, 1),
      ),
      body: Column(
        children: [

          SizedBox(height: 10,),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Text("", textScaleFactor: 1.5, style: TextStyle(color: Colors.black),)
              ),
              Expanded(
                  flex: 2,
                  child: Text("站名", textScaleFactor: 1.5, style: TextStyle(color: Colors.black),)
              ),
              Expanded(
                  flex: 2,
                  child: Text("出發時間", textScaleFactor: 1.5, style: TextStyle(color: Colors.black),)
              ),
              Expanded(
                  flex: 1,
                  child: Text("", textScaleFactor: 1.5, style: TextStyle(color: Colors.black),)
              ),
              Expanded(
                  flex: 2,
                  child: Text("抵達時間", textScaleFactor: 1.5, style: TextStyle(color: Colors.black),)
              ),
            ],
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
                                child: Text(list['StationName']['Zh_tw'],style: TextStyle(color: Colors.black,fontSize: 20),textAlign: TextAlign.center,),
                              )
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(list['ArrivalTime'],style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
                        ),
                        // Expanded(
                        //     flex: 1,
                        //     child:Icon(Icons.arrow_forward)
                        // ),
                        Expanded(
                          flex: 310,
                          child: Text(list['DepartureTime'],style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
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