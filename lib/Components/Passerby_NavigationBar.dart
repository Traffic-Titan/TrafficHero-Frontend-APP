// ignore_for_file: file_names, camel_case_types, prefer_typing_uninitialized_variables
import 'package:traffic_hero/App_Page/App_Function_Page/CMS_Page.dart';
import 'package:traffic_hero/App_Page/App_Function_Page/Road_Information_Page.dart';
import 'package:traffic_hero/App_Page/App_Function_Page/Route_Planning.dart';
import 'package:traffic_hero/App_Page/App_Function_Page/Tourist_Information_Page.dart';
import 'package:traffic_hero/imports.dart';

//主程式
class PasserbyPage extends StatefulWidget {
  const PasserbyPage({super.key});
  @override
  State<PasserbyPage> createState() => _PasserbyPage();
}

class _PasserbyPage extends State<PasserbyPage> {
  late stateManager state;

  final List<BottomNavigationBarItem> carAndScooterBottonTabs = [
    const BottomNavigationBarItem(
        label: '首頁', icon: Icon(CupertinoIcons.home), tooltip: "首頁"),
    const BottomNavigationBarItem(
        label: '最新消息', icon: Icon(CupertinoIcons.news_solid), tooltip: "最新消息"),
    const BottomNavigationBarItem(
        label: '訊息推播', icon: Icon(CupertinoIcons.text_bubble), tooltip: "即時訊息推播"),
    const BottomNavigationBarItem(
        label: '道路資訊', icon: Icon(CupertinoIcons.news_solid), tooltip: "道路資訊"),
    const BottomNavigationBarItem(
        label: '觀光資訊', icon: Icon(CupertinoIcons.news_solid), tooltip: "觀光資訊"),
  ];
  final List carAndScooterNavigationBar = [
    const Home(),
    const News(),
    const CMS(),
    const Road_Information(),
    const Tourist_Information(),
  ];
  final List<BottomNavigationBarItem> publicTransportModeBottonTabs = [
    const BottomNavigationBarItem(
        label: '首頁', icon: Icon(CupertinoIcons.home), tooltip: "首頁"),
    const BottomNavigationBarItem(
        label: '最新消息', icon: Icon(CupertinoIcons.news_solid), tooltip: "最新消息"),
    const BottomNavigationBarItem(
        label: '路線規劃', icon: Icon(CupertinoIcons.placemark), tooltip: "路線規劃"),
    const BottomNavigationBarItem(
        label: '道路資訊', icon: Icon(CupertinoIcons.news_solid), tooltip: "道路資訊"),
    const BottomNavigationBarItem(
        label: '觀光資訊', icon: Icon(CupertinoIcons.news_solid), tooltip: "觀光資訊"),
  ];
  final List publicTransportModeNavigationBar = [
    const Home(),
    const News(),
    const Route_Planning(),
    const Road_Information(),
    const Tourist_Information(),
  ];

//將預設標籤設定為0
  int currentIndex = 0;
  var currentPage;

  @override
  void initState() {
    currentPage = carAndScooterNavigationBar[currentIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    state = Provider.of<stateManager>(context, listen: false);
    List tabBodies;
    List<BottomNavigationBarItem> bottonTabs;
    if(state.modeName == 'publicTransport'){
      tabBodies = publicTransportModeNavigationBar;
      bottonTabs = publicTransportModeBottonTabs;
    }else{
      tabBodies = carAndScooterNavigationBar;
      bottonTabs = carAndScooterBottonTabs;
    }
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
