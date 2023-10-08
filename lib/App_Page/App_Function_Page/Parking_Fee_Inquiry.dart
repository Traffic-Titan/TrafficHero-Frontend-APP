// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api, file_names, avoid_print, sized_box_for_whitespace, avoid_unnecessary_containers, must_be_immutable, camel_case_types, prefer_typing_uninitialized_variables, unused_local_variable, use_build_context_synchronously

import 'package:traffic_hero/Imports.dart';
import 'package:traffic_hero/Imports.dart' as choices;

class parkingFeeInquiry extends StatefulWidget {
  parkingFeeInquiry(
      {Key? key, required this.listUser, required this.listAmount,required this.list2})
      : super(key: key);

  var listUser;
  var listAmount;
  var list2;

  @override
  _parkingFeeInquiryState createState() => _parkingFeeInquiryState();
}


                            

class _parkingFeeInquiryState extends State<parkingFeeInquiry> {
    late stateManager state;
  @override
  void initState() {
    super.initState();
    print(widget.listUser);
    EasyLoading.dismiss();
  }

    @override
      void didChangeDependencies() {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
    EasyLoading.dismiss();
    print(widget.listAmount);
    if(widget.list2.length != 0){
      
    }
    // FlutterTts().speak('歡迎來到 Traffic Hero');
  }

  text(name) {
    for (var i = 0; i < choices.city_Chiness.length; i++) {
      if (choices.city_Chiness[i]['title'] == name) {
        return choices.city_Chiness[i]['value'];
      } else if (choices.city_English[i]['title'] == name) {
        return choices.city_English[i]['value'];
      } else if (choices.city_ios[i]['title'] == name) {
        return choices.city_ios[i]['value'];
      }
    }
    return ''; // Return a default value if no match is found
  }

  font2(name) {
    for (var i = 0; i < choices.city_Chiness.length; i++) {
      if (name == 'Taipei_City') {
        return '臺北市';
      } else if (choices.city_Chiness[i]['value'] == name) {
        return choices.city_Chiness[i]['title'];
      }
    }
    return name; // Return the original name if no match is found
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
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => LicensePlateInput(vehicle: licensePlate,)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 193, 229, 255),
      appBar: AppBar(
        elevation: 0,
        title: const Text('停車費查詢'),
       
      ),
      body: SingleChildScrollView(
        child: Container(
          width: 600,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                width: 350,
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        title: const Text('車種'),
                        trailing: Text(widget.listUser['type'].toString()),
                      ),
                      ListTile(
                        title: const Text('車號'),
                        trailing: Text(widget.listUser['license_plate_number']),
                      ),
                        ListTile(
                        title: const Text('總額'),
                        trailing: Text(" ${widget.listUser['total_amount']}"),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 350,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.listAmount.length,
                  itemBuilder: (context, index) {
                    final list = widget.listAmount[index];
                    var isExpanded = false; // 初始狀態為收起
                    return Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: Column(
                        children: [    
                          ListTile(
                            title: Text(
                              font2(list["area"]).toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.blueGrey,
                              ),
                            ),
                            trailing: Text("總額：${list['amount']}"),
                            onTap: () {
                              print(list);
                              setState(() {
                                isExpanded = true;
                              });
                            },
                          ),
                          
                          Visibility(
                            visible: true,
                            child:
                            Column(
                              children: [
                                const Divider(),
                                // const Text('未過期'),
                                ListView.builder(
                                   physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: list["bills"].length ,
                                  itemBuilder: (context, index) {
                                    var bills = list["bills"][index];
                                    bool test = false;
                                    return ListTile(
                                      title: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                    () {
                                                  if (DateTime.parse('2023-10-12').isAfter(DateTime.parse(bills['PayLimitDate']))) {
                                                    test = true;
                                                  } else {
                                                    test = false;
                                                  }
                                                  return bills['BillNo'];
                                                }(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: (test ? Colors.red : Colors.black),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            '${bills['ParkingDate']}\n到期日: ${bills['PayLimitDate']}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: (test ? Colors.red : Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                      trailing: Text('應繳金額： ${bills['PayAmount']}元\n累積停車: ${bills['ParkingHours']}h'),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: true,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: list["Reminders"] == null
                                  ? 0
                                  : list["Reminders"].length,
                              itemBuilder: (context, index) {
                                var bills = list["Reminders"][index];
                                return ListTile(
                                  title: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            bills['Bills']['ParkingDate'] ?? '',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                              '累積停車時間： ${bills['ParkingHours']} 小時'),
                                        ],
                                      )
                                    ],
                                  ),
                                  trailing: Text('付款金額： ${bills['PayAmount']}'),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
