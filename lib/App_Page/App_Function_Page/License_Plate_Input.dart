// ignore_for_file: unused_import, file_names



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
  
  String? type = 'C';

  

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
    EasyLoading.dismiss();
  }

  get_Amount(LicensePlateNumber,type) async {
    var Body = {
      "LicensePlateNumber": LicensePlateNumber,
      "Type": type
    };
    var response;
    var url = '/Home/ParkingFee';
    var jwt = state.accountState;
    try {
      response = await api().Api_Post(Body, url, jwt);
    } catch (e) {
      print(e);
    }

    if (response.statusCode == 200) {
      var list = [];
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      for (var i = 0; i < responseBody["Detail"].length; i++) {
        if (responseBody["Detail"][i]["Amount"] != 0) {
          print(responseBody["Detail"][i]);
          list.add(responseBody["Detail"][i]);
        }
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ParkingFeeInquiry(
            list_Amount: list,
          ),
        ),
      );
    }
  }

  Binding_License_Plate (){
    var BindingLicensePlate = [];
    BindingLicensePlate.add({
      
      "LicensePlateNumber": '${beforeLicensePlateController.text}-${afterLicensePlateController.text}',
      "Type": type
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
                            onTap: () {},
                          ),
                          const Divider(),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: 0, // Replace with your actual item count
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  '内容 $index',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
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
                      get_Amount('${beforeLicensePlateController.text}-${afterLicensePlateController.text}',type);
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
