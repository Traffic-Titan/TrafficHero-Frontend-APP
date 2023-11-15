import 'package:flutter_waya/flutter_waya.dart';
import 'package:traffic_hero/Imports.dart';
class THSR_StartEndStationSearch_Result extends StatefulWidget {
  const THSR_StartEndStationSearch_Result({Key? key}) : super(key: key);

  @override
  State<THSR_StartEndStationSearch_Result> createState() => _THSR_StartEndStationSearch_ResultState();
}

class _THSR_StartEndStationSearch_ResultState extends State<THSR_StartEndStationSearch_Result> {
  late stateManager state;


  var THSRDetail_StartName ;
  var THSRDetail_EndName ;
  var THSRDetail ;
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
    THSRDetail_StartName = state.THSR_StartEndSearch_StartName;
    THSRDetail_EndName = state.THSR_StartEndSearch_EndName;
    THSRDetail = state.THSR_StartEndSearchResult;
  }
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(221, 235, 247, 1),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(THSRDetail_StartName+" - "+THSRDetail_EndName),
      ),
      body: Column(
        children: [
          // 標題
          Row(
            children: [
              Expanded(
                  flex: 3,
                  child: Text("車次", textScaleFactor: 1.5, style: TextStyle(color: Colors.black),)
              ),
              Expanded(
                  flex: 4,
                  child: Text("出發時間", textScaleFactor: 1.5, style: TextStyle(color: Colors.black),)
              ),
              Expanded(
                  flex: 3,
                  child: Text("抵達時間", textScaleFactor: 1.5, style: TextStyle(color: Colors.black),)
              ),
            ],
          ),

          // 內容
          Flexible(
            child: ListView.builder(
                itemCount: THSRDetail.length,
                itemBuilder: (context, index){
                  var list = THSRDetail[index];
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
                                child: Text(list['車號'],style: TextStyle(color: Colors.white,fontSize: 20),textAlign: TextAlign.center,),
                              )
                            ),
                            subtitle: Text("自由座車廂：6、7 車廂",style: TextStyle(fontSize: 10)),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(list['出發時間'],style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
                        ),
                        Expanded(
                          flex: 2,
                          child:Icon(Icons.arrow_forward)
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(list['抵達時間'],style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
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
