// ignore_for_file: file_names, prefer_typing_uninitialized_variables, avoid_print, unused_field, non_constant_identifier_names, use_build_context_synchronously, unused_import
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_waya/extension/object_extension.dart';
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
  late String name, email, gender, birthday, google_id;
  var img;
  var profileBody;

  var changeStutes;

  int count = 0;
  bool accountShow = true,
      passwordChangeShow = false,
      saveShow = false,
      showPassword = true,
      showNewPassword = true,
      nameChangeShow = false,
      genderchangeShow = false,
      birthdayChangeShow = false,
      emailChangeShow = false,
      googleSSOShow = false;
  var screenWidth, screenHeight;
  TextEditingController changedName = TextEditingController();
  TextEditingController changedEmail = TextEditingController();
  TextEditingController changedBirthday = TextEditingController();
  TextEditingController changedGender = TextEditingController();
  TextEditingController changedPhone = TextEditingController();
  final passwordController = TextEditingController();
  final NewPasswordController = TextEditingController(),
      googleController = Get.put(googlesso());
  @override
  void initState() {
    super.initState();
    EasyLoading.dismiss();
    googleController.googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) {
      setState(() {
        count++;
      });
      if (count <= 1) {
        try {
          handlesignIn(account);
        } catch (e) {
          EasyLoading.dismiss();
        }
      }
    }).onError((err) {
      print('Error during Signing in: $err');
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
    screenWidth = MediaQuery.of(context).size.width;
    _acctInforState = state.acctInforState;
    acctInforModify = "修改";
    resetInfo();
    googleSSOShow = google_id == '' ? true : false;
  }

  handlesignIn(GoogleSignInAccount? account) async {
    var response;
    var url = dotenv.env['Profile'];
    var jwt = ',${state.accountState}';
    var body = {
      "name": name,
      "email": email,
      "password": "string",
      "gender": gender,
      "birthday": birthday,
      "google_id": googleController.googleAccount.value?.id ?? '',
      "avatar": googleController.googleAccount.value?.photoUrl ?? '',
    };
    try {
      response = await api().apiPut(body, url, jwt);

      if (response.statusCode == 200) {
        await getHome().getUser(context);
        resetInfo();
        setState(() {
          googleSSOShow = google_id == '' ? true : false;
        });
      } else {
        googleController.google_signOut();
        EasyLoading.showError('綁定失敗');
      }
    } catch (e) {
      googleController.google_signOut();
      EasyLoading.showError('綁定失敗');
      debugPrint(e.toString());
    }
  }

  //更改個人資訊
  changeInfor(body) async {
    var response;
    var url = dotenv.env['Profile'];
    var jwt = ',${state.accountState}';

    response = await api().apiPut(body, url, jwt);
    if (response.statusCode == 200) {
      EasyLoading.showSuccess(
          jsonDecode(utf8.decode(response.bodyBytes))['message']);
      await getHome().getUser(context);
      print(jsonDecode(utf8.decode(response.bodyBytes)));
      resetInfo();
      // state.updateprofileState(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      print(jsonDecode(utf8.decode(response.bodyBytes)));
    }
  } //此為顯示密碼function

  changePassword(body) async {
    var response;
    var url = '${dotenv.env['ChangePassword']}?type=login';
    var jwt = ',${state.accountState}';

    response = await api().apiPut(body, url, jwt);
    if (response.statusCode == 200) {
      EasyLoading.showSuccess(
          jsonDecode(utf8.decode(response.bodyBytes))['message']);
      await getHome().getUser(context);
      print(jsonDecode(utf8.decode(response.bodyBytes)));
      resetInfo();
    } else {
      print(jsonDecode(utf8.decode(response.bodyBytes)));
    }
  } //此為顯示密碼function

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

  void show_NewPassword() {
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

  //重設個人資料
  resetInfo() {
    setState(() {
      name = state.profile['name'];
      email = state.profile['email'];
      gender = state.profile['gender'];
      birthday = state.profile['birthday'];
      google_id = state.profile['google_id'] ?? '';
      img = base64Decode(state.profile['avatar']); //轉blob圖片
    });
  }

  googleBTNShow(value) {
    if (google_id == '') {
      if (value == true) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  Widget SSObtn() {
    return InkWell(
      onTap: () {
        try {
          if (googleController.googleAccount.value == null) {
            googleController.google();
          } else {
            //確保在登錄界面保持登出
            googleController.google_signOut();
          }
        } catch (e) {
          print(e);
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: SizedBox(
          width: (screenWidth > 600 ? 600 : screenWidth - 30),
          height: 50,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/login_icon/google.png',
                  width: 35,
                  height: 35,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text('Google 帳號連線')
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget birthdayDatePicker() {
    return Container(
      width: 310,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      child: TextButton(
          onPressed: () {
            DatePicker.showDatePicker(context, showTitleActions: true,
                onConfirm: (time) async {
              print(time);
              setState(() {
                birthday = time.toString().substring(0, 10);
              });
            });
          },
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(birthday,
                style: const TextStyle(color: Colors.black, fontSize: 18)),
          )),
    );
  }

  Widget decoratedBox() {
    return SizedBox(
      width: 300,
      child: DecoratedBox(
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
      ),
    );
  }

  Widget accountCentent() {
    return Column(children: [
      const SizedBox(
        height: 20,
      ),
      Center(
          child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.grey.shade300, // 替換成你想要的顏色
            width: 2.0, // 替換成你想要的線寬
          ),
        ),
        child: ClipOval(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Image.memory(
            base64Decode(state.profile?["avatar"] ?? ''),
            width: 90,
            height: 90,
            fit: BoxFit.cover,
          ),
        ),
      )),
      const SizedBox(
        height: 20,
      ),
      SizedBox(
          width: (screenWidth > 600 ? 600 : screenWidth - 30),
          child: Column(children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '帳戶資訊',
                    style: TextStyle(
                        color: const Color.fromRGBO(62, 111, 179, 1),
                        fontSize: screenWidth * 0.04),
                  ),
                )
              ],
            ),
            Card(
              elevation: 2,
              child: Center(
                child: SizedBox(
                  width: (screenWidth > 600 ? 600 : screenWidth - 20),
                  height: 360,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  saveShow = true;
                                  nameChangeShow = true;
                                  accountShow = false;
                                  googleSSOShow = googleBTNShow(googleSSOShow);
                                  changeStutes = 'name';
                                });
                              },
                              child: ListTile(
                                title: Text(
                                  '姓名:',
                                  style: TextStyle(color: Colors.grey.shade600),
                                ),
                                trailing: Text(
                                  name,
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: screenWidth * 0.033),
                                ),
                              ),
                            ),
                            const Divider(
                              thickness: 1,
                              color: Colors.grey,
                              indent: 1,
                            ),
                            InkWell(
                              onTap: (){
                                setState(() {
                                  saveShow = true;
                                  emailChangeShow = true;
                                  accountShow = false;
                                  googleSSOShow = googleBTNShow(googleSSOShow);
                                  changeStutes = 'email';
                                });
                              },
                              child: ListTile(
                                title: Text(
                                  'E-mail:',
                                  style: TextStyle(color: Colors.grey.shade600),
                                ),
                                trailing: Text(
                                  email,
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: screenWidth * 0.033),
                                ),
                              ),
                            ),
                            const Divider(
                                thickness: 1,
                                color: Colors.grey,
                                indent: 10,
                                endIndent: 10),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  saveShow = true;
                                  genderchangeShow = true;
                                  accountShow = false;
                                  googleSSOShow = googleBTNShow(googleSSOShow);
                                  changeStutes = 'gender';
                                });
                              },
                              child: ListTile(
                                title: Text(
                                  '性別:',
                                  style: TextStyle(color: Colors.grey.shade600),
                                ),
                                trailing: Text(
                                  gender,
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: screenWidth * 0.033),
                                ),
                              ),
                            ),
                            const Divider(
                                thickness: 1,
                                color: Colors.grey,
                                indent: 10,
                                endIndent: 10),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  saveShow = true;
                                  birthdayChangeShow = true;
                                  accountShow = false;
                                  googleSSOShow = googleBTNShow(googleSSOShow);
                                });
                              },
                              child: ListTile(
                                title: Text(
                                  '生日:',
                                  style: TextStyle(color: Colors.grey.shade600),
                                ),
                                trailing: Text(
                                  birthday,
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: screenWidth * 0.033),
                                ),
                              ),
                            ),
                            const Divider(
                              thickness: 1,
                              color: Colors.grey,
                              indent: 1,
                            ),
                            InkWell(
                              child: ListTile(
                                  title: Text(
                                    '密碼:',
                                    style:
                                        TextStyle(color: Colors.grey.shade600),
                                  ),
                                  trailing:
                                      const Icon(Icons.arrow_forward_ios)),
                              onTap: () {
                                setState(() {
                                  accountShow = false;
                                  passwordChangeShow = true;
                                });
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ]))
    ]);
  }

  Widget passwordChange() {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: () {
              setState(() {
                accountShow = true;
                passwordChangeShow = false;
              });
            },
            child: Icon(
              Icons.clear,
              size: 40,
              color: Colors.grey.shade500,
            ),
          ),
        ),
      ),
      Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            const Text(
              '更新您的密碼',
              style: TextStyle(fontSize: 30),
            ),
            const Text('輸入現有密碼及新密碼'),
            const SizedBox(
              height: 20,
            ),
            Textfield_password(
              controller: passwordController,
              hintText: '目前密碼',
              obscurText: showPassword,
              error_status: true,
              error_text: '',
              onTap: () {
                Show_Password();
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Textfield_password(
              controller: NewPasswordController,
              hintText: '新密碼',
              obscurText: showNewPassword,
              error_status: true,
              error_text: '',
              onTap: () {
                show_NewPassword();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  profileBody = {
                    "email": email,
                    "old_password":
                        Sha256().sha256Function(passwordController.text),
                    "new_password":
                        Sha256().sha256Function(NewPasswordController.text)
                  };
                });
                changePassword(profileBody);
              },
              child: const Card(
                color: Color.fromRGBO(62, 111, 179, 1),
                child: SizedBox(
                  width: 300,
                  height: 35,
                  child: Center(
                    child: Text(
                      '更新密碼',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      )
    ]);
  }

 Widget nameChange() {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: () {
              setState(() {
                accountShow = true;
                nameChangeShow = false;
                saveShow = false;
                googleSSOShow = googleBTNShow(googleSSOShow);
              });
            },
            child: Icon(
              Icons.clear,
              size: 40,
              color: Colors.grey.shade500,
            ),
          ),
        ),
      ),
      Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            const Text(
              '更新您的姓名',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextfield(
              controller: changedName,
              hintText: name,
              obscurText: false,
              error_status: true,
              error_text: '',
            ),
          ],
        ),
      )
    ]);
  }

  Widget genderChange() {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: () {
              setState(() {
                accountShow = true;
                genderchangeShow = false;
              });
            },
            child: Icon(
              Icons.clear,
              size: 40,
              color: Colors.grey.shade500,
            ),
          ),
        ),
      ),
      Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            const Text(
              '更新您的性別',
              style: TextStyle(fontSize: 30),
            ),
            decoratedBox()
          ],
        ),
      )
    ]);
  }

  Widget emailChange() {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: () {
              setState(() {
                accountShow = true;
                emailChangeShow = false;
                saveShow = false;
                googleSSOShow = googleBTNShow(googleSSOShow);
              });
            },
            child: Icon(
              Icons.clear,
              size: 40,
              color: Colors.grey.shade500,
            ),
          ),
        ),
      ),
      Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            const Text(
              '更新您的電子郵件',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextfield(
              controller: changedEmail,
              hintText: email,
              obscurText: false,
              error_status: true,
              error_text: '',
            ),
          ],
        ),
      )
    ]);
  }

  Widget birthdayChange() {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: () {
              setState(() {
                accountShow = true;
                birthdayChangeShow = false;
                saveShow = false;
                googleSSOShow = googleBTNShow(googleSSOShow);
              });
            },
            child: Icon(
              Icons.clear,
              size: 40,
              color: Colors.grey.shade500,
            ),
          ),
        ),
      ),
      Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            const Text(
              '更新您的生日',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(
              height: 20,
            ),
            birthdayDatePicker()
          ],
        ),
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(230, 240, 255, 1),
      appBar: AppBar(
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "會員管理",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        actions: [
          Visibility(
              visible: saveShow,
              child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: InkWell(
                    onTap: () {
                      switch (changeStutes) {
                        case 'name':
                          setState(() {
                            profileBody = {
                              "name": changedName.text,
                              "email": email,
                              "password": "string",
                              "gender": gender,
                              "birthday": birthday,
                              "google_id": google_id,
                              "avatar": img,
                            };
                          });
                          changeInfor(profileBody);
                          break;
                        case 'gender':
                          setState(() {
                            profileBody = {
                              "name": name,
                              "email": email,
                              "password": "string",
                              "gender": gender,
                              "birthday": birthday,
                              "google_id": google_id,
                              "avatar": img,
                            };
                          });
                          changeInfor(profileBody);
                          break;
                        case 'birthday':
                          setState(() {
                            profileBody = {
                              "name": name,
                              "email": email,
                              "password": "string",
                              "gender": gender,
                              "birthday": birthday,
                              "google_id": google_id,
                              "avatar": img,
                            };
                          });
                          changeInfor(profileBody);

                          break;
                           case 'email':
                          setState(() {
                            profileBody = {
                              "name": name,
                              "email": changedEmail.text,
                              "password": "string",
                              "gender": gender,
                              "birthday": birthday,
                              "google_id": google_id,
                              "avatar": img,
                            };
                          });
                          changeInfor(profileBody);

                          break;
                      }
                    },
                    child: const Text(
                      '儲存',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )))
        ],
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
            Visibility(visible: accountShow, child: accountCentent()),
            Visibility(visible: passwordChangeShow, child: passwordChange()),
            Visibility(visible: nameChangeShow, child: nameChange()),
            Visibility(visible: googleSSOShow, child: SSObtn()),
            Visibility(visible: genderchangeShow, child: genderChange()),
            Visibility(visible: birthdayChangeShow, child: birthdayChange()),
            Visibility(visible: emailChangeShow, child: emailChange())
          ],
        ),
      ),
    );
  }
}
