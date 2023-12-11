// ignore_for_file: file_names, prefer_typing_uninitialized_variables, use_super_parameters, non_constant_identifier_names, avoid_print, unnecessary_new, prefer_interpolation_to_compose_strings

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
    print(routeDetail_Array);
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
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromRGBO(113, 170, 221, 1),
      ),
      body: ListView.builder(
        itemCount: routeDetail_Array.length,
        itemBuilder: (context, index) {
          var data = routeDetail_Array[index];
          return ListTile(
            minVerticalPadding:0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 5,
                    child: Text(data['StopName'],textAlign: TextAlign.right,),
                  ),
                  Expanded(
                    flex: 2,
                    child: (index == 0)
                        ?(Image.asset('assets/publicTransportIcon/routeDot.png', height: 35,))
                        :(Image.asset('assets/publicTransportIcon/routeLine.png',height: 60,
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
