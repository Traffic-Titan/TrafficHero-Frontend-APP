// ignore_for_file: unused_import, file_names, non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print, avoid_types_as_parameter_names, use_build_context_synchronously, unnecessary_brace_in_string_interps, prefer_is_empty, camel_case_types, must_be_immutable

import 'package:traffic_hero/Imports.dart';
// Make sure to import other necessary dependencies here

class bindingLicensePlate extends StatefulWidget {
  bindingLicensePlate({Key? key, required this.list}) : super(key: key);
  var list;
  @override
  State<bindingLicensePlate> createState() => _bindingLicensePlateState();
}

class _bindingLicensePlateState extends State<bindingLicensePlate> {
  final afterLicensePlateController = TextEditingController();
  final beforeLicensePlateController = TextEditingController();
  late stateManager state;
  var checkBinding = true;
  var checkBinding2 = false;
  var listLicensePlateNumber = [];
  var screenWidth;

  String? type = 'C';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
    screenWidth = MediaQuery.of(context).size.width;
    EasyLoading.dismiss();
    setState(() {
      listLicensePlateNumber = widget.list['vehicle'];
    });
    print(widget.list);
    if (widget.list != 0) {
      setState(() {
        checkBinding = false;
        checkBinding2 = true;
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

  binding(license_plate_number, type) async {
    var response;
    var Body = {"license_plate_number": license_plate_number, "type": type};
    var url = dotenv.env['Vehicle'];
    var jwt = ',${state.accountState}';
    try {
      response = await api().apiPost(Body, url, jwt);
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      print(responseBody);
      await getBindingLicensePlate();
      EasyLoading.showSuccess(responseBody['message']);
    } catch (e) {
      print(e);
      EasyLoading.showError('伺服器錯誤');
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
        listLicensePlateNumber = responseBody['vehicle'];
      });
    }
  }

  deleteBindingLicensePlate(license_plate_number, type) async {
    EasyLoading.show(status: '刪除中...');
    var response;
    var body = {
      "license_plate_number": license_plate_number.toString(),
      "type": type.toString()
    };
    print(body);
    var url = dotenv.env['Vehicle'];
    var jwt = ',${state.accountState}';
    try {
      response = await api().apiDelete(
        url,
        jwt,
        body,
      );
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      print(responseBody);
      await getBindingLicensePlate();
      EasyLoading.showSuccess(responseBody['message']);
    } catch (e) {
      print(e);
      EasyLoading.showError('伺服器錯誤');
    }
  }

  goLicensePlateInput() async {
    EasyLoading.show(status: '查詢中...');
    var licensePlate;
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
      licensePlate = responseBody['vehicle'];
      print('eee');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LicensePlateInput(
                    vehicle: licensePlate,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        title: const Text('綁定車牌'),
        elevation: 0,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            goLicensePlateInput();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: screenWidth - 30 > 600 ? 600 : screenWidth - 30,
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  sizebox('已綁定車牌', Colors.blue.shade200, Colors.blue.shade900),
                  const SizedBox(height: 20),
                  SizedBox(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: Column(
                        children: [
                          Visibility(
                            visible: checkBinding,
                            child: const ListTile(
                              title: Text(
                                '無綁定車牌',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: checkBinding2,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: listLicensePlateNumber
                                  .length, // Replace with your actual item count
                              itemBuilder: (context, index) {
                                final list = listLicensePlateNumber[index];
                                return ListTile(
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                  trailing: InkWell(
                                    onTap: () {
                                      deleteBindingLicensePlate(
                                          list['license_plate_number'],
                                          list['type']);
                                    },
                                    child: const Text('刪除'),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  sizebox('綁定車牌', Colors.blue.shade200, Colors.blue.shade900),
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
                      binding(
                          '${beforeLicensePlateController.text}-${afterLicensePlateController.text}',
                          type);
                    },
                    child: sizebox('綁定', Colors.blue.shade800, Colors.white),
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
