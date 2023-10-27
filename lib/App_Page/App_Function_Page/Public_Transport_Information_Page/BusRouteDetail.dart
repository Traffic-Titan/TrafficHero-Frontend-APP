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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(221, 235, 247, 1),
      appBar: new AppBar(
        // 公車路線名稱
        // title: Text(),
        backgroundColor: const Color.fromRGBO(113, 170, 221, 1),
      ),
      body:
        ListView.builder(
          itemCount: routeDetail_Array.length,
          itemBuilder: (context,index){
            var data = routeDetail_Array[index];
            return ListTile(
              title: Column(
                children: [
                  Column(
                    children: [
                      Text(data['StopName']),
                      Text("預估到站時間："+data['EstimateTime'].toString()),
                    ],
                  )
                ],
              ),
            );
          },
        )
    );
  }
}
