// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, camel_case_types, file_names, avoid_print, prefer_const_constructors
import 'package:traffic_hero/Imports.dart';
import 'package:traffic_hero/imports.dart';

class AllPage extends StatefulWidget {
  const AllPage({super.key});

  @override
  State<AllPage> createState() => _AllPageState();
}

class _AllPageState extends State<AllPage> {
  late stateManager state;
  late SharedPreferences prefs;
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

    if(state.modeName == 'car'){
      setState(() {
         car = 'assets/topbar/Mode_Car.png';
                    scooter = 'assets/topbar/select_scooter.png';
                    public_Transport =
                        'assets/topbar/select_Public_Transport.png';
      });
    }else if(state.modeName == 'scooter'){
      setState(() {
                    car = 'assets/topbar/select_car.png';
                    scooter = 'assets/topbar/Mode_Scooter.png';
                    public_Transport =
                        'assets/topbar/select_Public_Transport.png';
                  });
    }else{
       setState(() {
                    car = 'assets/topbar/select_car.png';
                    scooter = 'assets/topbar/select_scooter.png';
                    public_Transport =
                        'assets/topbar/Mode_Public_Transport.png';
                  });
    }
    prefs = await SharedPreferences.getInstance();
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
        backgroundColor: const Color.fromRGBO(62, 111, 179, 1),
        elevation: 0,
        toolbarHeight: 65,
        shadowColor: const Color.fromRGBO(62, 111, 179, 1),
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // IconButton(
              //   icon: Image.asset(public_Transport,width: 50,height: 50,),
                
              //   onPressed: () {
              //     setState(() {
              //       car = 'assets/topbar/select_car.png';
              //       scooter = 'assets/topbar/select_scooter.png';
              //       public_Transport =
              //       'assets/topbar/Mode_Public_Transport.png';
              //     });
              //     selectedMode('publicTransport');
              //     state.updateModeState('publicTransport');
              //   },
              // ),
              IconButton(
                icon: Image.asset(car,width: 50,height: 50,),
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
                  prefs.setString('mode', 'car');
                },
              ),
              IconButton(
                icon: Image.asset(scooter,width: 50,height: 50,),
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
                  prefs.setString('mode','scooter');
                },
              ),
              IconButton(
                icon: Image.asset(public_Transport,width: 50,height: 50,),
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
                  prefs.setString('mode','publicTransport');
                },
              ),
            ],
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset('assets/topbar/message.png',width: 50,height: 50,),
          iconSize: 50,
          onPressed: (){
           Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => messagePage()));
          },
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
              // get_User();
            },
          ),
        ],
      ),
      body: changeMode(),
    );
  }
}
