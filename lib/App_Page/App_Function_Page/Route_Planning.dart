// ignore_for_file: camel_case_types, file_names, unnecessary_import, deprecated_member_use, unnecessary_new, prefer_typing_uninitialized_variables, prefer_collection_literals, avoid_print, unnecessary_brace_in_string_interps, unnecessary_string_interpolations
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
    state.changePositionNow(await geolocator().updataPosition(context));
  }

  //搜尋路徑
  void routeSearch() async{
    var response;
    var url = dotenv.env['RoutePlanning'].toString();
    var jwt = ',${state.accountState}';
    print(startData);
    print(endData);
    for(int i =0;i<startData.length;i++){
      if(startData[i]['name'] == startPlaceText.text){
        startData = startData[i];
        i=startData.length;
      }
    }
    for(int i =0;i<endData.length;i++){
      if(endData[i]['name'] == endPlaceText.text){
        endData = endData[i];
        i=endData.length;
      }
    }
    print(startData);
    print(endData);
    url += '?latitude=${startData['geometry']['location']['lat']}'
        '&longitude=${startData['geometry']['location']['lng']}'
        '&DestinationLatitude=${endData['geometry']['location']['lat']}'
        '&DestinationLongitude=${endData['geometry']['location']['lng']}'
        '&StartTime=${DateFormat('yyyy-MM-ddTHH:mm:ss').format(DateTime.now())}';
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
    var url = 'https://maps.googleapis.com/maps/api/place/textsearch/json?location=${state.positionNow.latitude}%2C${state.positionNow.longitude}&query=${input}&key=${key}';
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
          markerId: const MarkerId('目前位置'),
          position: LatLng(state.positionNow.latitude,state.positionNow.longitude),
          // position:LatLng(23.71078097146887, 120.54107031283465),
          icon: BitmapDescriptor.defaultMarkerWithHue(223),
          infoWindow: const InfoWindow(
              title: '目前位置'
          ),
        )
    );
    //新增起始地標記
    _markers.add(
        Marker(
          markerId: const MarkerId('起始地'),
          position: LatLng(startData['geometry']['location']['lat'],
              startData['geometry']['location']['lng']),
          infoWindow: InfoWindow(
              title: startData['name']
          ),
        ),
    );
    //新增目的地標記
    _markers.add(
      Marker(
        markerId: const MarkerId('目的地'),
        position: LatLng(endData['geometry']['location']['lat'],
            endData['geometry']['location']['lng']),
        infoWindow: InfoWindow(
            title: endData['name']
        ),
      ),
    );
  }
  //Google Map View
    _onMapCreated(GoogleMapController controller){
    mapController = controller;
  }
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
                  borderSide: const BorderSide(width: 3, color: Color.fromRGBO(24, 60, 126, 1),),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              controller: startPlaceText,
              onChanged: (value) {
                // 獲取輸入內容
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
          Align(
            alignment: Alignment.center,
            child: IconButton(
              onPressed: () {
                changePlace();
              },
              icon: const Icon(Icons.change_circle_outlined,size: 30,color: Color.fromRGBO(24, 60, 126, 1)),
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
                      borderSide: const BorderSide(width: 3, color: Color.fromRGBO(24, 60, 126, 1),),
                      borderRadius: BorderRadius.circular(15),
                    ),
                ),
              controller: endPlaceText,
              onChanged: (value) {
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
          const SizedBox(height: 10,),
          Row(
            children: [
              //選擇時間按鈕
              Expanded(
                flex: 5,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(width: 3, color: Color.fromRGBO(24, 60, 126, 1),),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(DateFormat('yyyy/MM/dd').format(DateTime.now()).toString()
                      ,style: const TextStyle(color: Color.fromRGBO(24, 60, 126, 1),fontSize: 20)),
                ),
              ),
              //出發時間
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromRGBO(24, 60, 126, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),// Background color
                  ),
                  onPressed: () {},
                  child: const Text('出發',style: TextStyle(color: Colors.white,fontSize:17)),
                ),
              ),
              //抵達時間
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromRGBO(24, 60, 126, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),// Background color
                  ),
                  onPressed: () {

                  },
                  child: const Text('抵達',style: TextStyle(color: Colors.white,fontSize: 17)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          //搜尋按鈕
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: const Color.fromRGBO(24, 60, 126, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),// Background color
            ),
            onPressed: (){
              routeSearch();
            },
            child: const Text('搜尋',style: TextStyle(color: Colors.white,fontSize: 20)),
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
                      hintText: startData['name'],
                      hintStyle: const TextStyle(color: Color.fromRGBO(24, 60, 126, 1)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 3, color: Color.fromRGBO(24, 60, 126, 1),),
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
                    icon: const Icon(Icons.change_circle_outlined,size: 30,color: Color.fromRGBO(24, 60, 126, 1)),
                  ),
              ),
              Expanded(
                flex: 4,
                  child: TextField(
                    controller: endPlaceText,
                    decoration: InputDecoration(
                      hintText: endData['name'],
                      hintStyle: const TextStyle(color: Color.fromRGBO(24, 60, 126, 1)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 3, color: Color.fromRGBO(24, 60, 126, 1),),
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
          const SizedBox(height: 10,),
          Column(
            children:List.generate(routePlanning['data']['routes'].length, (index) {
                final list = routePlanning['data']['routes'][index];
                return InkWell(
                  child:Column(
                      children: <Widget>[
                        Row(
                          children: [
                            Expanded(
                              flex:8,
                              child:Text('${DateFormat('HH:mm a').format(DateTime.parse(list['start_time']))} - '
                                  '${DateFormat('HH:mm a').format(DateTime.parse(list['end_time']))}',style: const TextStyle(fontSize: 26),),
                            ),
                            Expanded(
                              flex:2,
                              child:Text('${Duration(seconds:list['travel_time']).toString().substring(0,7)}',style: const TextStyle(fontSize: 20)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
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
                                  (sectionList[i]['transport']['shortName'] == null) ? const Text('') :
                                  Text(sectionList[i]['transport']['shortName'], style: const TextStyle(fontSize: 15)),
                                  // 判斷是不是最後一個，不用加>
                                  (i < list['sections'].length - 1) ? const Text('＞', style: TextStyle(fontSize: 18)) : const Text(' '),
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
                  const SizedBox(height:10),
                  SizedBox(
                    width:30,
                    height: 5,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ),
                  const SizedBox(height:14),
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