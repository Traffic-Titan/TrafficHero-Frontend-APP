// ignore_for_file: camel_case_types, library_private_types_in_public_api, file_names, unused_import, override_on_non_overriding_member, prefer_typing_uninitialized_variables, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:traffic_hero/App_Page/App_Function_Page/Road_Information/Road_Information_ParkingLot.dart';
import 'package:traffic_hero/imports.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart'; // Make sure to import the correct package
import 'package:traffic_hero/Components/Tool.dart' as Tool;

class Road_Information extends StatefulWidget {
  const Road_Information({Key? key}) : super(key: key);

  @override
  _Road_InformationState createState() => _Road_InformationState();
}

class _Road_InformationState extends State<Road_Information> {
  late stateManager state;
  var position;
  var screenWidth;
  var screenHeight;
  var positionNow;
  late GoogleMapController _mapController;
  final Set<Marker> _markers = Set<Marker>();
  //欲篩選的路況
  final List<String> _filterRoadInfoItems =[];


  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
    positionNow = state.positionNow;
    screenWidth = MediaQuery. of(context). size. width ;
    screenHeight = MediaQuery. of(context). size. height;
    position = await geolocator().updataPosition();

  }
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
//新增標記
  void addPositionNowMarkers() {
    print(position.toString());
    _markers.clear();
    // 目前位置標記
    Marker marker =
        Marker(
          markerId: MarkerId('目前位置'),
          position: LatLng(state.positionNow.latitude,state.positionNow.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(223),
          infoWindow: InfoWindow(
              title: '目前位置'
          ),
        );
    setState(() {
    _markers.add(marker);
    });
  }
  _onMapCreated(GoogleMapController controller){
    _mapController = controller;
  }

  //Google Map View
  Widget mapView(){
    return  GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition:CameraPosition(
        target: LatLng(state.positionNow.latitude,state.positionNow.longitude),
        zoom: 11,
      ),
      markers: _markers,

      //點擊可抓取對應地點經緯度
      // onTap: (LatLng latLng) {
      //   print('Tapped at: $latLng');
      //   // 在这里您可以处理点击事件，获取latLng变量的坐标信息
      // },
      //移動可抓取對應地點經緯度
      // onCameraMove: (CameraPosition position){
      //   print('Tapped at: ${position.target.longitude}');
      // },
    );
  }
  //定位及篩選路況按鈕
  Widget floatingBtn(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          child: Icon(Icons.location_searching),
          backgroundColor: Color.fromRGBO(33, 84, 144, 1),
          onPressed: () {
            //回到所在位置並標記
            _goToPositionNow();
            addPositionNowMarkers();
          },
        ),
        SizedBox(width: 10,),
        FloatingActionButton(
          child: Icon(Icons.line_weight),
          backgroundColor: Color.fromRGBO(33, 84, 144, 1),
          onPressed: () {
            roadInfoFilter(context);
          },
        ),
      ],
    );
  }
  //定位按鈕
  Future<void> _goToPositionNow() async {
    CameraPosition _positionNow= CameraPosition(
      target: LatLng(state.positionNow.latitude,state.positionNow.longitude),
      zoom: 20,
    );
    await _mapController.animateCamera(CameraUpdate.newCameraPosition(_positionNow));
  }
  void _filterRoadInfoItemsChange(item,isSelected){
      if(isSelected){
        setState(() {
          _filterRoadInfoItems.add(item);
        });
      }else{
        setState(() {
          _filterRoadInfoItems.remove(item);
        });
      }
  }
  //篩選路況
  Future<void> roadInfoFilter(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            scrollable: true,
            title: Text('選擇欲顯示路況'),
            content:SingleChildScrollView(
              child: ListBody(
                  children: Tool.roadInfoFilterList
                  .map((item)=> CheckboxListTile(
                    value:_filterRoadInfoItems.contains(item),
                    title:Text(item),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged:(isChecked) {
                      _filterRoadInfoItemsChange(item,isChecked!);
                    },
                  ))
                  .toList(),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('取消'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('確定'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mapView(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: floatingBtn(),

    );
  }



}
