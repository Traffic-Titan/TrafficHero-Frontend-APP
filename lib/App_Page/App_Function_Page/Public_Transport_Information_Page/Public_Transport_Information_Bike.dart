// ignore_for_file: deprecated_member_use

import 'package:flutter_waya/flutter_waya.dart';
import 'package:traffic_hero/Imports.dart';

class publicTransportInfoBike extends StatefulWidget {
  const publicTransportInfoBike({super.key});

  @override
  State<publicTransportInfoBike> createState() =>
      _publicTransportInfoBikeState();
}

class _publicTransportInfoBikeState extends State<publicTransportInfoBike> {
  late stateManager state;
  var position;
  var screenWidth;
  var screenHeight;
  // ignore: unused_field
  late GoogleMapController _mapController;
  final Set<Marker> _markers = Set<Marker>();
  var draggleHeight = 0.3;
  List<dynamic> content = [];

  void didChangeDependencies() async {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    position = state.positionNow;
    setState(() {
      content = state.nearbyStationBike;
    });
    get_home();
  }

  get_home() async {
    await getHome().stationNearbySearchBike(context);
    setState(() {
      content = state.nearbyStationBike;
    });
    addMarkers(content);
  }

  //新增標記
  void addMarkers(content) {
    print(position.toString());
    _markers.clear();
    // 目前位置標記
    _markers.add(Marker(
      markerId: MarkerId('目前位置'),
      position: LatLng(position.latitude, position.longitude),
      icon: BitmapDescriptor.defaultMarkerWithHue(223),
      infoWindow: InfoWindow(title: '目前位置'),
    ));

    for (var i = 0; i < content.length; i++) {
      var list = content[i];

      try {
        _markers.add(
          Marker(
              markerId: MarkerId(list['station_name_zh_tw']),
              position: LatLng(
                  list['location']['latitude'], list['location']['longitude']),
              infoWindow: InfoWindow(
                title: list['station_name_zh_tw'],
                snippet: '可借 - ' +
                    list['available_rent_bikes'].toString() +
                    ',可還 - ' +
                    list['available_return_bikes'].toString(),
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

  _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

//Google Map View
  Widget mapView() {
    return GoogleMap(
      mapToolbarEnabled: false,
      myLocationButtonEnabled: false,
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: LatLng(state.positionNow.latitude, state.positionNow.longitude),
        zoom: 15.0,
      ),
      markers: _markers,
    );
  }

  Widget draggableScrollableSheet() {
    return DraggableScrollableSheet(
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          width: screenWidth > 600 ? screenWidth / 4 + 100 : screenWidth,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(222, 235, 247, 1),
          ),
          child: Column(
            children: [
              Expanded(
                child: nearbyStationBikeView(scrollController),
              ),
            ],
          ),
        );
      },
      expand: false,

      initialChildSize: 0.3, // 初始高度比例
      minChildSize: 0.2, // 最小高度比例
      maxChildSize: 1, // 最大高度比例
    );
  }

  Widget nearbyStationBikeView(ScrollController scrollController) {
    return SizedBox(
      width: screenWidth > 600 ? 600 : screenWidth,
      // height: 200,
      child: Column(
        children: [
          Container(
            color: Color.fromRGBO(62, 111, 179, 1),
            child: ListTile(
              title: Text(
                '附近站點',
                style: TextStyle(color: Colors.white),
              ),
              trailing: Container(
                width: 110,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '可借',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '可還',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView(
              controller: scrollController,
              padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, //横轴三个子widget
                  childAspectRatio: 5 / 1),
              children: List.generate(
                content.length,
                (index) {
                  final list = content[index];
                  return InkWell(
                    child: ListTile(
                      leading: Image.network(list['icon_url']),
                      title: Container(
                        child: Text(
                          list['station_name_zh_tw'],
                          style: TextStyle(
                            fontSize: 15,
                            color: Color.fromRGBO(0, 32, 96, 1),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      subtitle: Text(list['service_type']),
                      trailing: Container(
                        width: 100,
                        height: 50,
                        child: Row(
                          children: [
                            SizedBox(width: 10),
                            Text(
                              list['available_rent_bikes'].toString(),
                              style: TextStyle(fontSize: 18, color: Colors.red),
                            ),
                            SizedBox(width: 30),
                            Text(
                              list['available_return_bikes'].toString(),
                              style: TextStyle(
                                  fontSize: 18, color: Colors.blueAccent),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      print('開始導航');
                      launch(list['url']);
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    );

    //   },
    // );
  }

  //附近站點

  void openSheet(h) {
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
        Align(
            alignment: Alignment.bottomLeft, child: draggableScrollableSheet())
      ],
    );
  }
}
