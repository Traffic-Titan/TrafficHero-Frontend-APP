// ignore_for_file: avoid_print, non_constant_identifier_names, prefer_typing_uninitialized_variables, file_names, use_build_context_synchronously, dead_code_catch_following_catch, unnecessary_null_comparison, sized_box_for_whitespace, prefer_interpolation_to_compose_strings, camel_case_types, prefer_const_constructors
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
    EasyLoading.show(status: '登入中...');
    checkToken();
    EasyLoading.dismiss();
    Firebase_message().UpdateContext(context);
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

//確認是哪個作業系統
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
    EasyLoading.show(status: '登入中...');
    var response;
    var url = dotenv.env['Profile'];
    var jwt = ',${prefs.get('userToken')}';
    print(jwt);
    try {
      EasyLoading.show(status: '登入中...');

      response = await api().apiGet(url, jwt);
      state.updateAccountState('${prefs.get('userToken')}');
      await getHome().getUser(context);
      if (response.statusCode == 200) {
        //將抓到的身份資料寫入狀態
        state.updateprofileState(jsonDecode(utf8.decode(response.bodyBytes)));
        //將之前紀錄的模式洩入模式的狀態
        state.updateModeState(prefs.get('mode').toString());
        //確認token沒有過期登入成功
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const AllPage()),
            (router) => false);
        EasyLoading.dismiss();
      } else {
         //確認token有過期登入失敗 
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Login()),
            (router) => false);
        EasyLoading.dismiss();
      }
    } catch (e) {
      print(e);
      EasyLoading.dismiss();
      Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Login()),
            (router) => false);
    }
  }

//app執行創建的頁面
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromRGBO(62, 111, 179, 1),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
                child: Image.asset(
                  'assets/AppIcon.png',
                  width: 200,
                  height: 200,
                ),
              ),
            ],
          ),
        ));
  }
}
