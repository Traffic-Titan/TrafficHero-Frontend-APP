// ignore_for_file: camel_case_types, file_names
import 'package:traffic_hero/App_Page/App_Function_Page/Public_Transport_Information_Page/THSR_CarNumSearch.dart';
import 'package:traffic_hero/App_Page/App_Function_Page/Public_Transport_Information_Page/THSR_StartEndStationSearch.dart';
import 'package:traffic_hero/Imports.dart';

// ignore_for_file: unused_local_variable
class Public_Transport_Information_Highway extends StatefulWidget {
  const Public_Transport_Information_Highway({super.key});

  @override
  State<Public_Transport_Information_Highway> createState() =>
      _Public_Transport_Information_HighwayState();
}

class _Public_Transport_Information_HighwayState
    extends State<Public_Transport_Information_Highway> {
  @override
  Widget build(BuildContext context) {
    var state = Provider.of<stateManager>(context, listen: false);
    var screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: const Color.fromRGBO(113, 170, 221, 1),
                toolbarHeight: 0,
                bottom: TabBar(
                  labelColor: Colors.white, //被選中文字顏色,
                  labelStyle: const TextStyle(fontSize: 18),
                  indicator: const UnderlineTabIndicator(
                      // 被選中底線顏色
                      borderSide:
                          BorderSide(color: Color.fromRGBO(29, 73, 153, 1))),
                  overlayColor: MaterialStateProperty.all(
                      const Color.fromRGBO(113, 170, 221, 1)),
                  tabs: const [
                    Tab(text: '起迄站查詢'),
                    Tab(text: '車次查詢'),
                  ],
                ),
              ),
              body: const TabBarView(
                //禁止左右滑動
                physics: NeverScrollableScrollPhysics(),
                children: [THSR_StartEndStationSearch(), THSR_CarNumSearch()],
              ),
            )));
  }
}
