// ignore_for_file: avoid_print, use_key_in_widget_constructors, prefer_typing_uninitialized_variables, unnecessary_null_comparison, non_constant_identifier_names, file_names
import 'package:traffic_hero/imports.dart';

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
  }

  Log_Out() {
    // googleController.google_signOut();
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
