// ignore_for_file: deprecated_member_use, file_names, camel_case_types, prefer_typing_uninitialized_variables, prefer_collection_literals, annotate_overrides, non_constant_identifier_names, avoid_print, avoid_unnecessary_containers

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
      markerId: const MarkerId('目前位置'),
      position: LatLng(position.latitude, position.longitude),
      icon: BitmapDescriptor.defaultMarkerWithHue(223),
      infoWindow: const InfoWindow(title: '目前位置'),
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
                snippet:
                    '可借 - ${list['available_rent_bikes']},可還 - ${list['available_return_bikes']}',
              ),
              onTap: () {
                launch(list['url']);
                setState(() {});
              }),
        );
        print(
            '$i標記成功${list['location']['latitude']}${list['location']['longitude']}');
      } catch (e) {
        print(e);
        print('$i標記失敗');
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
            color: const Color.fromRGBO(62, 111, 179, 1),
            child: const ListTile(
              title: Text(
                '附近站點',
                style: TextStyle(color: Colors.white),
              ),
              trailing: SizedBox(
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
              child: ListView.builder(
            controller: scrollController,
            itemCount: content.length,
            itemBuilder: (context, index) {
              final list = content[index];
              return InkWell(
                child: ListTile(
                  leading: Image.network(list['icon_url']),
                  title: Container(
                    child: Text(
                      list['station_name_zh_tw'],
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color.fromRGBO(0, 32, 96, 1),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(list['service_type']),
                      Text(
                        '${list['distance']}m',
                        style: const TextStyle(color: Colors.indigo),
                      ),
                    ],
                  ),
                  trailing: SizedBox(
                    width: 100,
                    height: 50,
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        Text(
                          list['available_rent_bikes'].toString(),
                          style:
                              const TextStyle(fontSize: 18, color: Colors.red),
                        ),
                        const SizedBox(width: 30),
                        Text(
                          list['available_return_bikes'].toString(),
                          style: const TextStyle(
                              fontSize: 18, color: Colors.blueAccent),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    _mapController.showMarkerInfoWindow(
                        MarkerId(list['station_name_zh_tw']));
                  });
                },
              );
            },
          ))
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
