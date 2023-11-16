// ignore_for_file: camel_case_types, library_private_types_in_public_api, file_names, unused_import, override_on_non_overriding_member, prefer_typing_uninitialized_variables, prefer_final_fields




import 'package:flutter/material.dart';
import 'package:flutter_waya/components/check_box.dart';
import 'package:flutter_waya/extension/object_extension.dart';
import 'package:traffic_hero/App_Page/App_Function_Page/Road_Information/Road_Information_ParkingLot.dart';
import 'package:traffic_hero/imports.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart'; // Make sure to import the correct package
import 'package:traffic_hero/Components/Tool.dart' as Tool;
import 'package:flutter_typeahead/flutter_typeahead.dart';

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
  var trafficControlList;
  var roadAccidentList;
  var roadConstructionList;
  var trafficJamList;
  List<Map<String, dynamic>> destinationList = [];
  List<String> suggestions=[];
  var input;
  late TextEditingController endPlaceText = new TextEditingController();
  late GoogleMapController _mapController;
  final Set<Marker> _markers = Set<Marker>();
  //欲篩選的路況
  final List<String> _filterRoadInfoItems =[];
  late BitmapDescriptor ParkingInfoImg,TrafficControlImg,RoadAccidentImg,RoadConstructionImg,TrafficJamImg;
  bool checkedBox = false;

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
    // 初始化 customIcon
    _initCustomImg();
  }
  @override
  void dispose() {
    super.dispose();
  }
// 初始化 customIcon
  Future<void> _initCustomImg() async {
    ParkingInfoImg = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(10, 10)),
      'assets/roadInfo/parkingInfoImg.png',
    );
    TrafficControlImg = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(10, 10)),
      'assets/roadInfo/trafficControlImg.png',
    );
    RoadAccidentImg = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size:Size(10, 10)),
      'assets/roadInfo/roadAccidentImg.png',
    );
    RoadConstructionImg = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(10, 10)),
      'assets/roadInfo/roadConstructionImg.png',
    );
    TrafficJamImg = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(10, 10)),
      'assets/roadInfo/trafficjamImg.png',
    );
    // 一旦 customIcon 初始化完成，触发重建以使用它
    setState(() {});
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
  //取得交通管制資訊
  searchTrafficControl() async {
    print('取得交通管制資訊');
    // EasyLoading.show(status: '儲存中');
    var url = dotenv.env['TrafficControl'];
    var jwt = ',' + state.accountState;
    var response;
    try {
      response = await api().apiGet(url, jwt);
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        print('取得成功');
        trafficControlList = responseBody;
      }
    } catch (e) {
      print(e);
    }
  }
  //取得交通管制資訊
  searchRoadAccident() async {
    print('取得交通事故資訊');
    // EasyLoading.show(status: '儲存中');
    var url = dotenv.env['RoadAccident'];
    var jwt = ',' + state.accountState;
    var response;
    try {
      response = await api().apiGet(url, jwt);
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        print('取得成功');
        roadAccidentList = responseBody;
      }
    } catch (e) {
      print(e);
    }
  }
  //取得道路施工資訊
  searchRoadConstruction() async {
    print('取得道路施工資訊');
    // EasyLoading.show(status: '儲存中');
    var url = dotenv.env['RoadConstruction'];
    var jwt = ',' + state.accountState;
    var response;
    try {
      response = await api().apiGet(url, jwt);
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        print('取得成功');
        roadConstructionList = responseBody;
      }
    } catch (e) {
      print(e);
    }
  }
  //取得道路壅塞資訊
  searchTrafficJam() async {
    print('取得道路壅塞資訊');
    // EasyLoading.show(status: '儲存中');
    var url = dotenv.env['Trafficjam'];
    var jwt = ',' + state.accountState;
    var response;
    try {
      response = await api().apiGet(url, jwt);
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        print('取得成功');
        trafficJamList = responseBody;
      }
    } catch (e) {
      print(e);
    }
  }
  //新增位置標記
  void addPositionMarkers(lat,lng,name) {
    Marker marker = Marker(
      markerId: MarkerId(name),
      position: LatLng(lat,lng),
      icon: BitmapDescriptor.defaultMarkerWithHue(223),
      infoWindow: InfoWindow(
          title: name
      ),
    );
    setState(() {
      _markers.add(marker);
    });
    // 改變Camera位置
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat,lng),
          zoom: 12.0,
        ),
      ),
    );
  }
  //新增路況標記
  Future<void> addRoadInfoMarkers() async {
        print(position.toString());
    Marker marker;
    int i;
    print('list:${_filterRoadInfoItems.toString()}');
    // 目前位置標記
    for(String s in _filterRoadInfoItems){
      print(s);
      switch(s){
        case '停車場資訊':
          print('add停車場資訊');
          await searchParkingInfo();
          for(i =0;i< parkingInfoList.length;i++){
            marker=Marker(
                  markerId: MarkerId(parkingInfoList[i]['CarParkName']),
                  position: LatLng(parkingInfoList[i]['Latitude'],parkingInfoList[i]['Longitude']),
                  icon: ParkingInfoImg,
                  infoWindow: InfoWindow(
                      title: parkingInfoList[i]['Address'],
                      snippet: '總車位:${parkingInfoList[i]['TotalSpace'].toString()}'
                  ),
                );
            setState(() {
              _markers.add(marker);
            });
          }
          print('add停車場資訊finish');
          break;
        case '交通管制':
          print('add交通管制');
          await searchTrafficControl();
          for(i =0;i< trafficControlList.length;i++){
            marker=Marker(
              markerId: MarkerId(trafficControlList[i]['areaNm']),
              position: LatLng(double.parse(trafficControlList[i]['Latitude']),double.parse(trafficControlList[i]['Longitude'])),
              icon: TrafficControlImg,
              infoWindow: InfoWindow(
                  title: trafficControlList[i]['areaNm'],
                  snippet: trafficControlList[i]['comment']
              ),
            );
            setState(() {
              _markers.add(marker);
            });
          }
          print('add交通管制finish');
          break;
        case '交通事故':
          print('add交通事故');
          await searchRoadAccident();
          for(i =0;i< roadAccidentList.length;i++){
            marker=Marker(
              markerId: MarkerId(roadAccidentList[i]['areaNm']),
              position: LatLng(double.parse(roadAccidentList[i]['Latitude'].toString()),double.parse(roadAccidentList[i]['Longitude'].toString())),
              icon: RoadAccidentImg,
              infoWindow: InfoWindow(
                  title: roadAccidentList[i]['areaNm'],
                  snippet: roadAccidentList[i]['comment']
              ),
            );
            setState(() {
              _markers.add(marker);
            });
          }
          print('add交通事故finish');
          break;
        case '道路施工':
          print('add道路施工');
          await searchRoadConstruction();
          for(i =0;i< roadConstructionList.length;i++){
            marker=Marker(
              markerId: MarkerId(roadConstructionList[i]['areaNm']),
              position: LatLng(double.parse(roadConstructionList[i]['Latitude'].toString()),double.parse(roadConstructionList[i]['Longitude'].toString())),
              icon: RoadConstructionImg,
              infoWindow: InfoWindow(
                  title: roadConstructionList[i]['areaNm'],
                  snippet: roadConstructionList[i]['comment']
              ),
            );
            setState(() {
              _markers.add(marker);
            });
          }
          print('add道路施工finish');
          break;
        case '道路壅塞':
          print('add道路壅塞');
          await searchTrafficJam();
          for(i =0;i< trafficJamList.length;i++){
            print(double.parse(trafficJamList[i]['Latitude'].toString()));
            marker=Marker(
              markerId: MarkerId(trafficJamList[i]['areaNm']),
              position: LatLng(double.parse(trafficJamList[i]['Latitude'].toString()),double.parse(trafficJamList[i]['Longitude'].toString())),
              icon: TrafficJamImg,
              infoWindow: InfoWindow(
                  title: trafficJamList[i]['areaNm'],
                  snippet: trafficJamList[i]['comment']
              ),
            );
            setState(() {
              _markers.add(marker);
            });
          }
          print('add道路壅塞finish');
          break;
        default:
          break;
      }
    }
  }
  //取得經緯度座標
  void getLocation(destination){
    _markers.clear();
      for(int i=0;i<destinationList.length;i++){
        if(destination == destinationList[i]['name']){
          addPositionMarkers(destinationList[i]['lat'],destinationList[i]['lng'], destinationList[i]['name']);
          i=destinationList.length;
        }
      }
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
    );
  }
  //取得目的地經緯度座標
  Future<List<String>> getInputLocation(inputText,inputValue) async{
    var key = dotenv.env['GOOGLE_MAPS_API_KEY'];
    var response;
    var data;
    var url = 'https://maps.googleapis.com/maps/api/place/textsearch/json'+
        '?location=${state.positionNow.latitude}%2C${state.positionNow.longitude}'+
        '&query=${input}'+
        '&key=${key}';
    try {
      response = await get(Uri.parse(url.toString()));
    } catch (e) {
      print(e);
    }
    var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      data = responseBody['results'];
      suggestions=[];
      // 将API响应数据转换为建议项列表
      for (var item in data) {
          suggestions.add(item['name']);
          destinationList.add({
            'name': item['name'],
            'lat': item['geometry']['location']['lat'],
            'lng': item['geometry']['location']['lng'],
          });
      }
      return suggestions;
    } else {
      return suggestions;
    }
  }
  //搜尋紐
  PreferredSizeWidget appBar(){
    return AppBar(
      backgroundColor: const Color.fromRGBO(62, 111, 179, 1),
      leading: InkWell(
          child:  Icon(
            Icons.search,
            color: Colors.white,
            size: 28,
          )
      ),
      title: TypeAheadField(
        textFieldConfiguration: TextFieldConfiguration(
          autofocus: false,
          style: DefaultTextStyle.of(context).style.copyWith(
            fontStyle: FontStyle.italic,
            color: Colors.white
          ),
          controller: endPlaceText,
          onChanged: (value) {
            // 获取用户输入的内容
            input = value;
          },
        ),
        suggestionsCallback: (pattern) async {
          return getInputLocation(input,false);
        },
        itemBuilder: (context, suggestion) {
          return ListTile(
            title: Text(suggestion.toString()),
          );
        },
        onSuggestionSelected: (suggestion) {
          endPlaceText.text = suggestion;
          getLocation(suggestion);
        },
      ),
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
            addPositionMarkers(state.positionNow.latitude,state.positionNow.longitude,'目前位置');
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
     void _filterRoadInfoItemsChange(item,isSelected){
      if(isSelected){
        setState(() {
          Future.delayed(Duration(seconds: 1),(){
            _filterRoadInfoItems.add(item);
          });
        });
      }else{
        setState(() {
          Future.delayed(Duration(seconds: 1),(){
            _filterRoadInfoItems.remove(item);
          });
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
                  setState(() {
                    _markers.clear();
                  });
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
      appBar: appBar(),
      body: mapView(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: floatingBtn(),

    );
  }



}
