import 'package:traffic_hero/App_Page/App_Function_Page/Tourist_Information_Page_Detail.dart';
import 'package:traffic_hero/imports.dart';


class Tourist_Information_Page_SearchPage extends StatefulWidget {
  const Tourist_Information_Page_SearchPage({Key? key}) : super(key: key);

  @override
  State<Tourist_Information_Page_SearchPage> createState() => _Tourist_Information_Page_SearchPageState();
}

class _Tourist_Information_Page_SearchPageState extends State<Tourist_Information_Page_SearchPage> {
  late stateManager state;
  var searchResult_list;
  var resultDetail_list;
  @override
  void initState(){
    super.initState();
    searchResult_list=[{"UID":"0","名稱":"請輸入您想搜尋的地點"}];
  }
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
  }
  //根據"關鍵字"回傳該項目的UID、名稱
  void resultDetail(String UID) async{
    var url = dotenv.env['KeyWord2UID'].toString() + '?UID='+UID;
    var jwt = ',' + state.accountState.toString();
    var response = await api().apiGet(url, jwt);
    if (response.statusCode == 200) {
      setState(() {
        // resultDetail_list : 儲存某景點的UID、名稱
        resultDetail_list = jsonDecode(utf8.decode(response.bodyBytes));
        print(resultDetail_list[0]);
        state.updatePageDetail(resultDetail_list[0]);
      });
    } else {
      print(jsonDecode(utf8.decode(response.bodyBytes)));
    }
  }

  // 關鍵字搜尋
  void searchResult(String inputText)async{
    var url = dotenv.env['SearchKeyWord'].toString() + '?KeyWord='+inputText;
    var jwt = ',' + state.accountState.toString();
    var response = await api().apiGet(url, jwt);
    if (response.statusCode == 200) {
      setState(() {
        // searchResult_list : 儲存搜尋結果陣列
        searchResult_list = jsonDecode(utf8.decode(response.bodyBytes));
      });
    } else {
      print(jsonDecode(utf8.decode(response.bodyBytes)));
    }
  }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(113, 170, 221, 1),

          // 分類Icon
          leading: const Icon(
            Icons.checklist_rtl_sharp,
            color: Colors.white,
            size: 28,
          ),

          // 搜尋欄
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

                // 將搜尋欄中輸入的字傳到後端做關鍵字搜尋
                onChanged: (inputText) async {
                  // 若無輸入，則下排保持顯示"請輸入您想搜尋的地點"
                  if(inputText.length == 0){
                    setState(() {
                      searchResult_list=[{"UID":"0","名稱":"請輸入您想搜尋的地點"}];
                    });
                  }else{
                    searchResult(inputText);
                  }
                },
                style: TextStyle(
                  color: Colors.white,
                ),
              )
          ),

        ),
        body: ListView.builder(
          itemCount: searchResult_list.length,
          itemBuilder: (context,index){
            // data : 讀取searchResult_list裡每個值
            var data = searchResult_list[index];
            return ListTile(
              title: Column(
                children: [
                  // 將每個搜尋到的結果做成鏈結，可點擊並跳轉至該點的詳情
                  TextButton(
                      onPressed:(){
                        resultDetail(data['UID']);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Tourist_Information_Page_Detail()));
                      },
                      child: Text(data['名稱'])
                  ),
                ],
              ),
            );
          },

        ),
      );
  }
}
