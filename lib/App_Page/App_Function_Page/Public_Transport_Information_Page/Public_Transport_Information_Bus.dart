// ignore_for_file: file_names, prefer_interpolation_to_compose_strings, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:traffic_hero/App_Page/App_Function_Page/Public_Transport_Information_Page/Bus_RouteSearch.dart';
import 'package:traffic_hero/App_Page/App_Function_Page/Public_Transport_Information_Page/Bus_StationMap.dart';
import 'package:traffic_hero/Imports.dart';

//公車頁面
Widget publicTransportInfoBus(context) {
  var state = Provider.of<stateManager>(context, listen: false);
  var screenWidth = MediaQuery.of(context).size.width;

  //附近站點
  Widget nearbyStation() {
    return Card(
      color: const Color.fromARGB(255, 255, 255, 255),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
      ),
      elevation: 1,
      child: SizedBox(
        height: 250,
        width: screenWidth - 30 > 600 ? 600 : screenWidth - 30,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14.0),
                topRight: Radius.circular(14.0),
              ),
              child: Container(
                height: 30,
                color: const Color.fromRGBO(67, 150, 200, 1),
                width: screenWidth - 30 > 600 ? 600 : screenWidth - 30,
                alignment: Alignment.center,
                child: const Text(
                  '附近站點',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: (state.nearbyStationBus.length == 0)
                      ? 0
                      : state.nearbyStationBus.length - 1,
                  itemBuilder: (context, index) {
                    var list = state.nearbyStationBus[index];
                    return ListTile(
                      leading: Container(
                        width: 75,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 3.0),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(14.0),
                            topRight: Radius.circular(14.0),
                            bottomLeft: Radius.circular(14.0),
                            bottomRight: Radius.circular(14.0),
                          ),
                        ),
                        child: Text(
                          (() {
                            if (list['預估到站時間 (min)'] == '0') {
                              return "進站中";
                            }
                            return list['預估到站時間 (min)'] + '分';
                          })(),
                          style: const TextStyle(fontSize: 23),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      title: Column(children: [
                        Text(list['路線名稱'] + '( 即將抵達：' + list['站點名稱'] + ' )',
                            textAlign: TextAlign.left),
                        Text('往 ' + list['終點站'], textAlign: TextAlign.left),
                      ]),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  return Scaffold(
    backgroundColor: const Color.fromRGBO(230, 240, 255, 1),
    body: SingleChildScrollView(
        child: Center(
      child: Column(children: [
        nearbyStation(),
        const SizedBox(
          height: 10,
        ),
        Container(
          child: Column(
            children: [
              Container(
                width: screenWidth * 0.9,
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(165, 201, 233, 1)),
                      side: MaterialStateProperty.all(const BorderSide(
                          color: Color.fromRGBO(29, 73, 153, 1), width: 4)),
                      minimumSize: MaterialStateProperty.all(Size(
                          screenWidth - 30 > 600 ? 600 : screenWidth - 30, 50)),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BusRouteSearch()));
                    },
                    child: const ListTile(
                        leading: Icon(
                          Icons.directions_bus_sharp,
                          size: 40,
                          color: Color.fromRGBO(29, 73, 153, 1),
                        ),
                        title: Text(
                          '公車/客運路線搜尋',
                          style: TextStyle(
                              color: Color.fromRGBO(29, 73, 153, 1),
                              fontSize: 20),
                          textAlign: TextAlign.left,
                        ))),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: screenWidth * 0.9,
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(165, 201, 233, 1)),
                      side: MaterialStateProperty.all(const BorderSide(
                          color: Color.fromRGBO(29, 73, 153, 1), width: 4)),
                      minimumSize: MaterialStateProperty.all(Size(
                          screenWidth - 30 > 600 ? 600 : screenWidth - 30, 50)),
                    ),
                    onPressed: () {
                      //站點地圖
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const StationMap_Bus()));
                    },
                    child: const ListTile(
                        leading: Icon(
                          Icons.map_rounded,
                          size: 40,
                          color: Color.fromRGBO(29, 73, 153, 1),
                        ),
                        title: Text(
                          '站點地圖',
                          style: TextStyle(
                              color: Color.fromRGBO(29, 73, 153, 1),
                              fontSize: 20),
                          textAlign: TextAlign.left,
                        ))),
              ),
              // Container(
              //   padding: EdgeInsets.only(left: 30,right: 30),
              //   child: ElevatedButton(
              //       style: ButtonStyle(
              //         backgroundColor: MaterialStateProperty.all(Color.fromRGBO(165, 201, 233, 1)),
              //         side: MaterialStateProperty.all(BorderSide(color: Color.fromRGBO(29, 73, 153, 1),width: 3)),
              //         minimumSize: MaterialStateProperty.all(Size(screenWidth - 30 > 600 ? 600 : screenWidth - 30, 50)),
              //       ),
              //       onPressed: (){
              //         //我的收藏
              //       },
              //       child: ListTile(
              //           leading: Icon(Icons.heart,size: 50,color: Color.fromRGBO(29, 73, 153, 1),),
              //           title: Text('我的收藏',style: TextStyle(color: Color.fromRGBO(29, 73, 153, 1),fontSize: 25),textAlign:TextAlign.left,)
              //       )
              //   ),
              // ),
            ],
          ),
        ),
      ]),
    )),
  );
}
