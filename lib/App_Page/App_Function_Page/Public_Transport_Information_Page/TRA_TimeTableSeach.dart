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
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
            length:3,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: const Color.fromRGBO(113, 170, 221, 1),
                toolbarHeight: 0,
                bottom: TabBar(
                  // labelColor: //被選種顏色,
                  // unselectedLabelColor: //未被選種顏色,
                  // controller: _tabController,
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
