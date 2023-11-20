// ignore_for_file: file_names, camel_case_types, prefer_typing_uninitialized_variables, prefer_const_constructors, non_constant_identifier_names
import 'package:traffic_hero/Imports.dart';

//主程式
class PasserbyPage extends StatefulWidget {
  const PasserbyPage({super.key});
  @override
  State<PasserbyPage> createState() => _PasserbyPage();
}

class _PasserbyPage extends State<PasserbyPage> {
  late stateManager? state;
  var roadInfoPageText = '';
  var roadInfoPageIcon;
  var CMSPageText = '';
  var CMSPageIcon;
  late List<BottomNavigationBarItem> bottomTabslist;
  late List<BottomNavigationBarItem> bottomTabslist2;

  late List<BottomNavigationBarItem> modeNavBar;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
    if (state!.modeName == 'publicTransport') {
      setState(() {
        roadInfoPageText = '大眾運輸';
        roadInfoPageIcon = Icon(CupertinoIcons.bus);
        CMSPageText = '路線規劃';
        CMSPageIcon = Icon(CupertinoIcons.arrow_branch);
       
      });
    } else {
      setState(() {
        roadInfoPageText = '道路資訊';
        roadInfoPageIcon = Icon(CupertinoIcons.map_fill);
        CMSPageText = '訊息推播';
        CMSPageIcon = Icon(CupertinoIcons.conversation_bubble);
       
      });
    }
    bottomTabslist = [
      const BottomNavigationBarItem(
          label: '首頁',
          icon: Icon(CupertinoIcons.home),
          tooltip: "首頁",
          backgroundColor: Colors.blue),
      const BottomNavigationBarItem(
          label: '最新消息',
          icon: Icon(CupertinoIcons.news_solid),
          tooltip: "最新消息",
          backgroundColor: Colors.blue),
      BottomNavigationBarItem(
          label: CMSPageText.toString(),
          icon: CMSPageIcon,
          tooltip: CMSPageText.toString(),
          backgroundColor: Colors.blue),
      BottomNavigationBarItem(
          label: roadInfoPageText.toString(),
          icon: roadInfoPageIcon,
          tooltip: roadInfoPageText.toString(),
          backgroundColor: Colors.blue),
      const BottomNavigationBarItem(
          label: '觀光資訊',
          icon: Icon(CupertinoIcons.placemark_fill),
          tooltip: "觀光資訊",
          backgroundColor: Colors.blue),
    ];

    bottomTabslist2 = [
      const BottomNavigationBarItem(
          label: '首頁',
          icon: Icon(CupertinoIcons.home),
          tooltip: "首頁",
          backgroundColor: Colors.blue),
      const BottomNavigationBarItem(
          label: '最新消息',
          icon: Icon(CupertinoIcons.news_solid),
          tooltip: "最新消息",
          backgroundColor: Colors.blue),
      BottomNavigationBarItem(
          label: roadInfoPageText.toString(),
          icon: roadInfoPageIcon,
          tooltip: roadInfoPageText.toString(),
          backgroundColor: Colors.blue),
      const BottomNavigationBarItem(
          label: '觀光資訊',
          icon: Icon(CupertinoIcons.placemark_fill),
          tooltip: "觀光資訊",
          backgroundColor: Colors.blue),
    ];
  }

  void _navigateToCMS(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CMS()), // 創建新的空白頁面
    );
  }

  final List carAndScooterNavigationBar = [
    const Home(),
    const News(),
    const CMS(),
    const Road_Information(),
    const Tourist_Information(),
  ];
  final List publicTransportNavigationBar = [
    const Home(),
    const News(),
    const Public_Transport_Information(),
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
    List<BottomNavigationBarItem> bottomTabs;

    tabBodies = carAndScooterNavigationBar;
    bottomTabs = state?.modeName == 'publicTransport' ? bottomTabslist2 : bottomTabslist;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 100,
        currentIndex: currentIndex,
        unselectedItemColor: Colors.white,
        selectedItemColor: Color.fromRGBO(67, 150, 200, 1),
        backgroundColor: const Color.fromRGBO(62, 111, 179, 1),
        items: bottomTabs,
        onTap: (index) {
          if (state!.modeName == 'publicTransport') {
            setState(() {
              tabBodies = publicTransportNavigationBar;
            });
          } else {
            setState(() {
              tabBodies = carAndScooterNavigationBar;
              if (index == 2) {
                //跳轉CMS葉面
                _navigateToCMS(context);
                index = 0;
              }
            });
          }
          currentIndex = index;
          currentPage = tabBodies[currentIndex];
        },
      ),
      body: currentPage,
      backgroundColor: const Color.fromARGB(255, 254, 254, 254),
    );
  }
}
