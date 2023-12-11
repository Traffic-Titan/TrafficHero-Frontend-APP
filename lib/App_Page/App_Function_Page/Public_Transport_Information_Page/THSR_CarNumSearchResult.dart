// ignore_for_file: file_names, camel_case_types, use_super_parameters, prefer_typing_uninitialized_variables, unnecessary_brace_in_string_interps

import 'package:traffic_hero/Imports.dart';

class THSR_CarNumSearchResult extends StatefulWidget {
  const THSR_CarNumSearchResult({Key? key}) : super(key: key);

  @override
  State<THSR_CarNumSearchResult> createState() => _THSR_CarNumSearchResultState();
}

class _THSR_CarNumSearchResultState extends State<THSR_CarNumSearchResult> {
  late stateManager state;
  var carNum;
  var carNumSearchDetail;
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
    carNum = state.THSR_CarNumSearch_CarNum;
    carNumSearchDetail = state.THSR_CarNumSearchResult;
  }
  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(221, 235, 247, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(113, 170, 221, 1),
        iconTheme: const IconThemeData(//返回鍵顏色
          color:Colors.white, //change your color here
        ),
        titleTextStyle: const TextStyle(color: Colors.white,fontSize: 20),
        title: Text("車次${carNum}"),
      ),
      body: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Text('')
              ),
              Expanded(
                flex: 3,
                child: Text('停靠站',style: TextStyle(fontSize: 20,color:  Color.fromRGBO(24, 60, 126, 1)),textAlign: TextAlign.center,)
              ),
              Expanded(
                  flex: 4,
                  child: Text('預估抵達時間',style: TextStyle(fontSize: 20,color:  Color.fromRGBO(24, 60, 126, 1)),textAlign: TextAlign.center,)
              )
            ],
          ),
          Flexible(
              child: ListView.builder(
                  itemCount: carNumSearchDetail.length,
                  itemBuilder: (context, index){
                    var list = carNumSearchDetail[index];
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 3,
                          child: (index == 0)
                              ?(Image.asset('assets/publicTransportIcon/routeDot.png', height: 35,))
                              :(Image.asset('assets/publicTransportIcon/routeLine.png',height: 60,
                          )),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(list['停靠站'],style: const TextStyle(fontSize: 20,color:  Color.fromRGBO(24, 60, 126, 1)),textAlign: TextAlign.center,),
                        ),
                        Expanded(
                            flex: 4,
                            child: Text(list['預估抵達時間'],style: const TextStyle(fontSize: 20,color:  Color.fromRGBO(24, 60, 126, 1)),textAlign: TextAlign.center,)
                        )
                      ],
                    );
                  }
              ),
          )
        ],
      )
    );
  }
}
