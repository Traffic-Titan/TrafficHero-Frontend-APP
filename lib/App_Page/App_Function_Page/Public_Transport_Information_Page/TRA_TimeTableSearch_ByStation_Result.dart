import 'package:traffic_hero/imports.dart';

import 'TRA_TimeTableSearch_ByStation_InBound.dart';
import 'TRA_TimeTableSearch_ByStation_OutBound.dart';

class TRA_TimeTableSearch_ByStation_Result extends StatefulWidget {
  const TRA_TimeTableSearch_ByStation_Result({Key? key}) : super(key: key);

  @override
  State<TRA_TimeTableSearch_ByStation_Result> createState() => _TRA_TimeTableSearch_ByStation_ResultState();
}

class _TRA_TimeTableSearch_ByStation_ResultState extends State<TRA_TimeTableSearch_ByStation_Result> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
            length:2,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: const Color.fromRGBO(113, 170, 221, 1),
                toolbarHeight: 0,
                bottom: TabBar(
                  // labelColor: //被選種顏色,
                  // unselectedLabelColor: //未被選種顏色,
                  // controller: _tabController,
                  tabs: [
                    Tab(text: '順行'),
                    Tab(text: '逆行'),
                  ],
                ),
              ),
              body: TabBarView(
                //禁止左右滑動
                physics: NeverScrollableScrollPhysics(),
                children: [
                  TRA_TimeTableSearch_ByStation_OutBound(),
                  TRA_TimeTableSearch_ByStation_InBound(),
                ],
              ),
            )
        )
    );
  }
}
