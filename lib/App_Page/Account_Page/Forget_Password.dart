// ignore_for_file: duplicate_import, must_be_immutable, camel_case_types, non_constant_identifier_names, prefer_typing_uninitialized_variables, file_names, avoid_init_to_null
import 'package:traffic_hero/imports.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

class forgetPasswordPage extends StatefulWidget {
  const forgetPasswordPage({super.key});

  @override
  State<forgetPasswordPage> createState() => _forgetPasswordPageState();
}

class _forgetPasswordPageState extends State<forgetPasswordPage> {
  //設立忘記密碼的電子郵件輸入框
  final forget_email = TextEditingController();
  //設定狀態管理變數
  late stateManager state;

  var birthday = '生日',
      forget_password_error_show = true,
      forget_password_error_text = '',
      forget_password_email = true,
      response = null;

  //當頁面創造時執行
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
  }

  //控制忘記密碼的Function
  void forget_password_function(context) async {
    var Body = {"email": forget_email.text, "birthday": birthday};
    var url = dotenv.env['ForgotPassword'].toString();
    var jwt = state.accountState;
    response = await api().Api_Post(Body, url, jwt);
    if (response.statusCode == 200) {
      EasyLoading.showSuccess('驗證碼已寄送');
      state.VerifyEmailSet(forget_email.text);
      EasyLoading.dismiss();
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const verify_page()));
    } else {
      EasyLoading.dismiss();
      setState(() {
        forget_password_email = false;
        forget_password_error_text =
            jsonDecode(utf8.decode(response.bodyBytes))['detail'];
      });
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
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                const Text(
                  '忘記密碼',
                  style: TextStyle(color: Colors.white, fontSize: 40),
                ),
                const SizedBox(
                  height: 80,
                ),
                MyTextfield(
                  controller: forget_email,
                  hintText: '電子郵件',
                  obscurText: false,
                  error_status: forget_password_email,
                  error_text: forget_password_error_text,
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
                    EasyLoading.show(status: 'loading...');
                    forget_password_function(context);
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
