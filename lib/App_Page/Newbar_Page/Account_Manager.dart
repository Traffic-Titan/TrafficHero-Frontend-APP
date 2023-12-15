// ignore_for_file: file_names, prefer_typing_uninitialized_variables, avoid_print

import 'package:traffic_hero/Imports.dart';

class AccountManager extends StatefulWidget {
  const AccountManager({super.key});

  @override
  State<AccountManager> createState() => _AccountManager();
}

class _AccountManager extends State<AccountManager> {
  late stateManager state;
  late bool _acctInforState;
  late String acctInforModify;
  late String name, email, gender, birthday;
  var img;
  TextEditingController changedName = TextEditingController();
  TextEditingController changedEmail = TextEditingController();
  TextEditingController changedBirthday = TextEditingController();
  TextEditingController changedGender = TextEditingController();
  TextEditingController changedPhone = TextEditingController();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
    _acctInforState = state.acctInforState;
    acctInforModify = "修改";
    resetInfo();
  }

  //更改個人資訊
  changeInfor() async {
    var response;
    var url = dotenv.env['Profile'];
    var jwt = ',${state.accountState}';
    var body = {
      "name": name,
      "email": email,
      "password": "string",
      "gender": gender,
      "birthday": birthday,
      "google_id": ""
    };
    var body2 = {
      "name": name,
      "email": email,
      "gender": gender,
      "birthday": birthday,
      "google_id": "",
      "avatar": state.profile['avatar'],
    };
    response = await api().apiPut(body, url, jwt);
    if (response.statusCode == 200) {
      state.updateprofileState(jsonDecode(utf8.decode(response.bodyBytes)));
      state.updateprofileState(body2);
    } else {
      print(jsonDecode(utf8.decode(response.bodyBytes)));
    }
  }

  //重設個人資料
  resetInfo() {
    setState(() {
      name = state.profile['name'];
      email = state.profile['email'];
      gender = state.profile['gender'];
      birthday = state.profile['birthday'];
      img = base64Decode(state.profile['avatar']); //轉blob圖片
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(230, 240, 255, 1),
      appBar: AppBar(
        title: const Text(
          "會員管理",
          style: TextStyle(color: Colors.white),
        ),
        leading: InkWell(
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const AllPage()),
                (router) => false);
          },
        ),
        backgroundColor: const Color.fromRGBO(62, 111, 179, 1),
      ),
      body: Scrollbar(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: ClipOval(
                child: Image.memory(
                  base64Decode(state.profile?["avatar"] ?? ''),
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Text("  個人資訊",
                  style: TextStyle(
                      fontSize: 23, color: Color.fromRGBO(46, 117, 182, 1))),
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15, top: 5),
              padding: const EdgeInsets.all(10),
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromRGBO(187, 214, 239, 1),
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: Row(
                      children: [
                        const Expanded(
                            flex: 1,
                            child: Align(
                                alignment: Alignment.center,
                                child: Text("姓名",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color:
                                            Color.fromRGBO(24, 60, 126, 1))))),
                        Expanded(
                          flex: 2,
                          child: TextField(
                            controller: changedName,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: name,
                            ),
                            onChanged: (text) {
                              name = changedName.text;
                            },
                            enabled: _acctInforState,
                          ),
                        ),
                        const Expanded(
                            flex: 1,
                            child: Align(
                                alignment: Alignment.center,
                                child: Text("生日",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color:
                                            Color.fromRGBO(24, 60, 126, 1))))),
                        Expanded(
                          flex: 4,
                          child: TextField(
                            controller: changedBirthday,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: birthday,
                            ),
                            onChanged: (text) {
                              birthday = changedBirthday.text;
                            },
                            enabled: _acctInforState,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Row(
                      children: [
                        const Expanded(
                            flex: 1,
                            child: Align(
                                alignment: Alignment.center,
                                child: Text("性別",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color:
                                            Color.fromRGBO(24, 60, 126, 1))))),
                        Expanded(
                          flex: 2,
                          child: TextField(
                            controller: changedGender,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: gender,
                            ),
                            onChanged: (text) {
                              gender = changedGender.text;
                            },
                            enabled: _acctInforState,
                          ),
                        ),
                        const Expanded(
                            flex: 1,
                            child: Align(
                                alignment: Alignment.center,
                                child: Text("手機",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color:
                                            Color.fromRGBO(24, 60, 126, 1))))),
                        Expanded(
                          flex: 4,
                          child: TextField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: '09XXXXXXXX',
                            ),
                            enabled: _acctInforState,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Visibility(
                            visible: _acctInforState,
                            child: ElevatedButton(
                              onPressed: () {
                                resetInfo();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(67, 150, 200, 1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        20)), // Background color
                              ),
                              child: const Text('重設'),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                state.changeAcctInforState(!_acctInforState);
                                _acctInforState = state.acctInforState;
                                print(_acctInforState);
                                if (_acctInforState) {
                                  acctInforModify = "確認";
                                } else {
                                  acctInforModify = "修改";
                                  changeInfor();
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(67, 150, 200, 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20)), // Background color
                            ),
                            child: Text(acctInforModify),
                          ),
                        ],
                      )),
                ],
              ),
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Text("  帳號管理",
                  style: TextStyle(
                      fontSize: 23, color: Color.fromRGBO(46, 117, 182, 1))),
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15, top: 5),
              padding: const EdgeInsets.all(10),
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromRGBO(187, 214, 239, 1),
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: Row(
                      children: [
                        const Expanded(
                            flex: 1,
                            child: Align(
                                alignment: Alignment.center,
                                child: Text("帳號",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color:
                                            Color.fromRGBO(24, 60, 126, 1))))),
                        Expanded(
                          flex: 4,
                          child: TextField(
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: email,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            onPressed: null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(67, 150, 200, 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20)), // Background color
                            ),
                            child: const Text("修改"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Row(
                      children: [
                        const Expanded(
                            flex: 1,
                            child: Align(
                                alignment: Alignment.center,
                                child: Text("密碼",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color:
                                            Color.fromRGBO(24, 60, 126, 1))))),
                        const Expanded(
                          flex: 4,
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: '*******',
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const changePassword()));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(67, 150, 200, 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20)), // Background color
                            ),
                            child: const Text("修改"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
