import 'package:traffic_hero/imports.dart';

class BusRouteDetail extends StatefulWidget {
  const BusRouteDetail({Key? key}) : super(key: key);

  @override
  State<BusRouteDetail> createState() => _BusRouteDetailState();
}
var routeDetail;

class _BusRouteDetailState extends State<BusRouteDetail> {
  late stateManager state;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
    routeDetail = state.busRouteDetail.toString();
    setState(() {
      routeDetail;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(221, 235, 247, 1),
      appBar: new AppBar(
        backgroundColor: const Color.fromRGBO(113, 170, 221, 1),
      ),
      body: new Column(
        children: [
          Text(routeDetail),
        ],
      ),
    );

  }
}
