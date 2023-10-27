// ignore_for_file: camel_case_types, file_names, unnecessary_import, deprecated_member_use




import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:traffic_hero/Imports.dart';

class Route_Planning extends StatefulWidget {
  const Route_Planning({super.key});

  @override
  State<Route_Planning> createState() => _Route_Planning();
}

class _Route_Planning extends State<Route_Planning> {
  late stateManager state;
  late GoogleMapController mapController;
  late TextEditingController startPlaceText = new TextEditingController();
  late TextEditingController endPlaceText = new TextEditingController();
  var screenWidth;
  var screenHeight;
  var startData ;
  var endData;
  var routePlanning;
  //設定上拉式抽屜欲顯示的頁面
  bool draggleView =true;
  //詳細內容頁
  bool routePlanDetail =true;
  final Set<Marker> _markers = Set<Marker>();
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
    screenWidth = MediaQuery. of(context). size. width ;
    screenHeight = MediaQuery. of(context). size. height;
    state.changePositionNow(await geolocator().updataPosition());
  }
  _onMapCreated(GoogleMapController controller){
    mapController = controller;
  }
  //搜尋路徑
  void routeSearch() async{
    var response;
    var url = dotenv.env['RoutePlanning'].toString();
    var jwt = ',' + state.accountState.toString();
    url += '?latitude=${startData['geometry'][0]['geometry']['location']['lat']}'
        '&longitude=${startData['candidates'][0]['geometry']['location']['lng']}'
        '&DestinationLatitude=${endData['candidates'][0]['geometry']['location']['lat']}'
        '&DestinationLongitude=${endData['candidates'][0]['geometry']['location']['lng']}'
        '&StartTime=${DateFormat('yyyy-MM-ddTHH:mm:ss').format(DateTime.now())}';
    // url += '?latitude=23.712098794315647&longitude=120.54102575330592&DestinationLatitude=22.666729273959174&DestinationLongitude=120.3033084049614';
    print(url);


    try {
      response = await api().apiGet(url, jwt);
    } catch (e) {
      print(e);
    }
    if (response.statusCode == 200) {
      print(jsonDecode(utf8.decode(response.bodyBytes)));
      setState(() {
        routePlanning = jsonDecode(utf8.decode(response.bodyBytes));
        addMarkers();
        draggleView = false;
      });
    } else {
      print(jsonDecode(utf8.decode(response.bodyBytes)));
    }
  }
  //取得位置經緯度
  Future<List<String>> getInputLocation(inputText,inputValue) async{
    var key = dotenv.env['GOOGLE_MAPS_API_KEY'];
    var response;
    var data;
    List<String> suggestions=[];
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
      // 将API响应数据转换为建议项列表
      for (var item in data) {
        suggestions.add(item['name']);
      }
      if(inputValue){
        setState(() {
          startData = data;
        });
      }else{
        setState(() {
          endData = data;
        });
      }
      return suggestions;
    } else {
      return suggestions;
    }
  }
  //交換起始地&目的地位置
  void changePlace(){
    var text;
    setState(() {
      //交換textField內的字
      text = startPlaceText;
      startPlaceText = endPlaceText;
      endPlaceText = text;
      //交換已經儲存的內容
      text = startData;
      startData = endData;
      endData = text;
    });
  }

  //新增起始地及目的地標記
  void addMarkers() {
    _markers.clear();
    // 目前位置標記
    _markers.add(
        Marker(
          markerId: MarkerId('目前位置'),
          position: LatLng(state.positionNow.latitude,state.positionNow.longitude),
          // position:LatLng(23.71078097146887, 120.54107031283465),
          icon: BitmapDescriptor.defaultMarkerWithHue(223),
          infoWindow: InfoWindow(
              title: '目前位置'
          ),
        )
    );
    //新增起始地標記
    _markers.add(
        Marker(
          markerId: MarkerId('起始地'),
          position: LatLng(startData['candidates'][0]['geometry']['location']['lat'],
              startData['candidates'][0]['geometry']['location']['lng']),
          infoWindow: InfoWindow(
              title: startData['candidates'][0]['name']
          ),
        ),
    );
    //新增目的地標記
    _markers.add(
      Marker(
        markerId: MarkerId('目的地'),
        position: LatLng(endData['candidates'][0]['geometry']['location']['lat'],
            endData['candidates'][0]['geometry']['location']['lng']),
        infoWindow: InfoWindow(
            title: endData['candidates'][0]['name']
        ),
      ),
    );
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
  var input;
  //上拉式抽屜-輸入起始地&目的地
  Widget inputView(ScrollController scrollController){
    return SizedBox(
      width:  screenWidth * 0.9,
      child:ListView(
        controller: scrollController,
        padding: EdgeInsets.zero,
        children: [
          //輸入起始地
          TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              autofocus: false,
              style: DefaultTextStyle.of(context).style.copyWith(
                  fontStyle: FontStyle.italic
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 3, color: Color.fromRGBO(24, 60, 126, 1),),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              controller: startPlaceText,
              onChanged: (value) {
                // 获取用户输入的内容
                input = value;
              },
            ),
            suggestionsCallback: (pattern) async {
              return getInputLocation(input,true);
            },
            itemBuilder: (context, suggestion) {
              return ListTile(
                title: Text(suggestion.toString()),
              );
            },
            onSuggestionSelected: (suggestion) {
              startPlaceText.text = suggestion;
            },
          ),
          // TextField(
          //   controller: startPlaceText,
          //   decoration: InputDecoration(
          //     hintText: '輸入起始地',
          //     hintStyle: TextStyle(color: Color.fromRGBO(24, 60, 126, 1)),
          //     enabledBorder: OutlineInputBorder(
          //       borderSide: BorderSide(width: 3, color: Color.fromRGBO(24, 60, 126, 1),),
          //       borderRadius: BorderRadius.circular(15),
          //     ),
          //   ),
          //   onEditingComplete: (){
          //     getInputLocation(startPlaceText.text,true);
          //   },
          // ),
          //交換起始地&目的地
          Align(
            alignment: Alignment.center,
            child: IconButton(
              onPressed: () {
                changePlace();
              },
              icon: Icon(Icons.change_circle_outlined,size: 30,color: Color.fromRGBO(24, 60, 126, 1)),
            ),
          ),
          //輸入目的地
          TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
                autofocus: false,
                style: DefaultTextStyle.of(context).style.copyWith(
                    fontStyle: FontStyle.italic
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Color.fromRGBO(24, 60, 126, 1),),
                      borderRadius: BorderRadius.circular(15),
                    ),
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
            },
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              //選擇時間按鈕
              Expanded(
                flex: 5,
                child: OutlinedButton(
                  child: Text(DateFormat('yyyy/MM/dd').format(DateTime.now()).toString()
                      ,style: TextStyle(color: Color.fromRGBO(24, 60, 126, 1),fontSize: 20)),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(width: 3, color: Color.fromRGBO(24, 60, 126, 1),),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
              //出發時間
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  child: Text('出發',style: TextStyle(color: Colors.white,fontSize:17)),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(24, 60, 126, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),// Background color
                  ),
                  onPressed: () {},
                ),
              ),
              //抵達時間
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  child: Text('抵達',style: TextStyle(color: Colors.white,fontSize: 17)),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(24, 60, 126, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),// Background color
                  ),
                  onPressed: () {

                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          //搜尋按鈕
          ElevatedButton(
            child: Text('搜尋',style: TextStyle(color: Colors.white,fontSize: 20)),
            style: ElevatedButton.styleFrom(
              primary: Color.fromRGBO(24, 60, 126, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),// Background color
            ),
            onPressed: (){
              routeSearch();
            },
          )
        ],
      ),
    );
  }
  //上拉式抽屜-路線規劃頁
  Widget routePlanView(ScrollController scrollController){
    return SizedBox(
      width:  screenWidth * 0.9,
      child:ListView(
        controller: scrollController,
        padding: EdgeInsets.zero,
        children: [
          Row(
            children: [
              Expanded(
                flex: 4,
                  child: TextField(
                    controller: startPlaceText,
                    decoration: InputDecoration(
                      hintText: startData['candidates'][0]['name'],
                      hintStyle: TextStyle(color: Color.fromRGBO(24, 60, 126, 1)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Color.fromRGBO(24, 60, 126, 1),),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onEditingComplete: (){
                      // getInputLocation(startPlaceText.text,true);
                    },
                  ),
              ),
              Expanded(
                flex: 2,
                  child: IconButton(
                    onPressed: () {
                      changePlace();
                    },
                    icon: Icon(Icons.change_circle_outlined,size: 30,color: Color.fromRGBO(24, 60, 126, 1)),
                  ),
              ),
              Expanded(
                flex: 4,
                  child: TextField(
                    controller: endPlaceText,
                    decoration: InputDecoration(
                      hintText: endData['candidates'][0]['name'],
                      hintStyle: TextStyle(color: Color.fromRGBO(24, 60, 126, 1)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Color.fromRGBO(24, 60, 126, 1),),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onEditingComplete: (){
                      // getInputLocation(startPlaceText.text,true);
                    },
                  ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Column(
            children:List.generate(routePlanning['data']['routes'].length-1, (index) {
                final list = routePlanning['data']['routes'][index];
                return InkWell(
                  child:Column(
                      children: <Widget>[
                        Row(
                          children: [
                            Expanded(
                              flex:8,
                              child:Text('${DateFormat('HH:mm a').format(DateTime.parse(list['start_time']))} - '
                                  '${DateFormat('HH:mm a').format(DateTime.parse(list['end_time']))}',style: TextStyle(fontSize: 26),),
                            ),
                            Expanded(
                              flex:2,
                              child:Text('${Duration(seconds:list['travel_time']).toString().substring(0,7)}',style: TextStyle(fontSize: 20)),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Wrap(
                            spacing: 2.0, // 主轴(水平)方向间距
                            runSpacing: 2.0, // 纵轴（垂直）方向间距
                            // alignment: TextDirection.LTR, //沿主轴方向居中
                            children: List.generate(list['sections'].length, (i) {
                              var sectionList = list['sections'];
                              return Wrap(
                                children: [
                                  Image.asset('assets/publicTransportIcon/${sectionList[i]['transport']['mode']}.png', height: 40,),
                                  // 車號排除詳細資訊=null
                                  (sectionList[i]['transport']['shortName'] == null) ? Text('') :
                                  Text(sectionList[i]['transport']['shortName'], style: TextStyle(fontSize: 15)),
                                  // 判斷是不是最後一個，不用加>
                                  (i < list['sections'].length - 1) ? Text('＞', style: TextStyle(fontSize: 18)) : Text(' '),
                                ],
                              );
                            }
                            ),
                          )
                        ),


                      ]
                  ),
                  onTap: () async {
                    setState(() {
                      routePlanDetail = !routePlanDetail;
                    });
                  },
                );

              },
            ),
          ),
        ],
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Map
        mapView(),
        DraggableScrollableSheet(
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(222, 235, 247, 1),
              ),
              child: Column(
                children: [
                  SizedBox(height:10),
                  SizedBox(
                    width:30,
                    height: 5,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ),
                  SizedBox(height:14),
                  Expanded(
                    child: draggleView ? inputView(scrollController) : routePlanView(scrollController),
                  ),
                ],
              ),

            );
          },
          initialChildSize: 0.3, // 初始高度比例
          minChildSize: 0.1, // 最小高度比例
          maxChildSize: 1, // 最大高度比例
        ),
      ],
    );
  }
}