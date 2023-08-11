// ignore_for_file: unused_import, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, avoid_print, prefer_typing_uninitialized_variables, must_be_immutable, unnecessary_new

import 'package:traffic_hero/Imports.dart';
import 'package:traffic_hero/Imports.dart' as choices;

class ParkingFeeInquiry extends StatefulWidget {
  ParkingFeeInquiry({super.key, required this.text});
  var text;

  @override
  State<ParkingFeeInquiry> createState() => _ParkingFeeInquiryState();
}

class _ParkingFeeInquiryState extends State<ParkingFeeInquiry> {
  @override
  void initState() {
    
    super.initState();
    print(widget.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('停車費查詢'),
      ),
      body: SizedBox(
        width: 600,
        child: Column(
          children: [
            SizedBox(
              
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('選擇區域，車牌號： ' + widget.text),
                ],
              )),
              Expanded(child: listview(),)
            
          ],
        ),
      ),
    );
  }

  Widget listview() {
    return ListView.builder(
        itemCount: choices.city_Chiness.length,
        itemBuilder: (context, index) {
          final list = choices.city_Chiness[index];
          return Column(
            children: [
              Column(
                children: [
                  ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                    title: Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Text(
                                list['title'].toString() == '台北市'
                                    ? '臺北市'
                                    : list['title'].toString(),
                                style: TextStyle(fontSize: 15),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    trailing: SizedBox(
                        width: 150,
                        child: Row(
                          children: const [
                            Expanded(
                              child: Visibility(
                                visible: true,
                                child: Text(
                                  '總金額： 200',
                                  maxLines: 1,
                                ),
                              ),
                            ),

                            Icon(
                              Icons.arrow_forward_ios,
                              size: 30,
                            ),
                          ],
                        )),
                    onTap: () {
                      showPlatformDialog(
                        context: context,
                        builder: (context) => BasicDialogAlert(
                          title: Column(
                            children: [
                              Text(list['title'].toString()),
                              Divider(color: Colors.black,)
                            ],
                          ),
                          content: Container(
                            margin: EdgeInsets.symmetric(horizontal: 1),
                            height: 600,
                            child: ListView.builder(
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Divider(color: Colors.black,),
                                      Container(
                                        width: 300,
                                        height: 30,
                                        child: ListTile(
                                          
                                          title: Text('停車費'),
                                        ),
                                      ),
                                      
                                    ],
                                  );
                                }),
                          ),
                          actions: <Widget>[
                            BasicDialogAction(
                              title: Text("Cancel"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
              new Divider(
                color: Colors.black,
              ),
            ],
          );
        });
  }
}
