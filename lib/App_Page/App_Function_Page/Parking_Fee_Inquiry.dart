// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api, file_names, avoid_print, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:traffic_hero/Imports.dart';
import 'package:traffic_hero/Imports.dart' as choices;

class ParkingFeeInquiry extends StatefulWidget {
  const ParkingFeeInquiry({Key? key, required this.list_Amount}) : super(key: key);
  final List<dynamic> list_Amount;

  @override
  _ParkingFeeInquiryState createState() => _ParkingFeeInquiryState();
}

class _ParkingFeeInquiryState extends State<ParkingFeeInquiry> {
  @override
  void initState() {
    super.initState();
    print(widget.list_Amount);
    EasyLoading.dismiss();
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
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.list_Amount.length,
                  itemBuilder: (context, index) {
                    final list = widget.list_Amount[index];
                    return Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              font2(list["Area"]).toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.blueGrey,
                              ),
                            ),
                            onTap: () {
                              // Handle onTap action here
                            },
                          ),
                          const Divider(),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: list["Bill"].length,
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
