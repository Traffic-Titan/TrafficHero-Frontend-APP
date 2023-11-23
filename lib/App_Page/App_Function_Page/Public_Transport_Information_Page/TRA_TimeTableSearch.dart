import 'package:traffic_hero/App_Page/App_Function_Page/Public_Transport_Information_Page/TRA_TimeTableSearch_ByStation.dart';
import 'package:traffic_hero/App_Page/App_Function_Page/Public_Transport_Information_Page/TRA_TimeTableSearch_CarNumSearch.dart';
import 'package:traffic_hero/App_Page/App_Function_Page/Public_Transport_Information_Page/TRA_TimeTableSearch_StartEndStation.dart';
import 'package:traffic_hero/imports.dart';

class TRA_TimeTableSearch extends StatefulWidget {
  const TRA_TimeTableSearch({Key? key}) : super(key: key);

  @override
  State<TRA_TimeTableSearch> createState() => _TRA_TimeTableSearchState();
}

class _TRA_TimeTableSearchState extends State<TRA_TimeTableSearch> {

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
          home: DefaultTabController(
              length:3,
              child: Scaffold(
                appBar: AppBar(
                  leading: BackButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                  iconTheme: IconThemeData(//返回鍵顏色
                    color:Colors.white, //change your color here
                  ),
                  title: Text('火車時刻表條件查詢',style: TextStyle(color:Colors.white),),
                  backgroundColor: const Color.fromRGBO(113, 170, 221, 1),
                  bottom: TabBar(
                    labelColor: Colors.white,//被選中文字顏色,
                    labelStyle: TextStyle(fontSize: 18),
                    indicator: UnderlineTabIndicator( // 被選中底線顏色
                        borderSide: BorderSide(color: Color.fromRGBO(29, 73, 153, 1))
                    ),
                    overlayColor: MaterialStateProperty.all(Color.fromRGBO(113, 170, 221, 1)),
                    tabs: [
                      Tab(text: '起始站查詢'),
                      Tab(text: '車次查詢'),
                      Tab(text: '車站查詢',)
                    ],
                  ),
                ),
                body: TabBarView(
                  //禁止左右滑動
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    TRA_TimeTableSearch_StartEndStation(),
                    TRA_TimeTableSearch_CarNumSearch(),
                    TRA_TimeTableSearch_ByStation()
                  ],
                ),
              )
          )
    );
  }
}
