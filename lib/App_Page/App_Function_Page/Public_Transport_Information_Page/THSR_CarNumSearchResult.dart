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
      backgroundColor: Color.fromRGBO(221, 235, 247, 1),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("車次${carNum}"),
      ),
      body: ListView.builder(
          itemCount: carNumSearchDetail.length,
          itemBuilder: (context, index){
            var list = carNumSearchDetail[index];
            return ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 4,
                    child: (index == carNumSearchDetail.length - 1)
                        ?(Image.asset('assets/publicTransportIcon/routeDot.png', height: 35,))
                        :(Image.asset(
                      'assets/publicTransportIcon/routeLine.png',
                      height: 60,
                    )),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(list['停靠站']),
                  ),
                  Expanded(
                      flex: 3,
                      child: Text(list['預估抵達時間'])
                  )
                ],
              ),
            );
          }
      ),
    );
  }
}
