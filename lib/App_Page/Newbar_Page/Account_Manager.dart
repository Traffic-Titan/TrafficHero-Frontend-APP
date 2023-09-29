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
  TextEditingController changedName = new TextEditingController();
  TextEditingController changedEmail = new TextEditingController();
  TextEditingController changedBirthday = new TextEditingController();
  TextEditingController changedGender = new TextEditingController();
  TextEditingController changedPhone = new TextEditingController();
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
    Response response;
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
      appBar: AppBar(
        title: const Text("會員管理"),
        backgroundColor: Color.fromRGBO(113, 170, 221, 1),
      ),
      body: Scrollbar(
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                child: ClipOval(
                    child: Image.memory(
              base64Decode(state.profile?["avatar"]),
              width: 600,
              height: 600,
              fit: BoxFit.cover,
            ))),
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Text("  個人資訊",
                  style: TextStyle(
                      fontSize: 23, color: Color.fromRGBO(46, 117, 182, 1))),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 5),
              padding: EdgeInsets.all(10),
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromRGBO(187, 214, 239, 1),
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: Row(
                      children: [
                        Expanded(
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
                              border: OutlineInputBorder(),
                              hintText: name,
                            ),
                            onChanged: (text) {
                              name = changedName.text;
                            },
                            enabled: _acctInforState,
                          ),
                        ),
                        Expanded(
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
                              border: OutlineInputBorder(),
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
                        Expanded(
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
                              border: OutlineInputBorder(),
                              hintText: gender,
                            ),
                            onChanged: (text) {
                              gender = changedGender.text;
                            },
                            enabled: _acctInforState,
                          ),
                        ),
                        Expanded(
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
                            decoration: InputDecoration(
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
                            child: ElevatedButton(
                              onPressed: () {
                                resetInfo();
                              },
                              child: Text('重設'),
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromRGBO(24, 60, 126, 1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        20)), // Background color
                              ),
                            ),
                            visible: _acctInforState,
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
                            child: Text(acctInforModify),
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromRGBO(24, 60, 126, 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20)), // Background color
                            ),
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
              margin: EdgeInsets.only(left: 15, right: 15, top: 5),
              padding: EdgeInsets.all(10),
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromRGBO(187, 214, 239, 1),
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: Row(
                      children: [
                        Expanded(
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
                              border: OutlineInputBorder(),
                              hintText: email,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            onPressed: null,
                            child: Text("修改"),
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromRGBO(24, 60, 126, 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20)), // Background color
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Align(
                                alignment: Alignment.center,
                                child: Text("密碼",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color:
                                            Color.fromRGBO(24, 60, 126, 1))))),
                        Expanded(
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
                            child: Text("修改"),
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromRGBO(24, 60, 126, 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20)), // Background color
                            ),
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
