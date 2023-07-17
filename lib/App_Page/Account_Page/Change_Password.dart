// ignore_for_file: duplicate_import, must_be_immutable, camel_case_types, non_constant_identifier_names, prefer_typing_uninitialized_variables, file_names, avoid_print, annotate_overrides, unrelated_type_equality_checks
import 'package:traffic_hero/imports.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({
    super.key,
  });
  @override
  State<ChangePassword> createState() => new_password_page();
}

class new_password_page extends State<ChangePassword> {
  //設定狀態管理變數
  late stateManager state;
  //設定輸入框的控制器
  final change_new_password_Controller = TextEditingController();
  final change_check_password_Controller = TextEditingController();
  final change_old_password_Controller = TextEditingController();
  var old_input_showState = false;
  //顯示密碼是否在8位元
  var change_password_error_show = false;
  //密碼是否相同
  var change_Password_Synchronize = true;
  //控制密碼顯示的變數
  var show_old_password = true;
  var show_new_password = true;
  var show_check_password = true;
  //控制Textfield顯示error文字
  var show_password_error_text = true;
  var password_text_length_error = '';
  var show_old_password_error_text = true;
  //設定儲存API回傳直的變數
  var response;

  //當頁面創造時執行
  void didChangeDependencies() {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
    if (state.accountState != '') {
      setState(() {
        old_input_showState = true;
      });
    }
  }

  //判斷密碼長度
  bool lengthText() {
    if (change_new_password_Controller.text.length < 8) {
      setState(() {
        password_text_length_error = "密碼長度小於8字元";
        show_password_error_text = false;
      });
      return false;
    } else {
      return true;
    }
  }

  //控制顯示密碼
  void Show_Password_old() {
    if (show_old_password == true) {
      setState(() {
        show_old_password = false;
      });
    } else {
      setState(() {
        show_old_password = true;
      });
    }
  }

  //控制顯示密碼
  void Show_Password_new() {
    if (show_new_password == true) {
      setState(() {
        show_new_password = false;
      });
    } else {
      setState(() {
        show_new_password = true;
      });
    }
  }

  //控制顯示密碼
  void Show_Password_new_check() {
    if (show_check_password == true) {
      setState(() {
        show_check_password = false;
      });
    } else {
      setState(() {
        show_check_password = true;
      });
    }
  }

  //控制修改密碼的Function
  void change_password_function(context) async {
    var Body = {};
    var url = '/Account/change_password';
    //判斷新密碼與確認密碼使否相同
    if (change_new_password_Controller.text != change_check_password_Controller.text) {
      EasyLoading.dismiss();
      setState(() {
        //使Textfield顯示error狀態
        change_Password_Synchronize = false;
      });
    } else {
      EasyLoading.dismiss();
      //使用狀態管理判斷是忘記密碼還是修改密碼，通過是否有儲存帳戶資訊來判斷
      if (state.accountState == '') {
        Body = {
          "email": state.verifyEmail,
          "old_password": state.forgetToken,
          "new_password": Sha256().sha256Function(change_new_password_Controller.text)
        };
      } else {
        var accountemail = JWT.decode(state.accountState).payload;
        setState(() {
          //使用狀態管理判斷是忘記密碼還是修改密碼顯示舊密碼的輸入，通過是否有儲存帳戶資訊來判斷
          old_input_showState = true;
        });
        Body = {
          "email": accountemail['data']['email'],
          "old_password": Sha256().sha256Function(change_old_password_Controller.text),
          "new_password": Sha256().sha256Function(change_new_password_Controller.text)
        };
      }
      response = await apiPut_Function().apiPut(Body, url);

      if (response.statusCode == 200) {
        EasyLoading.showSuccess('修改成功');
        state.updateAccountState('');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Login()));
      } else if (response.statusCode == 401) {
        setState(() {
          show_old_password_error_text = false;
        });
      } else {
        EasyLoading.showError('修改失敗');
      }
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
                  '重設密碼',
                  style: TextStyle(color: Colors.white, fontSize: 40),
                ),
                const SizedBox(
                  height: 80,
                ),
                if (old_input_showState)
                  Textfield_password(
                    controller: change_old_password_Controller,
                    hintText: '舊密碼',
                    obscurText: show_old_password,
                    error_status: show_old_password_error_text,
                    error_text: '舊密碼錯誤',
                    onTap: () {
                      Show_Password_old();
                    },
                  ),
                const SizedBox(
                  height: 10,
                ),
                Textfield_password(
                  controller: change_new_password_Controller,
                  hintText: '新密碼',
                  obscurText: show_new_password,
                  error_status: show_password_error_text,
                  error_text: password_text_length_error,
                  onTap: () {
                    Show_Password_new();
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Textfield_password(
                  controller: change_check_password_Controller,
                  hintText: '確認新密碼',
                  obscurText: show_check_password,
                  error_status: change_Password_Synchronize,
                  error_text: '密碼不相符',
                  onTap: () {
                    Show_Password_new_check();
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                if (change_password_error_show)
                  const Text(
                    '密碼重設失敗',
                    style: TextStyle(color: Colors.red),
                  ),
                const SizedBox(
                  height: 80,
                ),
                InkWell(
                  child: const Login_button(functionName: "送出"),
                  onTap: () {
                    if (lengthText()) {
                      EasyLoading.show(status: 'loading...');
                      change_password_function(context);
                    }

                    // change_password_function(context);
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
