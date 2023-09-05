// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api, file_names, avoid_print, sized_box_for_whitespace, avoid_unnecessary_containers, must_be_immutable, camel_case_types, prefer_typing_uninitialized_variables, unused_local_variable

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
                          const Divider(),
                          Visibility(
                            visible: isExpanded,
                            child:
                            
                            Column(
                              children: [
                                const Text('未過期'),
                                ListView.builder(
                                   physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: list["bills"] == null
                                      ? 0
                                      : list["bills"].length,
                                  itemBuilder: (context, index) {
                                    var bills = list["bills"][index];
                                    return ListTile(
                                      title: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                bills['ParkingDate'],
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
