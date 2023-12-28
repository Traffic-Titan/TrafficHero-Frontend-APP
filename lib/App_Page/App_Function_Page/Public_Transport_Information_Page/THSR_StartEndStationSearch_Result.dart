// ignore_for_file: deprecated_member_use, file_names, camel_case_types, use_super_parameters, non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_types_as_parameter_names, unnecessary_brace_in_string_interps, avoid_print

import 'package:traffic_hero/Imports.dart';

class THSR_StartEndStationSearch_Result extends StatefulWidget {
  const THSR_StartEndStationSearch_Result({Key? key}) : super(key: key);

  @override
  State<THSR_StartEndStationSearch_Result> createState() =>
      _THSR_StartEndStationSearch_ResultState();
}

class _THSR_StartEndStationSearch_ResultState
    extends State<THSR_StartEndStationSearch_Result> {
  late stateManager state;

  var THSRDetail_StartName;
  var THSRDetail_EndName;
  var THSRDetail;
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
    THSRDetail_StartName = state.THSR_StartEndSearch_StartName;
    THSRDetail_EndName = state.THSR_StartEndSearch_EndName;
    THSRDetail = state.THSR_StartEndSearchResult;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //跳轉道車次搜尋結果頁面
    toCarNumSearchResult(num) async {
      var carNum = num;
      var url = '${dotenv.env['THSR_SearchBy_EachCar']}?CarNo=${carNum}';
      var jwt = ',${state.accountState}';
      print(url);
      var response = await api().apiGet(url, jwt);
      if (response.statusCode == 200) {
        print(jsonDecode(utf8.decode(response.bodyBytes)));
        setState(() {
          state.updateTHSR_CarNumSearch_CarNum(carNum);
          state.updateTHSR_CarNumSearchResult(
              jsonDecode(utf8.decode(response.bodyBytes)));
        });
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const THSR_CarNumSearchResult()));
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(113, 170, 221, 1),
        iconTheme: const IconThemeData(
          //返回鍵顏色
          color: Colors.white, //change your color here
        ),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        title: Text(
          THSRDetail_StartName + " - " + THSRDetail_EndName,
        ),
      ),
      body: Column(
        children: [
          // 標題
          const Row(
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(
                  width: 10,
                ),
              ),
              Expanded(
                  flex: 4,
                  child: Text(
                    "車次",
                    textScaleFactor: 1.5,
                    style: TextStyle(color: Color.fromRGBO(24, 60, 126, 1)),
                  )),
              Expanded(
                  flex: 4,
                  child: Text(
                    "出發時間",
                    textScaleFactor: 1.5,
                    style: TextStyle(color: Color.fromRGBO(24, 60, 126, 1)),
                  )),
              Expanded(
                flex: 1,
                child: SizedBox(
                  width: 10,
                ),
              ),
              Expanded(
                  flex: 4,
                  child: Text(
                    "抵達時間",
                    textScaleFactor: 1.5,
                    style: TextStyle(color: Color.fromRGBO(24, 60, 126, 1)),
                  )),
            ],
          ),
          const Divider(
            height: 2,
            color: Color.fromRGBO(24, 60, 126, 1),
          ),
          // 內容
          Flexible(
            child: ListView.builder(
                itemCount: THSRDetail.length,
                itemBuilder: (context, index) {
                  var list = THSRDetail[index];
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: InkWell(
                                child: ListTile(
                                  title: SizedBox(
                                      height: 30,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color.fromRGBO(
                                              24, 60, 126, 1),
                                        ),
                                        child: Text(
                                          list['車號'],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                          textAlign: TextAlign.center,
                                        ),
                                      )),
                                  subtitle: const Text("自由座車廂：6、7 車廂",
                                      style: TextStyle(fontSize: 10)),
                                ),
                                onTap: () async {
                                  await toCarNumSearchResult(list['車號']);
                                },
                              )),
                          Expanded(
                            flex: 3,
                            child: Text(
                              list['出發時間'],
                              style: const TextStyle(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const Expanded(
                              flex: 2, child: Icon(Icons.arrow_forward)),
                          Expanded(
                            flex: 3,
                            child: Text(
                              list['抵達時間'],
                              style: const TextStyle(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      (THSRDetail.length == index)
                          ? const Text('')
                          : const Divider(
                              height: 2,
                              color: Color.fromRGBO(24, 60, 126, 1),
                            ),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
