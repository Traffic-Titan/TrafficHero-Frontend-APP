import 'package:traffic_hero/Imports.dart';

class CMSPIP extends StatefulWidget {
  const CMSPIP({super.key});

  @override
  State<CMSPIP> createState() => _CMSPIPState();
}

class _CMSPIPState extends State<CMSPIP> {
  late stateManager state;
  late SharedPreferences prefs;
  var screenWidth;
  var fontSize;
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    prefs = await SharedPreferences.getInstance();
    state = Provider.of<stateManager>(context, listen: false);
    screenWidth = MediaQuery.of(context).size.width;
    fontSize = screenWidth * 0.05;
  }

  @override
  void initState() {
    super.initState();
     FlPiP().status.addListener(listener);
     FlPiP().enable(
                ios: const FlPiPiOSConfig(
                    path: 'assets/landscape.mp4', packageName: null),
                android: const FlPiPAndroidConfig(
                    aspectRatio: Rational.maxLandscape()));
   
  }

  void listener() {
    if (FlPiP().status.value == PiPStatus.enabled) {
      FlPiP().toggle(AppState.background);
    }
  }

  @override
  void dispose() {
    super.dispose();
    FlPiP().status.removeListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [Text('dat')],
    ),);
    
    
    
  }
}


//回家做