
// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, non_constant_identifier_names, prefer_function_declarations_over_variables, unnecessary_null_comparison, duplicate_ignore

import 'package:traffic_hero/imports.dart';

class verify_page extends StatefulWidget {
  const verify_page({super.key});

  @override
  State<verify_page> createState() => _verify_pageState();
}

class _verify_pageState extends State<verify_page> {
  final verifyController = TextEditingController();
  var response;
  var input_error_text = '';
  var error_state = true;
  late Timer _timer;
  int _countdownTime = 0;
  late stateManager state;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
    if (_countdownTime == 0) {
      setState(() {
        _countdownTime = 60;
      });
      //开始倒计时
      startCountdownTimer();
    }
  }

  void startCountdownTimer() {
    const oneSec = Duration(seconds: 1);

    var callback = (timer) => {
          setState(() {
            if (_countdownTime < 1) {
              _timer.cancel();
            } else {
              _countdownTime = _countdownTime - 1;
            }
          })
        };

    _timer = Timer.periodic(oneSec, callback);
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }

  // ignore: non_constant_identifier_names
  void verify_function(context) async {
    var Body = {"email": state.verifyEmail, "code": verifyController.text};
    var url = '/Account/verify_code';
    var res = await api().apiPost(Body, url);
    setState(() {
      response = res;
    });

    if (state.veriffyState == 'register') {
      if (res.statusCode == 200) {
        EasyLoading.dismiss();
        EasyLoading.showSuccess('註冊成功');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Login()));
      } else if (state.veriffyState == '') {
        EasyLoading.dismiss();
        setState(() {
          error_state = false;
          input_error_text =
              jsonDecode(utf8.decode(response.bodyBytes))['detail'];
        });
      }
    } else {
      if (res.statusCode == 200) {
        EasyLoading.dismiss();
        state.forgetTokenSet(jsonDecode(response.body)['Token']);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ChangePassword()));
      } else {
        EasyLoading.dismiss();
        setState(() {
          error_state = false;
          input_error_text = '';
          jsonDecode(utf8.decode(response.bodyBytes))['detail'];
        });
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
                  error_status: error_state,
                  error_text: input_error_text,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                   '$_countdownTime后重新获取' ,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
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
        ));
  }
}
