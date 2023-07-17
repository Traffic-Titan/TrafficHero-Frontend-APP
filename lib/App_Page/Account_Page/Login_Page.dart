// ignore_for_file: avoid_print, non_constant_identifier_names, prefer_typing_uninitialized_variables, file_names, use_build_context_synchronously
import 'package:traffic_hero/imports.dart';

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

//當頁面創造時執行
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
  }

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
  
  //判斷密碼長度
  bool text_lengh(){
    if(passwordController.text.length < 8){
      setState(() {
        error_text = "密碼長度小於8字元";
      });
      return false;
    }else{
      return true;
    }
  }

  Future<bool> signUserIn() async {
    response = await api().apiPost({
      "email": usernameController.text,
      "password": Sha256().sha256Function(passwordController.text)
    }, '/Account/login');

    if (response == null) {
      return false;
    } else {
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        EasyLoading.showSuccess('登入成功');
        state.updateAccountState(
            await jsonDecode(response.body)['Token']);
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
          error_text = '帳號密碼錯誤';
          // error_text = jsonDecode(utf8.decode(response.bodyBytes))['detail'].toString();
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

  Future<bool> google_sso_function() async {
    response = await api().apiPost(
        {"email": usernameController.text, "password": passwordController.text},
        '/Account/login');
    print(sha256.convert(response.body));
    if (response.statusCode == 200) {
      EasyLoading.showSuccess('登入成功');

      print(response.body);
      setState(() {
        login_error_show = false;
      });
      return true;
    } else {
      EasyLoading.dismiss();
      setState(() {
        login_error_show = true;
      });
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor:  Color.fromARGB(168, 1, 99, 148),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    'assets/login_icon/sign_in.png',
                    height: 200,
                  ),
                  const SizedBox(
                    height: 10,
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
                    padding: const EdgeInsets.symmetric(horizontal: 78),
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
                    child: const Login_button(
                      functionName: '登入',
                    ),
                    onTap: () async {

                        EasyLoading.show(status: 'loading...');
                        signUserIn();

                      
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
                        onTap: () {
                          print(
                              Sha256().sha256Function(passwordController.text));
                          print("google_SSO");
                          EasyLoading.show(status: 'loading...');
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
