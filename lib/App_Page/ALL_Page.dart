// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, camel_case_types, file_names, avoid_print
import 'package:traffic_hero/imports.dart';

class All_Page extends StatefulWidget {
  const All_Page({super.key});

  @override
  State<All_Page> createState() => _All_PageState();
}

class _All_PageState extends State<All_Page> {
  late stateManager state;
  var mode = 'car';
  var car = 'assets/topbar/Mode_Car.png';
  var scooter = 'assets/topbar/select_scooter.png';
  var public_Transport = 'assets/topbar/select_Public_Transport.png';
  bool login_before_state = true;
  bool login_after_state = false;
  final googleController = Get.put(googlesso());

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
    //螢幕方向轉正
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void initState() {
    super.initState();
  }

  void selectedMode(value) {
    setState(() {
      mode = value;
    });
  }

  void get_User() async {
    var response;
    var url = '/Account/Profile';
    var jwt = state.accountState;
    try {
      response = await api().api_Get(url, jwt);
    } catch (e) {
      print('object');
    }

    if (response.statusCode == 200) {
      state.updateprofileState(jsonDecode(utf8.decode(response.bodyBytes)));
    }
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
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      endDrawer: Drawer(
        child: Navbar(
          context: context,
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(46, 117, 182, 1),
        elevation: 0,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Image.asset(car),
                iconSize: 50,
                onPressed: () {
                  selectedMode('car');
                  setState(() {
                    car = 'assets/topbar/Mode_Car.png';
                    scooter = 'assets/topbar/select_scooter.png';
                    public_Transport =
                        'assets/topbar/select_Public_Transport.png';
                  });
                  //將狀態儲存為car
                  state.updateModeState('car');
                },
              ),
              IconButton(
                icon: Image.asset(scooter),
                iconSize: 50,
                onPressed: () {
                  selectedMode('scooter');
                  setState(() {
                    car = 'assets/topbar/select_car.png';
                    scooter = 'assets/topbar/Mode_Scooter.png';
                    public_Transport =
                        'assets/topbar/select_Public_Transport.png';
                  });
                  state.updateModeState('scooter');
                },
              ),
              IconButton(
                icon: Image.asset(public_Transport),
                iconSize: 50,
                onPressed: () {
                  setState(() {
                    car = 'assets/topbar/select_car.png';
                    scooter = 'assets/topbar/select_scooter.png';
                    public_Transport =
                        'assets/topbar/Mode_Public_Transport.png';
                  });
                  selectedMode('publicTransport');
                  state.updateModeState('publicTransport');
                },
              ),
            ],
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset('assets/topbar/SmartAssistant.png'),
          iconSize: 50,
          onPressed: () => print('object'),
        ),
        actions: <Widget>[
          IconButton(
            icon: CircleAvatar(
                child: ClipOval(
                    child: Image.memory(
              base64Decode(state.profile?["avatar"]),
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ))),
            // Image.asset("assets/topbar/Default_Avatar.png"),
            iconSize: 50,
            onPressed: () async {
              scaffoldKey.currentState!.openEndDrawer();
              get_User();
            },
          ),
        ],
      ),
      body: changeMode(),
    );
  }
}
