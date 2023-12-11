// ignore_for_file: unused_field, file_names, camel_case_types, prefer_typing_uninitialized_variables, prefer_collection_literals, avoid_print

import 'package:traffic_hero/Imports.dart';
class Road_Information_ParkingLot extends StatefulWidget {
  const Road_Information_ParkingLot({super.key});

  @override
  State<Road_Information_ParkingLot> createState() => _Road_Information_ParkingLotState();
}

class _Road_Information_ParkingLotState extends State<Road_Information_ParkingLot> {
  late stateManager state;
  var position ;
  var screenWidth;
  var screenHeight;
  late GoogleMapController _mapController;
  final Set<Marker> _markers = Set<Marker>();
  var draggleHeight=0.3;

  @override
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
          markerId: const MarkerId('目前位置'),
          position: LatLng(position.latitude,position.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(223),
          infoWindow: const InfoWindow(
              title: '目前位置'
          ),
        )
    );
    // 添加標記


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


  void openSheet(h){
    setState(() {
      draggleHeight = h;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        mapView(),
      ],
    );
  }
}
