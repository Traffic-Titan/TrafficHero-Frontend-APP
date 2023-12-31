// ignore_for_file: unused_import, file_names, non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print, avoid_types_as_parameter_names, use_build_context_synchronously, unnecessary_brace_in_string_interps, prefer_is_empty, unused_local_variable, must_be_immutable, sized_box_for_whitespace

import 'package:traffic_hero/Imports.dart';
// Make sure to import other necessary dependencies here

class LicensePlateInput extends StatefulWidget {
  LicensePlateInput({super.key, required this.vehicle});
  var vehicle = [];

  @override
  State<LicensePlateInput> createState() => _LicensePlateInputState();
}

class _LicensePlateInputState extends State<LicensePlateInput> {
  final afterLicensePlateController = TextEditingController();
  final beforeLicensePlateController = TextEditingController();
  late stateManager state;
  var list2 = [];
  var vehicle = [];
  String? type = 'C';

  void showResultDialog(BuildContext context, listUser, listAmount, list2) {
    showPlatformDialog(
      context: context,
      builder: (context) => BasicDialogAlert(
        title: const Text(
          "維護中",
          style: TextStyle(fontSize: 20),
        ),
        content: SizedBox(
          width: 300,
          height: (list2.length * 100).toDouble(),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: list2.length,
            itemBuilder: (context, index) {
              var list = list2[index];
              return ListTile(
                title: Text(list['area']),
              );
            },
          ),
        ),
        actions: <Widget>[
          BasicDialogAction(
            title: const Text("繼續"),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => parkingFeeInquiry(
                    listUser: listUser,
                    listAmount: listAmount,
                    list2: list2,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void showResultDialog2(BuildContext context) {
    showPlatformDialog(
      context: context,
      builder: (context) => BasicDialogAlert(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "查詢結果",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
        content: Container(
          height: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(height: 20, child: const Text("無停車費")),
            ],
          ),
        ),
        actions: <Widget>[
          BasicDialogAction(
            title: const Text("繼續"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
    EasyLoading.dismiss();
    setState(() {
      vehicle = widget.vehicle;
    });
  }

  get_Amount(LicensePlateNumber, type) async {
    EasyLoading.show(status: '查詢中...');
    var response;
    var url =
        '${dotenv.env['ParkingFee']}?license_plate_number=${LicensePlateNumber}&type=${type}';
    var jwt = ',${state.accountState}';
    try {
      response = await api().apiGet(url, jwt);
    } catch (e) {
      print(e);
    }

    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      print(jsonDecode(utf8.decode(response.bodyBytes)));
      var list = [];
      setState(() {
        list2 = [];
      });

      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      print(responseBody['detail'].length);
      for (var i = 0; i < responseBody['detail'].length.toInt(); i++) {
        if (responseBody['detail'][i]['amount'] == -1) {
          list2.add(responseBody['detail'][i]);
          print(list2);
        } else {
          list.add(responseBody['detail'][i]);
          print(list);
        }
      }

      if (list.length != 0) {
        if (list2.length == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => parkingFeeInquiry(
                listUser: jsonDecode(utf8.decode(response.bodyBytes)),
                listAmount: list,
                list2: list2,
              ),
            ),
          );
        } else {
          try {
            showResultDialog(context,
                jsonDecode(utf8.decode(response.bodyBytes)), list, list2);
          } catch (e) {
            print(e);
          }
        }
      } else {
        showResultDialog2(context);
      }
    }
  }

  goBindingLicensePlate() async {
    EasyLoading.show(status: '查詢中...');
    var response;
    var url = dotenv.env['Vehicle'];
    var jwt = ',${state.accountState}';
    try {
      response = await api().apiGet(url, jwt);
    } catch (e) {
      print(e);
    }
    var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => bindingLicensePlate(
            list: responseBody,
          ),
        ),
      );
    }
  }

  getBindingLicensePlate() async {
    EasyLoading.show(status: '查詢中...');
    var response;
    var url = dotenv.env['Vehicle'];
    var jwt = ',${state.accountState}';
    try {
      response = await api().apiGet(url, jwt);
    } catch (e) {
      print(e);
    }
    var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      setState(() {
        vehicle = responseBody['vehicle'];
      });
    }
  }

  changeType(type) {
    if (type == 'C') {
      return '小客車';
    } else if (type == 'M') {
      return '機車';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        title: const Text('停車費查詢'),
        elevation: 0,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AllPage()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 30,
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  sizebox('已綁定車牌', Colors.blue.shade200, Colors.blue.shade900),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 400,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            title: const Text(
                              '新增/綁定車牌',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.blueGrey,
                              ),
                            ),
                            onTap: () {
                              goBindingLicensePlate();
                            },
                          ),
                          const Divider(),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: vehicle
                                .length, // Replace with your actual item count
                            itemBuilder: (context, index) {
                              final list = vehicle[index];
                              return ListTile(
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      list['license_plate_number'].toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "${changeType(list['type'])}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () async {
                                  await get_Amount(
                                      list['license_plate_number'].toString(),
                                      list['type'].toString());
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  sizebox('查詢車牌', Colors.blue.shade200, Colors.blue.shade900),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 390,
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('車種',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 14, 70, 134))),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        decoratedBox(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 390,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '車牌',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 14, 70, 134)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: inputTextField(
                                  beforeLicensePlateController, 'ABC'),
                            ),
                            const Text(
                              '  -  ',
                              style: TextStyle(fontSize: 40),
                            ),
                            Expanded(
                              child: inputTextField(
                                  afterLicensePlateController, '1234'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      get_Amount(
                          '${beforeLicensePlateController.text}-${afterLicensePlateController.text}',
                          type);
                    },
                    child: sizebox('送出', Colors.blue.shade800, Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget inputTextField(controller, hintText) {
    return SizedBox(
        width: 10,
        child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              fillColor: Colors.blue.shade900,
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.blue.shade900, style: BorderStyle.solid),
                  borderRadius: const BorderRadius.all(Radius.circular(0))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue.shade900),
                  borderRadius: const BorderRadius.all(Radius.circular(0))),
            )));
  }

  Widget sizebox(String sizeboxtext, Color, textcolor) {
    return SizedBox(
      height: 40,
      width: 400,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color,
        ),
        child: Center(
          child: Text(
            sizeboxtext.toString(),
            style: TextStyle(fontSize: 20, color: textcolor),
          ),
        ),
      ),
    );
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
          child: DropdownButton<String>(
            borderRadius: BorderRadius.circular(20),
            value: type,
            items: const [
              DropdownMenuItem(
                value: 'C',
                child: Text('小客車'),
              ),
              DropdownMenuItem(
                value: 'M',
                child: Text('機車'),
              ),
            ],
            onChanged: (value) {
              setState(() {
                type = value;
              });
            },
            icon: const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Icon(Icons.arrow_circle_down_sharp),
            ),
            iconEnabledColor: const Color.fromARGB(255, 0, 0, 0),
            style: const TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 17,
            ),
            dropdownColor: const Color.fromARGB(255, 255, 249, 249),
            underline: Container(),
            isExpanded: true,
          ),
        ),
      ),
    );
  }
}
