// ignore_for_file: file_names, camel_case_types, prefer_typing_uninitialized_variables, non_constant_identifier_names, avoid_print, prefer_is_empty, unused_import

import 'package:flutter_waya/flutter_waya.dart';
import 'package:traffic_hero/App_Page/App_Function_Page/Tourist_Information_Page_Detail.dart';
import 'package:traffic_hero/imports.dart';

class Tourist_Information_Page_SearchPage extends StatefulWidget {
  const Tourist_Information_Page_SearchPage({super.key});

  @override
  State<Tourist_Information_Page_SearchPage> createState() =>
      _Tourist_Information_Page_SearchPageState();
}

class _Tourist_Information_Page_SearchPageState
    extends State<Tourist_Information_Page_SearchPage> {
  late stateManager state;
  var searchResult_list;
  var resultDetail_list;
  List<dynamic> seachList = [];


  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
  }

  //根據"關鍵字"回傳該項目的UID、名稱
  void resultDetail(String UID) async {
    var url = '${dotenv.env['KeyWord2UID']}?UID=$UID';
    var jwt = ',${state.accountState}';
    var response = await api().apiGet(url, jwt);
    if (response.statusCode == 200) {
      setState(() {
        // resultDetail_list : 儲存某景點的UID、名稱
        resultDetail_list = jsonDecode(utf8.decode(response.bodyBytes));
        print(resultDetail_list);
        state.updatePageDetail(resultDetail_list[0]);
      });
    } else {
      print(jsonDecode(utf8.decode(response.bodyBytes)));
    }
  }

  // 關鍵字搜尋
  void searchResult(String inputText) async {
    setState(() {
      seachList = [];
    });
    var url = '${dotenv.env['SearchKeyWord']}?Keyword=$inputText';
    var jwt = ',${state.accountState}';
    var response = await api().apiGet(url, jwt);
    if (response.statusCode == 200) {
      setState(() {
        // searchResult_list : 儲存搜尋結果陣列

        searchResult_list = jsonDecode(utf8.decode(response.bodyBytes));
        print(searchResult_list);
        var hotel = searchResult_list['name']['hotel'];
        var scenic_spot = searchResult_list['name']['scenic_spot'];
        var restaurant = searchResult_list['name']['restaurant'];
        for (var i = 0; i < hotel.length; i++) {
          seachList.add(hotel[i]);
        }
        for (var i = 0; i < scenic_spot.length; i++) {
          seachList.add(scenic_spot[i]);
        }

        for (var i = 0; i < restaurant.length; i++) {
          seachList.add(restaurant[i]);
        }
      });
    } else {
      print(jsonDecode(utf8.decode(response.bodyBytes)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(62, 111, 179, 1),

        // 分類Icon
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 28,
          ),
        ),

        // 搜尋欄
        title: ListTile(
            leading: const Icon(
              Icons.search,
              color: Colors.white,
              size: 28,
            ),
            title: TextField(
              decoration: const InputDecoration(
                hintText: '以名稱搜尋',
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
                border: InputBorder.none,
              ),

              // 將搜尋欄中輸入的字傳到後端做關鍵字搜尋
              onChanged: (inputText) async {
                // 若無輸入，則下排保持顯示"請輸入您想搜尋的地點"
                if (inputText.length == 0) {
                  setState(() {
                    searchResult_list = [
                      {"UID": "0", "名稱": "請輸入您想搜尋的地點"}
                    ];
                  });
                } else {
                  searchResult(inputText);
                }
              },
              style: const TextStyle(
                color: Colors.white,
              ),
            )),
      ),
      body: ListView.builder(
          itemCount: seachList.length,
          itemBuilder: (context, index) {
            // data : 讀取searchResult_list裡每個值
            var data = seachList[index];
            return ListTile(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 將每個搜尋到的結果做成鏈結，可點擊並跳轉至該點的詳情
                  TextButton(
                      onPressed: () {
                        
                        //透過延遲進入頁面，使頁面能夠順利讀取UID所獲取的資料
                        Future.delayed(const Duration(seconds: 0), () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                       TouristInformationPageDetail(detail: data,)));
                        });
                      },
                      child: Text(
                        data['name'],
                        style: const TextStyle(color: Colors.black),
                      )),
                  const Divider(thickness: 2, color: Colors.grey, indent: 0)
                ],
              ),
            );
          }),
    );
  }
}
