// ignore_for_file: camel_case_types, prefer_const_declarations, non_constant_identifier_names, duplicate_ignore, unnecessary_import, unrelated_type_equality_checks, dead_code, file_names, sized_box_for_whitespace, unused_local_variable, prefer_typing_uninitialized_variables
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:traffic_hero/imports.dart';

class registerPage extends StatefulWidget {
  const registerPage({super.key});
  @override
  State<registerPage> createState() => _registerPage();
}

class _registerPage extends State<registerPage> {
  //設定輸入匡的控制器
  final registerNameController = TextEditingController();
  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registercheckPasswordController = TextEditingController();

  //給生日顯示格式
  final DateFormat formatter = DateFormat('yyyy/MM/dd');
  //預設米瑪顯示變數隱藏
  var showPassword = true;
  var showPasswordCkeck = true;
  // ignore: prefer_typing_uninitialized_variables

  var response;
  //給性別及生日預設變數
  var gender = '性別';
  var birthday = '生日';
  //控制輸入匡顯示錯誤是否顯示
  var errorEmail = true;
  var errorName = true;
  var errorPassword = true;
  var errorCheckPassword = true;
  var errorGender = true;
  var errorBorn = true;
  //設立密碼長度文字
  var lengthErrorPasswordText = '';
  late stateManager state;
  late var body = <String, String>{};

  //創造時
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
    if (state.google_sso_status == 'register') {
      setState(() {
        registerNameController.text = state.google_sso.value?.displayName ?? '';
        registerEmailController.text = state.google_sso.value?.email ?? '';
      });
    }
  }

//控制使否要顯示密碼
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

//控制使否要顯示密碼
  void Show_Password_check() {
    if (showPasswordCkeck == true) {
      //如果為顯示就改成不顯示
      setState(() {
        showPasswordCkeck = false;
      });
    } else {
      setState(() {
        showPasswordCkeck = true;
      });
    }
  }

//確認密碼是否一樣
  check_password_function() {
    if (registerPasswordController.text !=
        registercheckPasswordController.text) {
      EasyLoading.dismiss();
      setState(() {
        errorCheckPassword = false;
      });
      return false;
    } else {
      EasyLoading.dismiss();
      return true;
    }
  }

//確認密碼輸入長度
  bool text_lengh() {
    if (registerPasswordController.text == '') {
      setState(() {
        errorPassword = false;
        lengthErrorPasswordText = "請輸入密碼";
      });
      EasyLoading.dismiss();

      return false;
    } else if (registerPasswordController.text.length < 8) {
      EasyLoading.dismiss();
      setState(() {
        errorPassword = false;
        lengthErrorPasswordText = "密碼長度小於8字元";
      });
      return false;
    } else {
      EasyLoading.dismiss();
      return true;
    }
  }

  // ignore: non_constant_identifier_names
  //註冊後端API
  void register_function(context) async {
    if (state.google_sso_status == 'register') {
      body = {
        "name": registerNameController.text,
        "email": registerEmailController.text,
        "password":
            Sha256().sha256Function(registerPasswordController.text).toString(),
        "gender": gender,
        "birthday": birthday,
        "google_id": state.google_sso.value?.id ?? '',
        "google_avatar": state.google_sso.value.photoUrl ?? ''
      };
    } else {
      setState(() {
        body = {
          "name": registerNameController.text,
          "email": registerEmailController.text,
          "password": Sha256()
              .sha256Function(registerPasswordController.text)
              .toString(),
          "gender": gender,
          "birthday": birthday,
          "google_id": '',
          "google_avatar": ''
        };
      });
    }
    var url = dotenv.env['Register'].toString();

    response = await api().Api_Post(body, url, '');
    if (response.statusCode == 200) {
      state.VerifyEmailSet(registerEmailController.text);
      state.veriffyStateSet('register');
      EasyLoading.dismiss();
      if (state.google_sso_status == 'register') {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Login()));
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const verify_page()));
      }
      
    } else {
      EasyLoading.dismiss();
      EasyLoading.showError(
          jsonDecode(utf8.decode(response.bodyBytes))['detail']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
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
        backgroundColor: const Color.fromARGB(168, 1, 99, 148),
        body: SingleChildScrollView(
          reverse: true,
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    '註冊',
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  MyTextfield(
                    controller: registerNameController,
                    hintText: '姓名',
                    obscurText: false,
                    error_status: errorName,
                    error_text: '沒有輸入姓名',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextfield(
                    controller: registerEmailController,
                    hintText: '電子郵件',
                    obscurText: false,
                    error_status: errorEmail,
                    error_text: '電子郵件錯誤',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Textfield_password(
                    controller: registerPasswordController,
                    hintText: '輸入密碼',
                    obscurText: showPassword,
                    error_status: errorPassword,
                    error_text: lengthErrorPasswordText,
                    onTap: () {
                      Show_Password();
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Textfield_password(
                    controller: registercheckPasswordController,
                    hintText: '確認密碼',
                    obscurText: showPasswordCkeck,
                    error_status: errorCheckPassword,
                    error_text: '密碼不相符',
                    onTap: () {
                      Show_Password_check();
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 310,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: decoratedBox()),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    child: button(functionName: birthday),
                    onTap: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(1800, 1, 1),
                          maxTime: DateTime.now(), onChanged: (date) {
                        setState(() {
                          final DateFormat formatter = DateFormat('yyyy/MM/dd');
                          final String formattedDate = formatter.format(date);
                          birthday = formattedDate.toString();
                        });
                      }, onConfirm: (date) {
                        setState(() {
                          final DateFormat formatter = DateFormat('yyyy/MM/dd');
                          final String formattedDate = formatter.format(date);
                          birthday = formattedDate.toString();
                        });
                      }, currentTime: DateTime.now(), locale: LocaleType.zh);
                    },
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  InkWell(
                    child: const block_button(functionName: "送出"),
                    onTap: () {
                      if (text_lengh() && check_password_function()) {
                        EasyLoading.show(status: 'loading...');
                        register_function(context);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget decoratedBox() {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
          padding: const EdgeInsets.only(left: 13, right: 30),
          child: Container(
            margin: const EdgeInsets.all(3),
            child: DropdownButton(
              borderRadius: BorderRadius.circular(20),
              value: gender,
              items: const [
                DropdownMenuItem(
                  value: "性別",
                  child: Text("性別"),
                ),
                DropdownMenuItem(value: "male", child: Text("男")),
                DropdownMenuItem(
                  value: "female",
                  child: Text("女"),
                )
              ],
              onChanged: (value) {
                setState(() {
                  gender = value.toString();
                });
              },
              icon: const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Icon(Icons.arrow_circle_down_sharp)),
              iconEnabledColor: const Color.fromARGB(255, 0, 0, 0),
              style: const TextStyle(
                //te
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 17,
              ),
              dropdownColor: const Color.fromARGB(255, 255, 249, 249),
              underline: Container(),
              isExpanded: true,
            ),
          )),
    );
  }
}
