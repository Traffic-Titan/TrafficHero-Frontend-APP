
import 'package:traffic_hero/Imports.dart';

class publicTransportInfoBike extends StatefulWidget {
  const publicTransportInfoBike({super.key});

  @override
  State<publicTransportInfoBike> createState() => _publicTransportInfoBikeState();
}

class _publicTransportInfoBikeState extends State<publicTransportInfoBike> {
  late stateManager state;
  var position ;
  var screenWidth;
  var screenHeight;
  // ignore: unused_field
  late GoogleMapController _mapController;
  final Set<Marker> _markers = Set<Marker>();
  var draggleHeight=0.3;

  void didChangeDependencies() async {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
    screenWidth = MediaQuery. of(context). size. width ;
    screenHeight = MediaQuery. of(context). size. height;
    position = state.positionNow;
    addMarkers();
  }

  //新增標記
  void addMarkers() {
    print(position.toString());
    _markers.clear();
    // 目前位置標記
    _markers.add(
        Marker(
          markerId: MarkerId('目前位置'),
          position: LatLng(position.latitude,position.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(223),
          infoWindow: InfoWindow(
              title: '目前位置'
          ),
        )
    );
    // 添加標記
    for (int i=0;i <state.nearbyStationBike.length;i++) {
      var list = state.nearbyStationBike[i];
      print('${list['公共自行車']['LocationY'].toString()},${list['公共自行車']['LocationX'].toString()}');
      _markers.add(
        Marker(
          markerId: MarkerId(list['公共自行車']['StationUID']),
          position: LatLng(list['公共自行車']['LocationY'],list['公共自行車']['LocationX']),
          infoWindow: InfoWindow(
              title: list['公共自行車']['StationName'].substring(11),
              snippet: '可借:${list['可借車位']}/可還:${list['剩餘空位']}'
          ),
        ),
      );
    }
  }
  _onMapCreated(GoogleMapController controller){
    _mapController = controller;
  }


//Google Map View
  Widget mapView(){
    return  GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: LatLng(state.positionNow.latitude,state.positionNow.longitude),
        zoom: 11.0,
      ),
      markers: _markers,
    );
  }


  //附近站點
  Widget nearbyStation(scrollController){
    return SizedBox(
      width:  screenWidth * 0.85,
      child:ListView.builder(
          controller: scrollController,
          itemCount:(state.nearbyStationBike == null ) ? 0 : state.nearbyStationBike.length-1,
          itemBuilder: (context, index) {
            var list = state.nearbyStationBike[index];
            return InkWell(
              child: ListTile(
                leading:Container(
                  width: screenWidth * 0.5,
                  child:Text(list['公共自行車']['StationName'].substring(11),style: TextStyle(fontSize: 23,color: Color.fromRGBO(0, 32, 96, 1)),overflow: TextOverflow.ellipsis, ),
                ),
                title:Row(
                  children: [
                    Container(
                      width: screenWidth * 0.1,
                      child:Text(list['可借車位'].toString(),style: TextStyle(fontSize: 23,color: Colors.red),),
                    ),
                    Container(
                      width: screenWidth * 0.1,
                      child:Text(list['剩餘空位'].toString(),style: TextStyle(fontSize: 23,color: Colors.blueAccent),),
                    )
                  ],
                ) ,
              ),
              onTap: (){

              },
            );
          }
      ),
    );
  }
  void openSheet(h){
    setState(() {
      draggleHeight = h;
    });
  }
  @override
  //腳踏車頁面
  Widget build(BuildContext context) {
    return Stack(
      children: [
        mapView(),
        DraggableScrollableSheet(
          builder: (BuildContext context,ScrollController scrollController) {
            return Container(
              color: Color.fromRGBO(222, 235, 247, 1),
              padding: EdgeInsets.only(right: 15,left: 15),
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  SizedBox(
                    width:30,
                    height: 8,
                    child: ElevatedButton(
                      onPressed: () {
                        openSheet(0.5);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50)),
                      ),

                    ),
                  ),
                  Expanded(
                      child: ListView(
                        controller: scrollController,
                        children: [
                          Container(
                              width:  screenWidth * 0.9,
                              child: Column(
                                children: [
                                  TextField(
                                    decoration: InputDecoration(
                                      hintText: '搜尋站點',
                                      hintStyle: TextStyle(color: Color.fromRGBO(47, 125, 195, 1),),
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    color: Color.fromRGBO(47, 125, 195, 1),
                                    padding: EdgeInsets.only(left: 18),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: screenWidth * 0.55,
                                          child: Text('附近站點',style:TextStyle(color: Colors.white,fontSize: 20),),
                                        ),
                                        Container(
                                          width: screenWidth * 0.1,
                                          child: Text('可歸還數',style:TextStyle(color: Colors.white,),),
                                        ),
                                        Container(
                                          width: screenWidth * 0.1,
                                          child: Text('可租借數',style:TextStyle(color: Colors.white,),),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                          ),

                        ],
                      ),

                  ),
                  Expanded(child: nearbyStation(scrollController),),
                ],
            )

            );
          },
          initialChildSize: draggleHeight, // 初始高度比例
          minChildSize: 0.1, // 最小高度比例
          maxChildSize: 1,
          // 最大高度比例
        ),
      ],
    );

  }

}






