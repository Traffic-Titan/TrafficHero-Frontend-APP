// ignore_for_file: avoid_print, use_key_in_widget_constructors, prefer_typing_uninitialized_variables, unnecessary_null_comparison, non_constant_identifier_names, file_names

import 'package:traffic_hero/App_Page/Newbar_Page/Account_Manager.dart';

import 'package:traffic_hero/Imports.dart';


class Navbar extends StatefulWidget {
  const Navbar({
    super.key,
    required this.context,
  });
  final context;

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  final googleController = Get.put(googlesso());
  late stateManager state;
  var response;
  var name;
  late SharedPreferences prefs;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
    prefs = await SharedPreferences.getInstance();
  }

  Log_Out() {
    // googleController.google_signOut();
    prefs.setString('userToken', '');
    print(prefs.get('userToken'));
    state.updateAccountState('');
    state.updateModeState('car');
    EasyLoading.dismiss();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              state.profile?["name"] ?? '',
              style: const TextStyle(color: Colors.white),
            ),
            accountEmail: Text(
              state.profile?["email"] ?? '',
              style: const TextStyle(color: Colors.white),
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.memory(
                  base64Decode(state.profile?["avatar"] ?? ''),
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 41, 70, 95),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('會員管理'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const AccountManager()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('設定'),
            onTap: () {
              //setting
            },
          ),
          ListTile(
            leading: const Icon(Icons.heart_broken),
            title: const Text('我的最愛'),
            onTap: () {
              //favorite
            },
          ),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('關於我們'),
            onTap: () {
              //aboutus
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('說明與意見回饋'),
            onTap: () {
              //infor
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout_outlined),
            title: const Text('登出'),
            onTap: () {
              EasyLoading.dismiss();
              Log_Out();
            },
          ),
    ]));
  }
}
