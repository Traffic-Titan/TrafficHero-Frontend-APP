import 'package:traffic_hero/imports.dart';
class StationMap_Bus extends StatefulWidget {
  const StationMap_Bus({Key? key}) : super(key: key);

  @override
  State<StationMap_Bus> createState() => _StationMap_BusState();
}

class _StationMap_BusState extends State<StationMap_Bus> {
  late stateManager state;
  var position ;
  var screenWidth;
  var screenHeight;
  // ignore: unused_field
  late GoogleMapController _mapController;
  final Set<Marker> _markers = Set<Marker>();
  var draggleHeight=0.3;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        mapView(),
      ],
    );
  }
  void didChangeDependencies() async {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
    screenWidth = MediaQuery. of(context). size. width ;
    screenHeight = MediaQuery. of(context). size. height;
    position = state.positionNow;
    addMarkers();
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

  //新增標記
  void addMarkers() {
    _markers.clear();
    // 目前位置標記
    _markers.add(
      Marker(
        markerId: MarkerId('目前位置'),
        position: LatLng(position.latitude, position.longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(223),
        infoWindow: InfoWindow(
            title: '目前位置'
        ),
      )
    );
    // 添加標記
    for (int i=0;i <state.nearbyStationBus.length;i++) {
      var list = state.nearbyStationBus[i];
      print(list);
      // _markers.add(
      //   Marker(
      //     markerId: MarkerId(list['公共自行車']['StationUID']),
      //     position: LatLng(list['公共自行車']['LocationY'],list['公共自行車']['LocationX']),
      //     infoWindow: InfoWindow(
      //         title: list['公共自行車']['StationName'].substring(11),
      //         snippet: '可借:${list['可借車位']}/可還:${list['剩餘空位']}'
      //     ),
      //   ),
      // );
    }
  }
}
