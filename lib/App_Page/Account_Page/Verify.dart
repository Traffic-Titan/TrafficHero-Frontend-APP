// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names, unnecessary_null_comparison, prefer_function_declarations_over_variables, camel_case_types, prefer_typing_uninitialized_variables, file_names
import 'package:traffic_hero/imports.dart';

class verify_page extends StatefulWidget {
  const verify_page({Key? key}) : super(key: key);

  @override
  State<verify_page> createState() => _verify_pageState();
}

class _verify_pageState extends State<verify_page> {
  final verifyController = TextEditingController();
  var response;
  var InputErrorText = '';
  var errorState = true;
  late Timer _timer;
  int _countdownTime = 600; // 十分钟的秒数
  late stateManager state;
  var countdownDisplayControl = true;
  var getVerificationCodeAgain = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
  }

  @override
  void initState() {
    super.initState();
    startCountdownTimer();
  }

  void startCountdownTimer() {
    const oneSec = Duration(seconds: 1);

    _timer = Timer.periodic(oneSec, (Timer timer) {
      setState(() {
        if (_countdownTime < 1) {
          setState(() {
            countdownDisplayControl = false;
            getVerificationCodeAgain = true;
          });
          timer.cancel();
        } else {
          _countdownTime = _countdownTime - 1;
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  void verify_function(BuildContext context) async {
    var Body = {"email": state.verifyEmail, "code": verifyController.text};
    var url = '/Account/verify_code';
    var res = await api().Api_Post(Body, url,'');
    setState(() {
      response = res;
    });

    if (state.veriffyState == 'register') {
      if (res.statusCode == 200) {
        EasyLoading.dismiss();
        EasyLoading.showSuccess('註冊成功');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
      } else if (state.veriffyState == '') {
        EasyLoading.dismiss();
        setState(() {
          errorState = false;
          InputErrorText =
              jsonDecode(utf8.decode(response.bodyBytes))['detail'];
        });
      }
    } else {
      if (res.statusCode == 200) {
        EasyLoading.dismiss();
        state.forgetTokenSet(jsonDecode(response.body)['Token']);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ChangePassword()),
        );
      } else {
        EasyLoading.dismiss();
        setState(() {
          errorState = false;
          InputErrorText = '';
          jsonDecode(utf8.decode(response.bodyBytes))['detail'];
        });
      }
    }
  }

  String formatCountdownTime(int time) {
    int minutes = time ~/ 60;
    int seconds = time % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent.png,
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back_ios),
      //     onPressed: () {
      //       Navigator.of(context).pop();
      //     },
      //   ),
      // ),
      backgroundColor: const Color.fromARGB(168, 1, 99, 148),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              const Text(
                '電子郵件驗證',
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),
              const SizedBox(
                height: 80,
              ),
              MyTextfield(
                controller: verifyController,
                hintText: '請輸入驗證',
                obscurText: false,
                error_status: errorState,
                error_text: InputErrorText,
              ),
              const SizedBox(
                height: 10,
              ),
              if (countdownDisplayControl)
                Text(
                  '${formatCountdownTime(_countdownTime)}後重新獲取',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              if (getVerificationCodeAgain)
                InkWell(
                  child:const Text(
                  '重新獲取驗證碼',
                  style:  TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                  onTap: () {

                    if (state.veriffyState == 'register') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const register()));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const forget_password_page()));
                    }
                  },
                ),
              const SizedBox(
                height: 80,
              ),
              InkWell(
                child: const block_button(functionName: "送出"),
                onTap: () {
                  EasyLoading.show(status: 'loading...');
                  verify_function(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
