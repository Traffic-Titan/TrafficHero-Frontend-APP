// ignore_for_file: file_names, camel_case_types, prefer_typing_uninitialized_variables
import 'package:traffic_hero/imports.dart';





//主程式
class ScooterMode extends StatefulWidget {
  const ScooterMode({super.key});

  @override
  State<ScooterMode> createState() => _ScooterMode();
}

class _ScooterMode extends State<ScooterMode> {
  
  final List<BottomNavigationBarItem> bottonTabs = [
    const BottomNavigationBarItem(
        label: '首頁', icon: Icon(CupertinoIcons.home), tooltip: "首頁"),
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
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        unselectedFontSize: 0,
        selectedFontSize: 20,
        
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          // 图标大小
          size: 40,
          // 图标透明度
          opacity: 1.0,
        ),
        unselectedIconTheme: const IconThemeData(
          size: 40,
          // 图标透明度
          opacity: 1.0,
        ),
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        backgroundColor: Color.fromRGBO(46, 117, 182, 1),
        items: bottonTabs,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            currentPage = tabBodies[currentIndex];
          });
        },
      ),
      body: currentPage,
      backgroundColor: const Color.fromARGB(255, 254, 254, 254),
    );
  }
}

