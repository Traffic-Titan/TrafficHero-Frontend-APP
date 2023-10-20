// ignore_for_file: file_names, camel_case_types
// ignore: unnecessary_import
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:traffic_hero/App_Page/App_Function_Page/Tourist_Information_Page_Detail.dart';
import 'package:traffic_hero/App_Page/App_Function_Page/Tourist_Information_Page_SearchPage.dart';
import 'package:traffic_hero/imports.dart';

// ignore: unused_import
import 'Tourist_Detail_Info.dart';

class Tourist_Information extends StatefulWidget {
  const Tourist_Information({super.key});

  @override
  State<Tourist_Information> createState() => _Tourist_InformationState();
}

class _Tourist_InformationState extends State<Tourist_Information> with TickerProviderStateMixin{
  late TabController _tabController;
  late stateManager state;
  var screenWidth;
  var screenHeight;
  var positionNow;
  String searchText = '';
  late var tourismList = [];
  late GoogleMapController mapController;
  final Set<Marker> _markers = Set<Marker>();
  var position;

  _onMapCreated(GoogleMapController controller){
    mapController = controller;
  }
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
    positionNow = state.positionNow;
    screenWidth = MediaQuery. of(context). size. width ;
    screenHeight = MediaQuery. of(context). size. height;
    state.changePositionNow(await geolocator().updataPosition());
    position = state.positionNow;
    getTourismInfo();
  }
  static const List<Tab> touristTabBar = <Tab>[
    Tab(text: '景點'),
    Tab(text: '住宿'),
    Tab(text: '美食'),
    Tab(text: '活動'),
  ];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: touristTabBar.length);
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  //取得觀光資料(轉到該頁面戳一次)
  getTourismInfo() async {

    // EasyLoading.show(status: '查詢中...');
    var response;
    var url;
    var jwt = ',${state.accountState}';
    switch(_tabController.index){
      case 0:
        url = dotenv.env['TouristSpot'];
        break;
      case 1:
        url = dotenv.env['TouristHotel'];
        break;
      case 2:
        url = dotenv.env['TouristFood'];
        break;
      case 3:
        url = dotenv.env['TouristActivity'];
        break;
      default:
        print(_tabController.index);
        break;
    }
    url += '?latitude=${position.latitude}&longitude=${position.longitude}';
    // url += '?latitude=23.692502&longitude=120.532229';
    // '?longitude=${position.longitude}&latitude=${position.latitude}';
    try {
      response = await api().apiGet(url, jwt);
    } catch (e) {
      print(e);
    }
    var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      setState(() {
        tourismList = responseBody;
      });
      addMarkers();
    } else {
      EasyLoading.dismiss();
      print(jsonDecode(utf8.decode(response.bodyBytes)).toString());
    }

  }
  //新增標記
  void addMarkers() {
    _markers.clear();
    // 目前位置標記
    _markers.add(
      Marker(
          markerId: MarkerId('目前位置'),
        position: LatLng(position.latitude,position.longitude),
          // position:LatLng(positionNow.latitude,positionNow.longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(223),
        infoWindow: InfoWindow(
          title: '目前位置'
        ),
      )
    );
    // 添加標記
    for (int i=0;i <tourismList.length;i++) {
      var list = tourismList[i];
      print('tourismList${list['名稱']}');
      print('經緯度${list['經緯度'][0]}${list['經緯度'][1]}');
      _markers.add(
        Marker(
          markerId: MarkerId(list['名稱']),
          position: LatLng(list['經緯度'][0],list['經緯度'][1]),
          infoWindow: InfoWindow(
            title: list['名稱'],
            snippet: list['地址'],
          ),
        ),
      );
    }
  }
  // //改變搜尋欄
  //   void _filterSearchResults(String query) {
  //     _filteredData.clear();
  //     if (query.isEmpty) {
  //       _filteredData.addAll(_data);
  //     } else {
  //       _data.forEach((key, value) {
  //         if (key.toLowerCase().contains(query.toLowerCase())) {
  //           _filteredData[key] = value;
  //         }
  //       });
  //     }
  //     setState(() {});
  //   }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: appBar(),
            body: Stack(
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
                              child: nearbyPopularView(scrollController),
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
            ),
          ),
        )
    );
  }
  //AppBar
  PreferredSizeWidget appBar(){
    return AppBar(
      backgroundColor: const Color.fromRGBO(113, 170, 221, 1),
      leading: const Icon(
        Icons.checklist_rtl_sharp,
        color: Colors.white,
        size: 28,
      ),
      title: ListTile(
        leading: Icon(
          Icons.search,
          color: Colors.white,
          size: 28,
        ),
        title: TextField(
          decoration: InputDecoration(
            hintText: '以名稱搜尋',
            hintStyle: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontStyle: FontStyle.italic,
            ),

            border: InputBorder.none,
          ),
          onTap: (){
            // 只要點擊搜尋欄就跳轉到另外一個空白頁面
            Navigator.push(context, MaterialPageRoute(builder: (context) => Tourist_Information_Page_SearchPage()));
          },
          // onChanged: (value) {
          //   setState(() {
          //     searchText = value;
          //     filterData();
          //   });
          // },
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      bottom: TabBar(
        // labelColor: //被選種顏色,
        // unselectedLabelColor: //未被選種顏色,
        controller: _tabController,
        enableFeedback: true,
        onTap: (index) {
          setState(() {
            getTourismInfo();
          });
        },
        tabs: touristTabBar,
      ),
    );
  }
  //Google Map View
  Widget mapView(){
    return  GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        // target: LatLng(23.692502, 120.532229),
        target: LatLng(state.positionNow.latitude,state.positionNow.longitude),
        zoom: 11.0,
      ),
      markers: _markers,
    );
  }
  //附近景點
  Widget nearbyPopularView(ScrollController scrollController){
        return SizedBox(
          width:  screenWidth * 0.9,
          // height: 200,
          child:GridView(
            controller: scrollController,
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, //横轴三个子widget
              childAspectRatio: 3/1),
          children: List.generate(
            tourismList.length,
                (index) {
              final list = tourismList[index];
              return InkWell(
                  child:Row(
                      crossAxisAlignment: CrossAxisAlignment.start, //水平對齊方式
                      children: <Widget>[
                        AspectRatio(  //設定圖片的長寬比
                          aspectRatio: 3/2,
                          child: Image.network(list['圖片'],height: screenHeight*0.3,fit: BoxFit.fill,),

                        ),
                        Flexible(
                          child: Column(
                              children:[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                                  child: Column( //用Column讓兩排文字可以垂直排列
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(list['名稱'].toString(),overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 20,color: Color.fromRGBO(24, 60, 126, 1)),),
                                      Text(list['地址'].toString(),overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 13,color: Color.fromRGBO(24, 60, 126, 1)),),
                                      Text(list['開放時間'].toString(),overflow: TextOverflow.ellipsis,maxLines: 2,style: TextStyle(fontSize: 10,color: Color.fromRGBO(24, 60, 126, 1)),),
                                      Text(list['聯絡電話'].toString(),overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 10,color: Color.fromRGBO(24, 60, 126, 1)),),
                                    ],
                                  ),
                                ),
                              ]
                          ),
                        ),
                      ]
                  ),
                onTap: () async {
                  // EasyLoading.show(status: 'loading...');
                  state.updatePageDetail(list);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Tourist_Information_Page_Detail()));
                },
              );
            },
          ),
        ),
        );

    //   },
    // );
  }

}
