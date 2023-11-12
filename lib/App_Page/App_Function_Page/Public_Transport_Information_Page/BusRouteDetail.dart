import 'package:traffic_hero/imports.dart';

class BusRouteDetail extends StatefulWidget {
  const BusRouteDetail({Key? key}) : super(key: key);

  @override
  State<BusRouteDetail> createState() => _BusRouteDetailState();
}

var routeDetail;
var routeDetail_Array = [];

class _BusRouteDetailState extends State<BusRouteDetail> {
  late stateManager state;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
    routeDetail_Array = state.busRouteDetail as List;
    setState(() {
      // routeDetail;
      routeDetail_Array;
    });
  }
  // 回傳下一站的箭頭符號，並判斷是否為最終站
  // IconData? arrowReturn(element,List<dynamic> list){
  //   if(list.last == element){
  //     return null;
  //   }
  //   return CupertinoIcons.arrow_down_square_fill;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(221, 235, 247, 1),
      appBar: new AppBar(
        // 公車路線名稱
        // title: Text(),
        backgroundColor: const Color.fromRGBO(113, 170, 221, 1),
      ),
      body: ListView.builder(
        itemCount: routeDetail_Array.length,
        itemBuilder: (context, index) {
          var data = routeDetail_Array[index];
          return ListTile(
              title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Text(data['StopName']),
              ),
              Expanded(
                flex: 4,
                child: (index == routeDetail_Array.length - 1)
                    ? (Image.asset(
                        'assets/publicTransportIcon/routeDot.png',
                        height: 35,
                      ))
                    : (Image.asset(
                        'assets/publicTransportIcon/routeLine.png',
                        height: 60,
                      )),
              ),
              Expanded(
                flex: 3,
                child: (data['EstimateTime'] == '未發車')
                    ? (Text(data['EstimateTime']))
                    : (Text(data['EstimateTime'].toString() + "分 到站")),
              ),
            ],
          ));
        },
      ),
    );
  }
}
