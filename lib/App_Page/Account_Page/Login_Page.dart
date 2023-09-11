// ignore_for_file: avoid_print, non_constant_identifier_names, prefer_typing_uninitialized_variables, file_names, use_build_context_synchronously, dead_code_catch_following_catch, unnecessary_null_comparison, sized_box_for_whitespace, prefer_interpolation_to_compose_strings
import 'package:traffic_hero/Imports.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  late stateManager state;
  final usernameController = TextEditingController(),
      passwordController = TextEditingController(),
      googleController = Get.put(googlesso());

  var showLoginError = false, showPassword = true, errorText = '', response;

  int count = 0;

//當頁面創造時執行
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
    EasyLoading.dismiss();
    
    
  }

  Future<void> getHome() async {
    await getUser();
    await getOperationalStatus();
    await getWeather();

    //顯示成功訊息
    // EasyLoading.showSuccess(
    //     jsonDecode(utf8.decode(response.bodyBytes))['detail'] ?? '');
  EasyLoading.dismiss();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AllPage()));
  }

  getOperationalStatus() async {
    var position = await geolocator().updataPosition();
    var url = dotenv.env['OperationalStatus'].toString() +
        '?longitude=${position.longitude}&latitude=${position.latitude}';
    var jwt = ',' + state.accountState.toString();

    var response = await api().apiGet(url, jwt);
    print(jsonDecode(utf8.decode(response.bodyBytes)));
    if (response.statusCode == 200) {
      state
          .updateOperationalStatus(jsonDecode(utf8.decode(response.bodyBytes)));
      print(state.OperationalStatus);
    } else {
      print(jsonDecode(utf8.decode(response.bodyBytes)));
    }
  }

  getWeather() async {
    var position = await geolocator().updataPosition();
    var response;
    var url = dotenv.env['Weather'].toString() +
        '?longitude=${position.longitude}&latitude=${position.latitude}';
    var jwt = ',' + state.accountState.toString();
    print(jwt);
    try {
      response = await api().apiGet(url, jwt);
    } catch (e) {
      print(e);
    }

    if (response.statusCode == 200) {
      print(jsonDecode(utf8.decode(response.bodyBytes)));
      state.updateWeatherState(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      print(jsonDecode(utf8.decode(response.bodyBytes)));
    }
  }

  getUser() async {
    var response;
    var url = dotenv.env['Profile'];
    var jwt = ',' + state.accountState.toString();
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
          getHome();
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
        handlesignIn(account);
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

    await Future.delayed(const Duration(seconds: 10), () async {
      try {
        response = await api().apiPost(
            {"email": email, "password": Sha256().sha256Function(password)},
            url,
            jwt);

        if (response == null) {
          return false;
        } else {
          if (response.statusCode == 200) {
            EasyLoading.dismiss();
            state.updateAccountState(await jsonDecode(response.body)['token']);
            await getHome();
            EasyLoading.showSuccess(
                jsonDecode(utf8.decode(response.bodyBytes))['detail'] ?? '');
            
            setState(() {
              response = response;
              showLoginError = false;
            });
            print(jsonDecode(response.body)['token']);

            return true;
          } else {
            EasyLoading.dismiss();
            setState(() {
              errorText = jsonDecode(utf8.decode(response.bodyBytes))['detail']
                  .toString();
              showLoginError = true;
            });
            return false;
          }
        }
      } catch (e) {
        EasyLoading.dismiss();
        print(e);
        return false;
      }
    });
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
        backgroundColor: const Color.fromARGB(168, 1, 99, 148),
        body:  Center(
              child: SingleChildScrollView(
          child: Container(
                width: 310,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '歡迎使用',
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                      const Text(
                        'Traffic Hero',
                        style: TextStyle(color: Colors.white, fontSize: 28),
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
                                            color: Colors.white,
                                          ),
                                        ),
                                        onTap: () => forgetpassword(context))),
                                InkWell(
                                  child: const Text(
                                    "註冊",
                                    style: TextStyle(color: Colors.white),
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
                                try {
                                  if (googleController.googleAccount.value ==
                                      null) {
                                    EasyLoading.show(status: '登入中...');
                                    googleController.google();
                                  } else {
                                    //確保在登錄界面保持登出
                                    googleController.google_signOut();
                                  }
                                } catch (e) {
                                  EasyLoading.dismiss();
                                  EasyLoading.showError(e.toString());
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
