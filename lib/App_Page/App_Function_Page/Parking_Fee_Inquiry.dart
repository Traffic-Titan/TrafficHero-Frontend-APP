// ignore_for_file: unused_import, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, avoid_print, prefer_typing_uninitialized_variables, must_be_immutable, unnecessary_new

import 'package:traffic_hero/Imports.dart';
import 'package:traffic_hero/Imports.dart' as choices;

class ParkingFeeInquiry extends StatefulWidget {
  ParkingFeeInquiry({super.key, required this.list_Amount});
  var list_Amount;

  @override
  State<ParkingFeeInquiry> createState() => _ParkingFeeInquiryState();
}

class _ParkingFeeInquiryState extends State<ParkingFeeInquiry> {
  @override
  void initState() {
    
    super.initState();
    print(widget.list_Amount);
    EasyLoading.dismiss();
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
                  Text('選擇區域' ),
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
        itemCount: widget.list_Amount.length,
        itemBuilder: (context, index) {
          final list = widget.list_Amount[index];
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
                                
                                   list["Area"].toString(),
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
                          children:  [
                            Expanded(
                              child: Visibility(
                                visible: true,
                                child: Text(
                                  '金額： '+  list["Amount"].toString(),
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
                              Text(list["Area"].toString()),
                              Divider(color: Colors.black,)
                            ],
                          ),
                          content: Container(
                            margin: EdgeInsets.symmetric(horizontal: 1),
                            height: 600,
                            child: ListView.builder(
                                itemCount: list['Bill'].length,
                                itemBuilder: (context, index) {
                                  final Bill = list['Bill'][index];
                                  return Column(
                                    children: [
                                      
                                      Container(
                                        width: 300,
                                        height: 30,
                                        child: ListTile(
                                          
                                          title: Text( Bill['ParkingDate'].toString()),
                                        ),
                                      ),
                                      SizedBox(height: 20,),
                                      Divider(color: Colors.black,),
                                      
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
