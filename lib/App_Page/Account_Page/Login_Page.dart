// ignore_for_file: avoid_print, non_constant_identifier_names, prefer_typing_uninitialized_variables, file_names, use_build_context_synchronously, dead_code_catch_following_catch, unnecessary_null_comparison, sized_box_for_whitespace, prefer_interpolation_to_compose_strings
import 'package:traffic_hero/Imports.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  late stateManager state;
  late SharedPreferences prefs;
  final usernameController = TextEditingController(),
      passwordController = TextEditingController(),
      googleController = Get.put(googlesso());
  var showLoginError = false, showPassword = true, errorText = '', response;
  int count = 0;

//當頁面創造時執行
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    prefs = await SharedPreferences.getInstance();
    state = Provider.of<stateManager>(context, listen: false);
    var position = await geolocator().updataPosition(context);
    state.changePositionNow(position);
    EasyLoading.dismiss();
  }


//執行google sign in
  handlesignIn(GoogleSignInAccount? account) async {
    var body = {
      "email": googleController.googleAccount.value?.email ?? '',
      "google_id": googleController.googleAccount.value?.id ?? '',
    };

    var url = dotenv.env['GoogleSSO'].toString();
    var jwt = '';

    if (account != null) {
      try {
        response = await api().apiPost(body, url, jwt);
      } catch (e) {
        print(e);
      }

      try {
        if (response.statusCode == 200) {
          //將狀態寫入
          state.updateAccountState(
              await jsonDecode(response.body)['token'] ?? '');
          //跳轉頁面
          print(await jsonDecode(response.body)['token']);
          await prefs.setString(
              'userToken', jsonDecode(response.body)['token']);
          EasyLoading.dismiss();
          print(prefs.get('userToken'));
          await Firebase_message().initNotifications();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const AllPage()),
              (router) => false);
          //SSO回傳訊息403，判斷為未註冊，跳轉註冊頁面
        } else if (response.statusCode == 403) {
          //將需要註冊狀態寫入狀態管理
          state.google_sso_status_Set('register');
          //跳轉頁面到註冊
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const registerPage()),
              (route) => false);
          //將google帳戶資訊寫入全局，方便調用
          state.google_sso_Set(googleController.googleAccount);
          //顯示錯誤訊息
          EasyLoading.showSuccess(
              jsonDecode(utf8.decode(response.bodyBytes))['detail']);
        } else if (response.statusCode == 401) {
          //401為帳戶未綁定SSO因此會先將firebase的帳戶狀態先登出
          googleController.google_signOut();
          //顯示錯誤訊息
          EasyLoading.showError(
              jsonDecode(utf8.decode(response.bodyBytes))['detail']);
        } else {
          //確保google sso 保持登出
          googleController.google_signOut();
        }
      } catch (e) {
        EasyLoading.dismiss();
        googleController.google_signOut();

        print(e);
      }
    } else {
      EasyLoading.dismiss();
      //確保google sso 保持登出
      googleController.google_signOut();
    }
  }

  @override
  void initState() {
    super.initState();
    EasyLoading.dismiss();
    googleController.googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) {
      setState(() {
        count++;
      });
      if (count <= 1) {
        try {
          handlesignIn(account);
        } catch (e) {
          EasyLoading.dismiss();
        }
      }
    }).onError((err) {
      print('Error during Signing in: $err');
    });
  }

//此為顯示密碼function
  void Show_Password() {
    if (showPassword == true) {
      setState(() {
        showPassword = false;
      });
    } else {
      setState(() {
        showPassword = true;
      });
    }
  }

  //判斷密碼長度
  bool text_lengh() {
    if (passwordController.text.length < 8) {
      setState(() {
        errorText = "密碼長度小於8字元";
      });
      return false;
    } else {
      return true;
    }
  }

//一般登陸function
  userSignIn(email, password) async {
    var url = dotenv.env['Login'].toString();
    var jwt = '';

    DateTime startTime = DateTime.now();
    try {
      response = await api().apiPost(
          {"email": email, "password": Sha256().sha256Function(password)},
          url,
          jwt);
      if (response == null) {
        return false;
      } else {
        if (response.statusCode == 200) {
          DateTime endTime = DateTime.now();
          Duration durationInMilliseconds = endTime.difference(startTime);
          print('${durationInMilliseconds.inSeconds}秒login');

          state.updateAccountState(await jsonDecode(response.body)['token']);

          EasyLoading.showSuccess(
              jsonDecode(utf8.decode(response.bodyBytes))['message'] ?? '');

          print(await jsonDecode(response.body)['token']);
          await prefs.setString(
              'userToken', jsonDecode(response.body)['token']);
          setState(() {
            response = response;
            showLoginError = false;
          });
          EasyLoading.dismiss();
          print(prefs.get('userToken'));
          await Firebase_message().initNotifications();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const AllPage()),
              (router) => false);
          return true;
        } else {
          EasyLoading.dismiss();
          setState(() {
            errorText = jsonDecode(utf8.decode(response.bodyBytes))['detail']
                .toString();
            showLoginError = true;
          });
          print(errorText);
          return false;
        }
      }
    } catch (e) {
      EasyLoading.dismiss();
      print(e);
      return false;
    }
  }

  void forgetpassword(context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const forgetPasswordPage()));
  }

  void register_page(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const registerPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(62, 111, 179, 1),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 310,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '登入',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                MyTextfield(
                  controller: usernameController,
                  hintText: '電子郵件',
                  obscurText: false,
                  error_status: true,
                  error_text: '',
                ),
                const SizedBox(
                  height: 10,
                ),
                Textfield_password(
                  controller: passwordController,
                  hintText: '密碼',
                  obscurText: showPassword,
                  error_status: true,
                  error_text: '',
                  onTap: () {
                    Show_Password();
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: InkWell(
                                  child: const Text(
                                    "忘記密碼",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                  onTap: () => forgetpassword(context))),
                          const SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            child: const Text(
                              "註冊",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            onTap: () {
                              register_page(context);
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (showLoginError)
                  Text(
                    errorText,
                    style: const TextStyle(color: Colors.white),
                  ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  child: const block_button(
                    functionName: '登入',
                  ),
                  onTap: () {
                    EasyLoading.show(status: '登入中...');
                    userSignIn(
                        usernameController.text, passwordController.text);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                          child: Divider(
                        thickness: 1,
                        color: Colors.white,
                      )),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'OR',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Expanded(
                          child: Divider(
                        thickness: 1,
                        color: Colors.white,
                      )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        child: const SquareTitle(
                          imagePath: 'assets/login_icon/google.png',
                        ),
                        onTap: () async {
                          print(prefs.get('userToken'));
                          try {
                            if (googleController.googleAccount.value == null) {
                              googleController.google();
                            } else {
                              //確保在登錄界面保持登出
                              googleController.google_signOut();
                            }
                          } catch (e) {
                            print(e);
                          }

                          // google_sso_function();
                        }),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
