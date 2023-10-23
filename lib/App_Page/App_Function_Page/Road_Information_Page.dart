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
  var parkingInfoList;
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
    searchParkingInfo();
  }
  @override
  void initState() {
    super.initState();

  }
  @override
  void dispose() {
    super.dispose();
  }
  //取得停車位資訊
  searchParkingInfo() async {
    print('取得停車位資訊');
    // EasyLoading.show(status: '儲存中');
    var url = dotenv.env['ParkingInfo'];
    var jwt = ',' + state.accountState;
    var response;
    try {
      response = await api().apiGet(url, jwt);
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        print('取得成功');
          parkingInfoList = responseBody;
      }
    } catch (e) {
      print(e);
    }
  }

//新增目前位置標記
  void addPositionNowMarkers() {
    // 目前位置標記
    _markers.add(Marker(
      markerId: MarkerId('目前位置'),
      position: LatLng(state.positionNow.latitude,state.positionNow.longitude),
      icon: BitmapDescriptor.defaultMarkerWithHue(223),
      infoWindow: InfoWindow(
          title: '目前位置'
      ),
    )
    );
  }
  //新增路況標記
  void addRoadInfoMarkers() {
    print(position.toString());
    _markers.clear();
    Marker marker;
    // 目前位置標記
    for(String s in _filterRoadInfoItems){
      switch(s){
        case '停車場資訊':
          print('add停車場資訊');
          for(int i =0;i< parkingInfoList.length;i++){
            marker=Marker(
                  markerId: MarkerId(parkingInfoList[i]['CarParkName']),
                  position: LatLng(parkingInfoList[i]['Latitude'],parkingInfoList[i]['Longitude']),
                  // icon: BitmapDescriptor.defaultMarkerWithHue(223),
                  infoWindow: InfoWindow(
                      title: parkingInfoList[i]['Address'],
                      snippet: '總車位:${parkingInfoList[i]['TotalSpace'].toString()}'
                  ),
                );
            setState(() {
              _markers.add(marker);
            });
          }
        case '道路施工':
          print('add道路施工');
        case '交通事故':
          print('add交通事故');
        case '道路管制':
          print('add道路管制');
        case '道路壅塞':
          print('add道路壅塞');
        default:
          _markers.add(Marker(
            markerId: MarkerId('目前位置'),
            position: LatLng(state.positionNow.latitude,state.positionNow.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(223),
            infoWindow: InfoWindow(
                title: '目前位置'
            ),
          ));
      }
    }
    // _markers.add(Marker(
    //   markerId: MarkerId('目前位置'),
    //   position: LatLng(state.positionNow.latitude,state.positionNow.longitude),
    //   icon: BitmapDescriptor.defaultMarkerWithHue(223),
    //   infoWindow: InfoWindow(
    //       title: '目前位置'
    //   ),
    //   )
    // );
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
      zoom: 15,
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
                  addRoadInfoMarkers();
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
