
// ignore_for_file: unused_local_variable

import 'package:traffic_hero/App_Page/App_Function_Page/Public_Transport_Information_Page/MRT_AnkengLRT.dart';
import 'package:traffic_hero/App_Page/App_Function_Page/Public_Transport_Information_Page/MRT_DanhaiLRT.dart';
import 'package:traffic_hero/App_Page/App_Function_Page/Public_Transport_Information_Page/MRT_Kaohsiung.dart';
import 'package:traffic_hero/App_Page/App_Function_Page/Public_Transport_Information_Page/MRT_Taichung.dart';
import 'package:traffic_hero/App_Page/App_Function_Page/Public_Transport_Information_Page/MRT_Taipei.dart';
import 'package:traffic_hero/App_Page/App_Function_Page/Public_Transport_Information_Page/MRT_Taoyuan.dart';
import 'package:traffic_hero/Imports.dart';

//捷運頁面
Widget publicTransportInfoMRT(context){
  var state = Provider.of<stateManager>(context, listen: false);
  var  screenWidth = MediaQuery. of(context). size. width ;
  return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
          length: 6,
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: const Color.fromRGBO(113, 170, 221, 1),
                toolbarHeight: 0,
                bottom: TabBar(
                  labelColor:Colors.white,//被選中文字顏色,
                  labelStyle: TextStyle(fontSize: 18),
                  indicator: UnderlineTabIndicator( // 被選中底線顏色
                      borderSide: BorderSide(color: Color.fromRGBO(29, 73, 153, 1))
                  ),
                  overlayColor: MaterialStateProperty.all(Color.fromRGBO(113, 170, 221, 1)),
                  tabs: [
                    Tab(text: '臺北捷運'),
                    Tab(text: '淡海輕軌'),
                    Tab(text: '安坑輕軌'),
                    Tab(text: '桃園捷運'),
                    Tab(text: '臺中捷運'),
                    Tab(text: '高雄捷運'),
                  ],
                  isScrollable: true,
                ),
              ),
              body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  MRT_Taipei(),
                  MRT_DanhaiLRT(),
                  MRT_AnkengLRT(),
                  MRT_Taoyuan(),
                  MRT_Taichung(),
                  MRT_Kaohsiung()
                ],
              ),
          )
      )
  );
}



