// ignore_for_file: camel_case_types, prefer_const_declarations, non_constant_identifier_names, duplicate_ignore, unnecessary_import, unrelated_type_equality_checks, dead_code, file_names, sized_box_for_whitespace
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:traffic_hero/imports.dart';

class register extends StatefulWidget {
  const register({super.key});

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  final registerNameController = TextEditingController();
  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registercheckPasswordController = TextEditingController();
  final DateFormat formatter = DateFormat('yyyy/MM/dd');
  var show_password = true;
  var show_password_ckeck = true;
  // ignore: prefer_typing_uninitialized_variables
  var response;
  String gender = '性別';
  var birthday = '生日';
  var error_email = true;
  var error_name = true;
  var error_password = true;
  var error_check_password = true;
  var error_gender = true;
  var error_born = true;
  var length_error_password_text = '';
  late stateManager state;


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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
  }

  void Show_Password_check() {
    if (show_password_ckeck == true) {
      setState(() {
        show_password_ckeck = false;
      });
    } else {
      setState(() {
        show_password_ckeck = true;
      });
    }
  }

  bool text_lengh() {
    if (registerPasswordController.text == '') {
      setState(() {
        error_password = false;
       length_error_password_text = "請輸入密碼";
      });
       EasyLoading.dismiss();
      
      return false;

    } else if (registerPasswordController.text.length < 8 ) {
     
      EasyLoading.dismiss();
      setState(() {
        error_password = false;
        length_error_password_text = "密碼長度小於8字元";
      });
      return false;
    } else {
      EasyLoading.dismiss();
      return true;
    }
  }

  // ignore: non_constant_identifier_names
  void register_function(context) async {
    response = await api().apiPost({
      "name": registerNameController.text,
      "email": registerEmailController.text,
      "password":
          Sha256().sha256Function(registerPasswordController.text).toString(),
      "gender": gender,
      "birthday": birthday
    }, '/Account/register');
    if (response.statusCode == 200) {
      state.VerifyEmailSet(registerEmailController.text);
      state.veriffyStateSet('register');
      EasyLoading.dismiss();
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const verify_page()));
    } else {
      EasyLoading.dismiss();
    }
  }

  bool check_password_function() {
    if (registerPasswordController.text !=
        registercheckPasswordController.text) {
      EasyLoading.dismiss();
      setState(() {
        error_check_password = false;
      });
      return false;
    } else {
      EasyLoading.dismiss();
      return true;
    }
  }

  void set_gender(Gender) {
    setState(() {
      gender = Gender;
    });
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
                    error_status: error_name,
                    error_text: '沒有輸入姓名',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextfield(
                    controller: registerEmailController,
                    hintText: '電子郵件',
                    obscurText: false,
                    error_status: error_email,
                    error_text: '電子郵件錯誤',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Textfield_password(
                    controller: registerPasswordController,
                    hintText: '輸入密碼',
                    obscurText: show_password,
                    error_status: error_password,
                    error_text: length_error_password_text,
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
                    obscurText: show_password_ckeck,
                    error_status: error_check_password,
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
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 30),
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
                                  DropdownMenuItem(
                                      value: "male", child: Text("男")),
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
                                iconEnabledColor:
                                    const Color.fromARGB(255, 0, 0, 0),
                                style: const TextStyle(
                                  //te
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 17,
                                ),
                                dropdownColor:
                                    const Color.fromARGB(255, 255, 249, 249),
                                underline: Container(),
                                isExpanded: true,
                              ),
                            )),
                      ),
                    ),
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
}
