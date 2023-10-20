// ignore_for_file: avoid_print, non_constant_identifier_names, prefer_typing_uninitialized_variables, file_names, use_build_context_synchronously, dead_code_catch_following_catch, unnecessary_null_comparison, sized_box_for_whitespace, prefer_interpolation_to_compose_strings, camel_case_types
import 'package:traffic_hero/Imports.dart';

class appLoadingPage extends StatefulWidget {
  const appLoadingPage({super.key});

  @override
  State<appLoadingPage> createState() => _appLoadingPage();
}

class _appLoadingPage extends State<appLoadingPage> {
  late stateManager state;
  late SharedPreferences prefs;

//當頁面創造時執行
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    prefs = await SharedPreferences.getInstance();
    state = Provider.of<stateManager>(context, listen: false);
    checkToken();
    EasyLoading.dismiss();

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    try {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print('Running on ${androidInfo.device}');
      if (androidInfo.device != null) {
        prefs.setString('system', 'Android');
      }
    } catch (e) {
      print(e);
    }

    try {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print('Running on ${iosInfo.utsname.machine}'); 
      if (iosInfo.utsname.machine != null) {
        prefs.setString('system', 'IOS');
      }
    } catch (e) {
      print(e);
    }

    print(prefs.get('system'));
  }

  //執行token驗證並作出相對應的動作
  checkToken() async {
    EasyLoading.show(status: '登入中');
    var response;
    var url = dotenv.env['Profile'];
    var jwt = ',${prefs.get('userToken')}';
    print(jwt);
    try {
      response = await api().apiGet(url, jwt);
      state.updateAccountState('${prefs.get('userToken')}');

      if (response.statusCode == 200) {
        state.updateprofileState(jsonDecode(utf8.decode(response.bodyBytes)));
        await getOperationalStatus();
        await getWeather();
        await getUser();

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const AllPage()));
        EasyLoading.dismiss();
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Login()));
        EasyLoading.dismiss();
      }
    } catch (e) {
      print(e);
      EasyLoading.dismiss();
    }
  }

//抓取資料
  getOperationalStatus() async {
    var position = await geolocator().updataPosition();
    var url =
        '${dotenv.env['OperationalStatus']}?longitude=${position.longitude}&latitude=${position.latitude}';
    var jwt = ',${prefs.get('userToken')}';

    var response = await api().apiGet(url, jwt);
    print(jsonDecode(utf8.decode(response.bodyBytes)));
    if (response.statusCode == 200) {
      state
          .updateOperationalStatus(jsonDecode(utf8.decode(response.bodyBytes)));
      print(state.OperationalStatus);
      print('${state.OperationalStatus}test');
    } else {
      print(jsonDecode(utf8.decode(response.bodyBytes)));
    }
  }

  getWeather() async {
    var position = await geolocator().updataPosition();
    var response;
    var url = dotenv.env['Weather'].toString() +
        '?longitude=${position.longitude}&latitude=${position.latitude}';
    var jwt = ',${prefs.get('userToken')}';
    print(jwt);
    try {
      response = await api().apiGet(url, jwt);
    } catch (e) {
      print(e);
    }

    try {
      if (response.statusCode == 200) {
        print(jsonDecode(utf8.decode(response.bodyBytes)));
        state.updateWeatherState(jsonDecode(utf8.decode(response.bodyBytes)));
      } else {
        print(jsonDecode(utf8.decode(response.bodyBytes)));
      }
    } catch (e) {
      print(e);
    }
  }

  getUser() async {
    var response;
    var url = dotenv.env['Profile'];
    var jwt = ',${prefs.get('userToken')}';
    print(jwt);
    try {
      response = await api().apiGet(url, jwt);
    } catch (e) {
      print(e);
    }

    if (response.statusCode == 200) {
      state.updateprofileState(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      print(jsonDecode(utf8.decode(response.bodyBytes)));
    }
  }

//app執行創建的頁面
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromRGBO(62, 111, 179, 1),
        body: Text(''));
  }
}
