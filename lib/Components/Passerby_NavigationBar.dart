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
  var navigationBar_text = '';
  late List<BottomNavigationBarItem> carAndScooterBottonTabs;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
    if (state!.modeName == 'publicTransport') {
      setState(() {
        navigationBar_text = '大眾運輸資訊';
      });
    } else {
      setState(() {
        navigationBar_text = '道路資訊';
      });
    }

    carAndScooterBottonTabs = [
      const BottomNavigationBarItem(
          label: '首頁', icon: Icon(CupertinoIcons.home), tooltip: "首頁",backgroundColor: Colors.blue),
      const BottomNavigationBarItem(
          label: '最新消息',
          icon: Icon(CupertinoIcons.news_solid),
          tooltip: "最新消息",
          backgroundColor: Colors.blue),
          
      const BottomNavigationBarItem(
          label: '即時訊息推播',
          icon: Icon(CupertinoIcons.text_bubble),
          tooltip: "即時訊息推播",
          backgroundColor: Colors.blue),
      BottomNavigationBarItem(
          label: navigationBar_text.toString(),
          icon: Icon(CupertinoIcons.news_solid),
          tooltip: navigationBar_text.toString(),
          backgroundColor: Colors.blue),
      const BottomNavigationBarItem(
          label: '觀光資訊',
          icon: Icon(CupertinoIcons.news_solid),
          tooltip: "觀光資訊",
          backgroundColor: Colors.blue),
    ];
  }

  final List carAndScooterNavigationBar = [
    const Home(),
    const News(),
    const CMS(),
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

    tabBodies = carAndScooterNavigationBar;
    bottonTabs = carAndScooterBottonTabs;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: currentIndex,
        fixedColor: Colors.white,
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
