// ignore_for_file: file_names, camel_case_types

import 'package:traffic_hero/App_Page/App_Function_Page/Public_Transport_Information_Page/TRA_TimeTableSearch_ByStation.dart';
import 'package:traffic_hero/App_Page/App_Function_Page/Public_Transport_Information_Page/TRA_TimeTableSearch_CarNumSearch.dart';
import 'package:traffic_hero/App_Page/App_Function_Page/Public_Transport_Information_Page/TRA_TimeTableSearch_StartEndStation.dart';
import 'package:traffic_hero/imports.dart';

class TRA_TimeTableSearch extends StatefulWidget {
  const TRA_TimeTableSearch({super.key});

  @override
  State<TRA_TimeTableSearch> createState() => _TRA_TimeTableSearchState();
}

class _TRA_TimeTableSearchState extends State<TRA_TimeTableSearch> {

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
              length:3,
              child: Scaffold(
                appBar: AppBar(
                  leading: BackButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                  iconTheme: const IconThemeData(//返回鍵顏色
                    color:Colors.white, //change your color here
                  ),
                  title: const Text('火車時刻表條件查詢',style: TextStyle(color:Colors.white),),
                  backgroundColor: const Color.fromRGBO(113, 170, 221, 1),
                  bottom: TabBar(
                    labelColor: Colors.white,//被選中文字顏色,
                    labelStyle: const TextStyle(fontSize: 18),
                    indicator: const UnderlineTabIndicator( // 被選中底線顏色
                        borderSide: BorderSide(color: Color.fromRGBO(29, 73, 153, 1))
                    ),
                    overlayColor: MaterialStateProperty.all(const Color.fromRGBO(113, 170, 221, 1)),
                    tabs: const [
                      Tab(text: '起始站查詢'),
                      Tab(text: '車次查詢'),
                      Tab(text: '車站查詢',)
                    ],
                  ),
                ),
                body: const TabBarView(
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
