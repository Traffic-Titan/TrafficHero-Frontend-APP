
import 'package:flutter_waya/flutter_waya.dart';
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
  List<dynamic> content = [];


  void didChangeDependencies() async {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
    screenWidth = MediaQuery. of(context). size. width ;
    screenHeight = MediaQuery. of(context). size. height;
    position = state.positionNow;
    setState(() {
      content = state.nearbyStationBike;
    });
    get_home();
    
  }


  get_home()async{
      await getHome().stationNearbySearchBike(context);
     addMarkers(content);
  }


  //新增標記
  void addMarkers(content) {
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

    for(var i = 0; i<content.length;i++){
       var list = content[i];

        try {
          _markers.add(
            Marker(
                markerId: MarkerId(list['station_name_zh_tw']),
                position: LatLng(list['location']['latitude'],
                    list['location']['longitude']),
                infoWindow: InfoWindow(
                  title: list['station_name_zh_tw'],
                  snippet: '可借 - ' + list['available_rent_bikes'].toString() + ',可還 - ' + list['available_return_bikes'].toString(),
                ),
                onTap: () {
                  // launch();
                  setState(() {});
                }),
          );
          print(i.toString() +
              '標記成功' +
              list['location']['latitude'].toString() +
              list['location']['longitude'].toString());
        } catch (e) {
          print(e);
          print(i.toString() + '標記失敗');
        }
    }

    
  }
  _onMapCreated(GoogleMapController controller){
    _mapController = controller;
  }


//Google Map View
  Widget mapView(){
    return  GoogleMap(
      mapToolbarEnabled: false,
      myLocationButtonEnabled: false,
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: LatLng(state.positionNow.latitude,state.positionNow.longitude),
        zoom: 15.0,
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
          itemCount:0,
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
        
      ],
    );

  }

}






