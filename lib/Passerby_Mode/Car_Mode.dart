// ignore_for_file: file_names, camel_case_types, prefer_typing_uninitialized_variables
import 'package:traffic_hero/imports.dart';
import 'package:flutter/cupertino.dart';

//主程式
class CarMode extends StatefulWidget {
  const CarMode({super.key});
  @override
  State<CarMode> createState() => _CarMode();
}

class _CarMode extends State<CarMode> {
  
  final List<BottomNavigationBarItem> bottonTabs = [
    const BottomNavigationBarItem(
        label: '汽車首頁', icon: Icon(CupertinoIcons.home), tooltip: "汽車首頁"),
    const BottomNavigationBarItem(
        label: '最新消息', icon: Icon(CupertinoIcons.news_solid), tooltip: "最新消息"),
    
  ];

  final List tabBodies = [
    const Home(),
    const News(),
    
  ];

//將預設標籤設定為0
  int currentIndex = 0;
  var currentPage;

  @override
  void initState() {
    currentPage = tabBodies[currentIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: bottonTabs,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            currentPage = tabBodies[currentIndex];
          });
        },
      ),
      body: currentPage,
      backgroundColor: const Color.fromRGBO(255, 255, 255, 0.498),
    );
  }
}
