// ignore_for_file: camel_case_types, library_private_types_in_public_api, file_names, unused_import, override_on_non_overriding_member, prefer_typing_uninitialized_variables, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:traffic_hero/App_Page/App_Function_Page/Road_Information/Road_Information_ParkingLot.dart';
import 'package:traffic_hero/imports.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart'; // Make sure to import the correct package

class Road_Information extends StatefulWidget {
  const Road_Information({Key? key}) : super(key: key);

  @override
  _Road_InformationState createState() => _Road_InformationState();
}

class _Road_InformationState extends State<Road_Information> {
  late stateManager state;
  var position;
  var screenWidth;
  var screenHeight;
  var positionNow;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
          length: 5,
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: const Color.fromRGBO(113, 170, 221, 1),
                toolbarHeight: 0,
                bottom: TabBar(
                  // labelColor: //被選種顏色,
                  // unselectedLabelColor: //未被選種顏色,
                  // controller: _tabController,
                  tabs: [
                    Tab(text: '停車場'),
                    Tab(text: '道路施工'),
                    Tab(text: '車禍'),
                    Tab(text: '道路封閉'),
                  ],
                ),

              ),
              body: TabBarView(
                //禁止左右滑動
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Road_Information_ParkingLot()
                ],
              )
          ),
        )
    );
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
    positionNow = state.positionNow;
    screenWidth = MediaQuery. of(context). size. width ;
    screenHeight = MediaQuery. of(context). size. height;
    position = await geolocator().updataPosition();

  }
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }

}
