// ignore_for_file: file_names, camel_case_types, use_super_parameters, prefer_typing_uninitialized_variables

import 'package:traffic_hero/imports.dart';

import 'TRA_TimeTableSearch_ByStation_InBound.dart';
import 'TRA_TimeTableSearch_ByStation_OutBound.dart';

class TRA_TimeTableSearch_ByStation_Result extends StatefulWidget {
  const TRA_TimeTableSearch_ByStation_Result({Key? key}) : super(key: key);

  @override
  State<TRA_TimeTableSearch_ByStation_Result> createState() => _TRA_TimeTableSearch_ByStation_ResultState();
}

class _TRA_TimeTableSearch_ByStation_ResultState extends State<TRA_TimeTableSearch_ByStation_Result> {
  // ignore: non_constant_identifier_names
  var StationName;
  var state;
  @override
  Widget build(BuildContext context) {
    state = Provider.of<stateManager>(context, listen: false);
    StationName = state.TRA_TimeTableSearch_Station;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
            length:2,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: const Color.fromRGBO(113, 170, 221, 1),
                title: Row(
                  children: [
                    BackButton(
                      color: Colors.white,
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                    Text(StationName+"車站",style: const TextStyle(color: Colors.white),),
                  ],
                ),
                bottom: TabBar(
                  labelColor: Colors.white,//被選中文字顏色,
                  labelStyle: const TextStyle(fontSize: 18),
                  indicator: const UnderlineTabIndicator( // 被選中底線顏色
                      borderSide: BorderSide(color: Color.fromRGBO(29, 73, 153, 1))
                  ),
                  overlayColor: MaterialStateProperty.all(const Color.fromRGBO(113, 170, 221, 1)),
                  tabs: const [
                    Tab(text: '順行'),
                    Tab(text: '逆行'),
                  ],
                ),
              ),
              body: const TabBarView(
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
