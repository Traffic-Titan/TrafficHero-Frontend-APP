// ignore_for_file: duplicate_import, must_be_immutable, camel_case_types, non_constant_identifier_names, prefer_typing_uninitialized_variables, file_names, avoid_print, annotate_overrides, unrelated_type_equality_checks, unused_local_variable
import 'package:traffic_hero/Imports.dart';

class changePassword extends StatefulWidget {
  const changePassword({
    super.key,
  });
  @override
  State<changePassword> createState() => _changePassword();
}

class _changePassword extends State<changePassword> {
  //設定狀態管理變數
  late stateManager state;
  //設定輸入框的控制器
  final changeNewPasswordController = TextEditingController(),
      changeCheckPasswordController = TextEditingController(),
      changeOldPasswordController = TextEditingController();

  //控制密碼顯示的變數
  var showOldPassword = true,
      showNewPassword = true,
      showCheckPassword = true,
      //控制Textfield顯示error文字
      showPasswordErrorText = true,
      passwordTextLengthError = '',
      showOldPasswordErrorText = true,
      //設定儲存API回傳直的變數
      response,
      oldPasswordShow = false,
      //密碼是否相同
      changePasswordSynchronize = true,
      //顯示密碼是否在8位元
      changePasswordErrorShow = false;

  //當頁面創造時執行
  void didChangeDependencies() {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);

    if (state.accountState != '') {
      setState(() {
        oldPasswordShow = true;
      });
    }
  }

  //判斷密碼長度
  bool textLength() {
    if (changeNewPasswordController.text.length < 8) {
      setState(() {
        passwordTextLengthError = "密碼長度小於8字元";
        showPasswordErrorText = false;
      });
      return false;
    } else {
      return true;
    }
  }

  //控制顯示密碼
  void passwordOldShow() {
    if (showOldPassword == true) {
      setState(() {
        showOldPassword = false;
      });
    } else {
      setState(() {
        showOldPassword = true;
      });
    }
  }

  //控制顯示密碼
  void newPasswordShow() {
    if (showNewPassword == true) {
      setState(() {
        showNewPassword = false;
      });
    } else {
      setState(() {
        showNewPassword = true;
      });
    }
  }

  //控制顯示密碼
  void checkNewPasswordShow() {
    if (showCheckPassword == true) {
      setState(() {
        showCheckPassword = false;
      });
    } else {
      setState(() {
        showCheckPassword = true;
      });
    }
  }

  //控制修改密碼的Function
  void changePasswordApiFunction(context) async {
    var body = {};
    var url = dotenv.env['ChangePassword'];
    var jwt = '' ;
    //判斷新密碼與確認密碼使否相同
    if (changeNewPasswordController.text !=
        changeCheckPasswordController.text) {
      EasyLoading.dismiss();
      setState(() {
        //使Textfield顯示error狀態
        changePasswordSynchronize = false;
      });
    } else {
      EasyLoading.dismiss();
      //使用狀態管理判斷是忘記密碼還是修改密碼，通過是否有儲存帳戶資訊來判斷
      if (state.accountState == '') {
        body = {
          "email": state.verifyEmail,
          "old_password": state.forgetToken,
          "new_password":
              Sha256().sha256Function(changeNewPasswordController.text)
        };
      } else {
        setState(() {
          //使用狀態管理判斷是忘記密碼還是修改密碼顯示舊密碼的輸入，通過是否有儲存帳戶資訊來判斷
          oldPasswordShow = true;
        });
        body = {
          "email": state.profile['email'],
          "old_password":
              Sha256().sha256Function(changeOldPasswordController.text),
          "new_password":
              Sha256().sha256Function(changeNewPasswordController.text)
        };
        print(body);
      }
      response = await api().apiPut(body, url, jwt);
      if (response.statusCode == 200) {
        EasyLoading.showSuccess(jsonDecode(utf8.decode(response.bodyBytes))['detail'] ?? '');
        state.updateAccountState('');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Login()));
      } else if (response.statusCode == 401) {
        setState(() {
          showOldPasswordErrorText = false;
        });
      } else {
        EasyLoading.showError(jsonDecode(utf8.decode(response.bodyBytes))['detail'] ?? '');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
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
                if (oldPasswordShow)
                  Textfield_password(
                    controller: changeOldPasswordController,
                    hintText: '舊密碼',
                    obscurText: showOldPassword,
                    error_status: showOldPasswordErrorText,
                    error_text: '舊密碼錯誤',
                    onTap: () {
                      passwordOldShow();
                    },
                  ),
                const SizedBox(
                  height: 10,
                ),
                Textfield_password(
                  controller: changeNewPasswordController,
                  hintText: '新密碼',
                  obscurText: showNewPassword,
                  error_status: showPasswordErrorText,
                  error_text: passwordTextLengthError,
                  onTap: () {
                    newPasswordShow();
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Textfield_password(
                  controller: changeCheckPasswordController,
                  hintText: '確認新密碼',
                  obscurText: showCheckPassword,
                  error_status: changePasswordSynchronize,
                  error_text: '密碼不相符',
                  onTap: () {
                    checkNewPasswordShow();
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                if (changePasswordErrorShow)
                  const Text(
                    '密碼重設失敗',
                    style: TextStyle(color: Colors.red),
                  ),
                const SizedBox(
                  height: 80,
                ),
                InkWell(
                  child: const block_button(functionName: "送出"),
                  onTap: () {
                    if (textLength()) {
                      EasyLoading.show(status: 'loading...');
                      changePasswordApiFunction(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
