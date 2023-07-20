// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, camel_case_types, file_names, avoid_print
import 'package:traffic_hero/imports.dart';



class All_Page extends StatefulWidget {
  const All_Page({super.key});

  @override
  State<All_Page> createState() => _All_PageState();
}

class _All_PageState extends State<All_Page> {
  late stateManager state;
  var mode;
  bool login_before_state = true;
  bool login_after_state = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
    if (state.accountState == '') {
      setState(() {
        login_before_state = true;
      });
    } else {
      setState(() {
        login_after_state = true;
        login_before_state = false;
      });
    }
  }

  void selectedMode(value) {
    setState(() {
      mode = value;
    });
  }

  Widget changeMode() {
    if (mode == 'car') {
      return const CarMode();
    } else if (mode == 'scooter') {
      return const ScooterMode();
    } else {
      return const PublicTransportMode();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(46, 117, 182, 1),
        elevation: 0,
        title:  Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Image.asset("assets/topbar/Mode_Car.png"),
                  iconSize: 50,
                  onPressed: () {
                    selectedMode('car');
                    //將狀態儲存為car
                    state.updateModeState('car');
                  },
                ),
                
                IconButton(
                  icon: Image.asset("assets/topbar/Mode_Scooter.png"),
                  iconSize: 50,
                  onPressed: () {
                    selectedMode('scooter');
                    state.updateModeState('scooter');
                  },
                ),
                IconButton(
                  icon: Image.asset("assets/topbar/Mode_Masstransit.png"),
                  iconSize: 50,
                  onPressed: () {
                    selectedMode('masstransit');
                    state.updateModeState('masstransit');
                  },
                ),
              ],
            ),
          ),
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset("assets/topbar/SmartAssistant.png"),
          iconSize: 50,
          onPressed: () => print('smart Assistant'),
        ),
        
       actions: <Widget>[
          if (login_before_state)
            PopupMenuButton<String>(
              icon: Image.asset("assets/topbar/Default_Avatar.png"),
              iconSize: 50,
              offset: Offset(0, AppBar().preferredSize.height),
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem<String>(
                    value: '1',
                    child: Text('登入'),
                  ),
                ];
              },
              onSelected: (value) {
                if (value == '1') {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Login()));
                } else {
                  throw Exception("資料異常！！！");
                }
              },
            ),
          if (login_after_state)
            PopupMenuButton<String>(
              icon: Image.asset("assets/topbar/Default_Avatar.png"),
              iconSize: 50,
              offset: Offset(0, AppBar().preferredSize.height),
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem<String>(
                    value: '1',
                    child: Text('修改密碼'),
                  ),
                  const PopupMenuItem<String>(
                    value: '2',
                    child: Text('登出'),
                  ),
                ];
              },
              onSelected: (value) {
                if (value == '1') {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ChangePassword()));
                } else if (value == '2') {
                  state.updateAccountState('');
                  setState(() {
                    login_after_state = false;
                    login_before_state = true;
                  });
                } else {
                  throw Exception("資料異常！！！");
                }
              },
            ),
        ],
      ),
      body: changeMode(),
    );
  }
}
