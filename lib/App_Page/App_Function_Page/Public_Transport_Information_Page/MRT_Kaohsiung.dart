import 'package:dropdown_search/dropdown_search.dart';

import 'package:traffic_hero/Imports.dart';

class MRT_Kaohsiung extends StatefulWidget {
  const MRT_Kaohsiung({Key? key}) : super(key: key);

  @override
  State<MRT_Kaohsiung> createState() => _MRT_KaohsiungState();
}
var screenWidth;
var screenHeight;
var _selectedItem=null;
var state ;
List<dynamic> _stationState=[
  {
    "目前資訊": "往小港",
    "剩餘時間": "4 分鐘"
  },
];


class _MRT_KaohsiungState extends State<MRT_Kaohsiung> {

  //抓站點動態
  stationState() async {
    var response;
    var url = '${dotenv.env['MRT_KRTC']}?StationName=${_selectedItem}';
    var jwt = ',${state.accountState}';
    try {
      response = await api().apiGet(url, jwt);
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        setState(() {
          _stationState = responseBody;
        });
      } else {
        print(jsonDecode(utf8.decode(response.bodyBytes)).toString());
      }
    } catch (e) {
      print(e);
    }
  }
  //站點動態
  Widget stationView(ScrollController scrollController){
    return SizedBox(
      height: screenHeight*0.3,
      child: ListView.builder(
        controller: scrollController,
          itemCount: _stationState.length,
          itemBuilder: (context, index) {
            var list = _stationState[index];
            return Column(
              children: [
                ListTile(
                  leading: Container(
                    width: 75,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 3.0),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(14.0),
                        topRight: Radius.circular(14.0),
                        bottomLeft: Radius.circular(14.0),
                        bottomRight: Radius.circular(14.0),
                      ),
                    ),
                    child: Text(
                      list['剩餘時間'].toString(),
                      style: TextStyle(fontSize: 23),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  title: Text(list['目前資訊'].toString(), textAlign: TextAlign.left)
                ),
                ],
              );
            })
    );
  }
  //附近站點
  Widget scrollView(ScrollController scrollController) {
    return SizedBox(
      child:ListView(
        controller: scrollController,
        children: [
          //搜尋欄
          ListTile(
              leading: Icon(
                Icons.search,
                color: Color.fromRGBO(46, 80, 140, 1),
                size: 28,
              ),
              title: DropdownSearch<String>(
                items: MRTList_kaohsiung,
                popupProps: PopupProps.menu(
                  showSearchBox: true, // add this line
                  showSelectedItems: true,
                ),
                dropdownDecoratorProps: DropDownDecoratorProps(
                    textAlign: TextAlign.center,
                    baseStyle:TextStyle(fontSize: 20),
                    dropdownSearchDecoration: InputDecoration(
                    )),
                onChanged: (String? value) => setState(() {
                  _selectedItem = value!;
                }),
                selectedItem: MRTList_kaohsiung.first,
              ),
              // DropdownButton<String>(
              //   value: _selectedItem,
              //   onChanged: (String? newValue) {
              //     setState(() {
              //       _selectedItem = newValue!;
              //     });
              //   },
              //   items: MRTList_kaohsiung.map((String value) {
              //     return DropdownMenuItem<String>(
              //       value: value,
              //       child: Text(value),
              //     );
              //   }).toList(),
              // ),
            trailing: TextButton(
              onPressed: () {
                stationState();
              }, 
              child: Text('搜尋'),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(14)),
            child: Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 10,right: 10),
              padding: EdgeInsets.all(5),
              width: screenWidth - 30 > 600 ? 600 : screenWidth - 30,
              color: Color.fromRGBO(165, 201, 233, 1),
              child: Text('進站動態',style: TextStyle(color: Color.fromRGBO(29, 73, 153, 1),fontSize: 23)),
            ),
          ),
          (_selectedItem != null)? stationView(scrollController):Text('請選擇站點'),
        ],
      )
    );

  }
  @override
  Widget build(BuildContext context) {
    state = Provider.of<stateManager>(context, listen: false);
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children:[
        WebViewForMRT(
          tt: 'https://tw.piliapp.com/mrt-taiwan/kaohsiung/',
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: DraggableScrollableSheet(
            builder: (BuildContext context,
                ScrollController scrollController) {
              return Container(
                width: screenWidth > 600
                    ? screenWidth / 4 + 100
                    : screenWidth,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(222, 235, 247, 1),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    SizedBox(
                      width: 30,
                      height: 5,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    ),
                    SizedBox(height: 14),
                    Expanded(
                      child: scrollView(scrollController),
                    ),
                  ],
                ),
              );
            },
            expand: false,

            initialChildSize: 0.3, // 初始高度比例
            minChildSize: 0.1, // 最小高度比例
            maxChildSize: 1, // 最大高度比例
          ),
        ),
      ]
    );
  }
}
