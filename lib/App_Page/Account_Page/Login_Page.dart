// ignore_for_file: avoid_print, non_constant_identifier_names, prefer_typing_uninitialized_variables, file_names, use_build_context_synchronously, dead_code_catch_following_catch, unnecessary_null_comparison, sized_box_for_whitespace
import 'package:traffic_hero/Imports.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  var login_error_show = false;
  late stateManager state;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  var error_text = '';
  var response;
  var show_password = true;
  final googleController = Get.put(googlesso());
  var isAuth;
  int count = 0;
  var request_body;
  var request_url;

//當頁面創造時執行
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
    EasyLoading.dismiss();
  }

  handlesignIn(GoogleSignInAccount? account) async {
    request_body = {
      "email": googleController.googleAccount.value?.email ?? '',
      "Google_ID": googleController.googleAccount.value?.id ?? '',
      "Google_Avatar": googleController.googleAccount.value?.photoUrl ?? ''
    };

    request_url = '/Account/Google_SSO';

    if (account != null) {
      response = await api().Api_Post(request_body, request_url, '');

      if (response.statusCode == 200) {
        //顯示成功訊息
        EasyLoading.showSuccess(
            jsonDecode(utf8.decode(response.bodyBytes))['detail'] ?? '');
        //將狀態寫入
        state
            .updateAccountState(await jsonDecode(response.body)['Token'] ?? '');
        //跳轉頁面
        get_User();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const All_Page()));
      } else if (response.statusCode == 403) {
        //SSO回傳訊息403，判斷為未註冊，跳轉註冊頁面
        state.google_sso_status_Set('register');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const register()),
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
        googleController.google_signOut();
      }
    } else {
      googleController.google_signOut();
    }
  }

  @override
  void initState() {
    super.initState();
    googleController.googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) {
      setState(() {
        count++;
      });
      if (count <= 1) {
        EasyLoading.show(status: 'Loading.......');
        handlesignIn(account);
      }
    }).onError((err) {
      print('Error during Signing in: $err');
    });
  }

//此為顯示密碼function
  void Show_Password() {
    if (show_password == true) {
      setState(() {
        show_password = false;
      });
    } else {
      setState(() {
        show_password = true;
      });
    }
  }

void get_User() async {
    var response;
    var url = '/Account/profile';
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

  //判斷密碼長度
  bool text_lengh() {
    if (passwordController.text.length < 8) {
      setState(() {
        error_text = "密碼長度小於8字元";
      });
      return false;
    } else {
      return true;
    }
  }

//一般登陸function
  Future<bool> userSignIn() async {
    response = await api().Api_Post({
      "email": usernameController.text,
      "password": Sha256().sha256Function(passwordController.text)
    }, '/Account/login', '');

    if (response == null) {
      return false;
    } else {
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        EasyLoading.showSuccess(
            jsonDecode(utf8.decode(response.bodyBytes))['message'] ?? '');
        state.updateAccountState(await jsonDecode(response.body)['Token']);
        setState(() {
          response = response;
          login_error_show = false;
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const All_Page()));
        return true;
      } else {
        EasyLoading.dismiss();
        setState(() {
          error_text = jsonDecode(utf8.decode(response.bodyBytes))['detail']
                  .toString() ;
          login_error_show = true;
        });
        return false;
      }
    }
  }

  void forgetpassword(context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const forget_password_page()));
  }

  void register_page(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const register()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromARGB(168, 1, 99, 148),
        body: SingleChildScrollView(
          reverse: true,
          child: SafeArea(
            child: Center(
              child: Container(
                width: 310,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 160,
                    ),
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
                      obscurText: show_password,
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
                    if (login_error_show)
                      Text(
                        error_text,
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
                        userSignIn();
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 70),
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
                                  googleController.google();
                                } else {
                                  googleController.google_signOut();
                                }
                              } catch (e) {
                                EasyLoading.dismiss();
                                EasyLoading.showError('Google 伺服器錯誤');
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
        ));
  }
}
