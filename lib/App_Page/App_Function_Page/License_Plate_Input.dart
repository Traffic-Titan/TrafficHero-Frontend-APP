// ignore_for_file: unused_import, file_names, non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print, avoid_types_as_parameter_names, use_build_context_synchronously

import 'package:traffic_hero/Imports.dart';
// Make sure to import other necessary dependencies here

class LicensePlateInput extends StatefulWidget {
  const LicensePlateInput({Key? key}) : super(key: key);

  @override
  State<LicensePlateInput> createState() => _LicensePlateInputState();
}

class _LicensePlateInputState extends State<LicensePlateInput> {
  final afterLicensePlateController = TextEditingController();
  final beforeLicensePlateController = TextEditingController();
  late stateManager state;
  
  //綁定車牌測試用
  var test = [
    {"LicensePlateNumber": 'NKJ-5657', "Type": "M"},
    {"LicensePlateNumber": 'AVZ-6300', "Type": "C"}
  ];

  String? type = 'C';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
    EasyLoading.dismiss();
  }

  get_Amount(LicensePlateNumber, type) async {
    var Body = {"licensePlateNumber": LicensePlateNumber, "type": type};
    var response;
    var url = dotenv.env['ParkingFee'].toString()+ '?LicensePlateNumber=${LicensePlateNumber}&Type=${type}';
    var jwt = ','+state.accountState;
    try {
      response = await api().Api_Get( url, jwt);
    } catch (e) {
      print(e);
    }

    if (response.statusCode == 200) {
      print(jsonDecode(utf8.decode(response.bodyBytes)));
      var list = [];
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      for(var i =0 ; i<responseBody['Detail'].length;i++){if(responseBody['Detail'] == '服務維護中'){

      }else{
       print(responseBody['Detail'][i]);
       list.add(responseBody['Detail'][i]);
      }}
      
      // print(responseBody);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ParkingFeeInquiry(
            
            listUser: jsonDecode(utf8.decode(response.bodyBytes)),
            listAmount: list,
          ),
        ),
      );
    } else {
      showPlatformDialog(
        context: context,
        builder: (context) => BasicDialogAlert(
          title: const Text(
            "查詢結果",
            style: TextStyle(fontSize: 20),
          ),
          content: const Text("未查詢到任何停車費"),
          actions: <Widget>[
            BasicDialogAction(
              title: const Text("Discard"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    }
  }

  Binding_License_Plate() {
    var BindingLicensePlate = [];
    BindingLicensePlate.add({
      "licensePlateNumber":
          '${beforeLicensePlateController.text}-${afterLicensePlateController.text}',
      "type": type
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        title: const Text('停車費查詢'),
        elevation: 0,
        backgroundColor: Colors.blue,
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
                              showPlatformDialog(
                                context: context,
                                builder: (context) => BasicDialogAlert(
                                  title: const Text(
                                    "車牌綁定",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  content: const Text(""),
                                  actions: <Widget>[
                                    BasicDialogAction(
                                      title: const Text("Discard"),
                                      onPressed: () {
                                        
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          const Divider(),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: test
                                .length, // Replace with your actual item count
                            itemBuilder: (context, index) {
                              final list = test[index];
                              return ListTile(
                                title: Text(
                                  list['LicensePlateNumber'].toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                onTap: () {
                                  EasyLoading.show(status: 'Loading...');
                                 
                                  get_Amount(
                                      list['LicensePlateNumber'].toString(),
                                      list['Type'].toString());
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
                      EasyLoading.show(status: 'Loading...');
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
                child: Text('汽車'),
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
