// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api, file_names, avoid_print, sized_box_for_whitespace, avoid_unnecessary_containers, use_build_context_synchronously

import 'package:traffic_hero/Imports.dart';
import 'package:traffic_hero/Imports.dart' as choices;

class ParkingFeeInquiry extends StatefulWidget {
  ParkingFeeInquiry(
      {Key? key, required this.licensePlateNumber, required this.type})
      : super(key: key);
  var licensePlateNumber;
  // ignore: prefer_typing_uninitialized_variables
  var type;

  @override
  _ParkingFeeInquiryState createState() => _ParkingFeeInquiryState();
}

class _ParkingFeeInquiryState extends State<ParkingFeeInquiry> {
  late stateManager state;
  //控制是否開啟抽屜
  bool keelungCity = false;
  bool newTaipeiCity = false;
  bool taipeiCity = false;
  bool hsinchuCity = false;
  bool taoyuanCity = false;
  bool hsinchuCounty = false;
  bool taichungCity = false;
  bool changhuaCounty = false;
  bool kaohsiungCity = false;
  bool tainanCity = false;
  bool pingtungCounty = false;

  var keelungCityDetail;
  var newTaipeiCityDetail;
  var taipeiCityDetail;
  var hsinchuCityDetail;
  var taoyuanCityDetail;
  var hsinchuCountyDetail;
  var taichungCityDetail;
  var changhuaCountyDetail;
  var kaohsiungCityDetail;
  var tainanCityDetail;
  var pingtungCountyDetail;

  var keelungCityAmount = 'Loading ...';
  var newTaipeiCityAmount = 'Loading ...';
  var taipeiCityAmount = 'Loading ...';
  var hsinchuCityAmount = 'Loading ...';
  var taoyuanCityAmount = 'Loading ...';
  var hsinchuCountyAmount = 'Loading ...';
  var taichungCityAmount = 'Loading ...';
  var changhuaCountyAmount = 'Loading ...';
  var kaohsiungCityAmount = 'Loading ...';
  var tainanCityAmount = 'Loading ...';
  var pingtungCountyAmount = 'Loading ...';

  Map<String, Color> styleColor = {
    'text': Colors.black,
    'background': Colors.white
  };

  var keelungCityStyle;
  var newTaipeiCityStyle;
  var taipeiCityStyle;
  var hsinchuCityStyle;
  var taoyuanCityStyle;
  var hsinchuCountyStyle;
  var taichungCityStyle;
  var changhuaCountyStyle;
  var kaohsiungCityStyle;
  var tainanCityStyle;
  var pingtungCountyStyle;

  @override
  void initState() {
    super.initState();
    EasyLoading.dismiss();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
    setState(() {
      keelungCityStyle = styleColor;
      newTaipeiCityStyle = styleColor;
      taipeiCityStyle = styleColor;
      hsinchuCityStyle = styleColor;
      taoyuanCityStyle = styleColor;
      hsinchuCountyStyle = styleColor;
      taichungCityStyle = styleColor;
      changhuaCountyStyle = styleColor;
      kaohsiungCityStyle = styleColor;
      tainanCityStyle = styleColor;
      pingtungCountyStyle = styleColor;
    });
    EasyLoading.dismiss();
    KeelungCity();
    NewTaipeiCity();
    TaipeiCity();
    HsinchuCity();
    TaoyuanCity();
    HsinchuCounty();
    TaichungCity();
    ChanghuaCounty();
    KaohsiungCity();
    TainanCity();
    PingtungCounty();
    //  TaitungCounty();
  }

  Future<Map<String, dynamic>> _getCityAmount(String cityCode) async {
    var res = await getAmount(cityCode);
    return res;
  }

  Future<void> _updateCityAmount(String cityAmount, Map<String, dynamic> res,
      void Function(String, Map<String, Color>) setCardStyle, setDetail) async {
    if (res['Detail']['Amount'] == 0) {
      Map<String, Color> style = {
        'text': Colors.black,
        'background': Colors.white
      };
      setCardStyle('此縣市無欠款', style);
    } else {
      Map<String, Color> style = {
         'text': Colors.white,
        'background': Colors.blue.shade300
      };
      setCardStyle('總金額：${res['Detail']['Amount']}', style);
      setDetail(res['Detail']['Bill']);
    }
  }

  Future<void> TaipeiCity() async {
    var res = await _getCityAmount('TaipeiCity');
    _updateCityAmount(taipeiCityAmount, res, (newAmount, newStyle) {
      setState(() {
        taipeiCityAmount = newAmount;
        taipeiCityStyle = newStyle;
      });
    }, (newDetail) {
      setState(() {
        taipeiCityDetail = newDetail;
      });
    });
  }

  Future<void> KeelungCity() async {
    var res = await getAmount('KeelungCity');
    _updateCityAmount(keelungCityAmount, res, (newAmount,newStyle) {
      setState(() {
        keelungCityAmount = newAmount;
        keelungCityStyle = newStyle;
      });
    }, (newDetail) {
      setState(() {
        keelungCityDetail = newDetail;
      });
    });
  }

  Future<void> NewTaipeiCity() async {
    var res = await getAmount('NewTaipeiCity');
    _updateCityAmount(newTaipeiCityAmount, res, (newAmount,newStyle) {
      setState(() {
        newTaipeiCityAmount = newAmount;
        newTaipeiCityStyle = newStyle;
      });
    }, (newDetail) {
      setState(() {
        newTaipeiCityDetail = newDetail;
      });
    });
  }

  Future<void> HsinchuCity() async {
    var res = await getAmount('HsinchuCity');
    _updateCityAmount(hsinchuCityAmount, res, (newAmount,newStyle) {
      setState(() {
        hsinchuCityAmount = newAmount;
        hsinchuCityStyle = newStyle;
      });
    }, (newDetail) {
      setState(() {
        hsinchuCityDetail = newDetail;
      });
    });
  }

  Future<void> TaoyuanCity() async {
    var res = await getAmount('TaoyuanCity');
    _updateCityAmount(taoyuanCityAmount, res, (newAmount,newStyle) {
      setState(() {
        taoyuanCityAmount = newAmount;
        taoyuanCityStyle = newStyle;
      });
    }, (newDetail) {
      setState(() {
        taoyuanCityDetail = newDetail;
      });
    });
  }

  Future<void> HsinchuCounty() async {
    var res = await getAmount('HsinchuCounty');
    _updateCityAmount(hsinchuCountyAmount, res, (newAmount,newStyle) {
      setState(() {
        hsinchuCountyAmount = newAmount;
        hsinchuCountyStyle = newStyle;
      });
    }, (newDetail) {
      setState(() {
        hsinchuCountyDetail = newDetail;
      });
    });
  }

  Future<void> TaichungCity() async {
    var res = await getAmount('TaichungCity');
    _updateCityAmount(taichungCityAmount, res, (newAmount,newStyle) {
      setState(() {
        taichungCityAmount = newAmount;
        taichungCityStyle = newStyle;
      });
    }, (newDetail) {
      setState(() {
        taichungCityDetail = newDetail;
      });
    });
  }

  Future<void> ChanghuaCounty() async {
    var res = await getAmount('ChanghuaCounty');
    _updateCityAmount(changhuaCountyAmount, res, (newAmount,newStyle) {
      setState(() {
        changhuaCountyAmount = newAmount;
        changhuaCountyStyle = newStyle;
      });
    }, (newDetail) {
      setState(() {
        changhuaCountyDetail = newDetail;
      });
    });
  }

  Future<void> KaohsiungCity() async {
    var res = await getAmount('KaohsiungCity');
    _updateCityAmount(kaohsiungCityAmount, res, (newAmount,newStyle) {
      setState(() {
        kaohsiungCityAmount = newAmount;

      });
    }, (newDetail) {
      setState(() {
        kaohsiungCityDetail = newDetail;
      });
    });
  }

  Future<void> TainanCity() async {
    var res = await getAmount('TainanCity');
    _updateCityAmount(tainanCityAmount, res, (newAmount,newStyle) {
      setState(() {
        tainanCityAmount = newAmount;
        tainanCityStyle = newStyle;
      });
    }, (newDetail) {
      setState(() {
        tainanCityDetail = newDetail;
      });
    });
  }

  Future<void> PingtungCounty() async {
    var res = await getAmount('PingtungCounty');
    _updateCityAmount(pingtungCountyAmount, res, (newAmount,newStyle) {
      setState(() {
        pingtungCountyAmount = newAmount;
        pingtungCountyStyle = newStyle;
      });
    }, (newDetail) {
      setState(() {
        pingtungCountyDetail = newDetail;
      });
    });
  }

// Future<void> TaitungCounty() async {
//   var res = await getAmount('TaitungCounty');
//   _updateCityAmount(taitungCountyAmount, res, (newAmount) {
//     setState(() {
//       taitungCountyAmount = newAmount;
//     });
//   });
// }

  changeTypeName(type) {
    if (type == 'C') {
      return '汽車';
    } else if (type == 'M') {
      return '機車';
    } else {
      return '其他(如拖車)';
    }
  }

  getAmount(area) async {
    var Body = {
      "licensePlateNumber": widget.licensePlateNumber,
      "type": widget.type,
      "area": area
    };
    var response;
    var url = dotenv.env['ParkingFee'].toString();
    var jwt = ',${state.accountState}';
    try {
      response = await api().apiPost(Body, url, jwt);
    } catch (e) {
      print(e);
    }

    if (response.statusCode == 200) {
      print(jsonDecode(utf8.decode(response.bodyBytes)));
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      return responseBody;
    } else {
      EasyLoading.showError(
          jsonDecode(utf8.decode(response.bodyBytes))['detail']);
    }
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

  contentShow(show, amount) {
    if (amount != '此縣市無欠款') {
      if (show == '基隆市') {
        if (keelungCity == true) {
          setState(() {
            keelungCity = false;
          });
        } else {
          setState(() {
            keelungCity = true;
          });
        }
      } else if (show == '新北市') {
        if (newTaipeiCity == true) {
          setState(() {
            newTaipeiCity = false;
          });
        } else {
          setState(() {
            newTaipeiCity = true;
          });
        }
      } else if (show == '台北市') {
        if (taipeiCity == true) {
          setState(() {
            taipeiCity = false;
          });
        } else {
          setState(() {
            taipeiCity = true;
          });
        }
      } else if (show == '新竹市') {
        if (hsinchuCity == true) {
          setState(() {
            hsinchuCity = false;
          });
        } else {
          setState(() {
            hsinchuCity = true;
          });
        }
      } else if (show == '桃園市') {
        if (taoyuanCity == true) {
          setState(() {
            taoyuanCity = false;
          });
        } else {
          setState(() {
            taoyuanCity = true;
          });
        }
      } else if (show == '新竹縣') {
        if (hsinchuCounty == true) {
          setState(() {
            hsinchuCounty = false;
          });
        } else {
          setState(() {
            hsinchuCounty = true;
          });
        }
      } else if (show == '台中市') {
        if (taichungCity == true) {
          setState(() {
            taichungCity = false;
          });
        } else {
          setState(() {
            taichungCity = true;
          });
        }
      } else if (show == '彰化縣') {
        if (changhuaCounty == true) {
          setState(() {
            changhuaCounty = false;
          });
        } else {
          setState(() {
            changhuaCounty = true;
          });
        }
      } else if (show == '高雄市') {
        if (kaohsiungCity == true) {
          setState(() {
            kaohsiungCity = false;
          });
        } else {
          setState(() {
            kaohsiungCity = true;
          });
        }
      } else if (show == '台南市') {
        if (tainanCity == true) {
          setState(() {
            tainanCity = false;
          });
        } else {
          setState(() {
            tainanCity = true;
          });
        }
      } else if (show == '屏東縣') {
        if (pingtungCounty == true) {
          setState(() {
            pingtungCounty = false;
          });
        } else {
          setState(() {
            pingtungCounty = true;
          });
        }
      }
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
                        trailing: Text(changeTypeName(widget.type)),
                      ),
                      ListTile(
                        title: const Text('車號'),
                        trailing: Text(widget.licensePlateNumber),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 400,
                child: Column(children: [
                  card('基隆市', keelungCity, keelungCityDetail, keelungCityAmount,
                      keelungCityStyle),
                  card('新北市', newTaipeiCity, newTaipeiCityDetail,
                      newTaipeiCityAmount, newTaipeiCityStyle),
                  card('台北市', taipeiCity, taipeiCityDetail, taipeiCityAmount,
                      taipeiCityStyle),
                  card('新竹市', hsinchuCity, hsinchuCityDetail, hsinchuCityAmount,
                      hsinchuCityStyle),
                  card('桃園市', taoyuanCity, taoyuanCityDetail, taoyuanCityAmount,
                      taoyuanCityStyle),
                  card('新竹縣', hsinchuCounty, hsinchuCountyDetail,
                      hsinchuCountyAmount, hsinchuCountyStyle),
                  card('台中市', taichungCity, taichungCityDetail,
                      taichungCityAmount, taichungCityStyle),
                  card('彰化縣', changhuaCounty, changhuaCountyDetail,
                      changhuaCountyAmount, changhuaCountyStyle),
                  card('高雄市', kaohsiungCity, kaohsiungCityDetail,
                      kaohsiungCityAmount, kaohsiungCityStyle),
                  card('台南市', tainanCity, tainanCityDetail, tainanCityAmount,
                      tainanCityStyle),
                  card('屏東縣', pingtungCounty, pingtungCountyDetail,
                      pingtungCountyAmount, pingtungCountyStyle),
                  const SizedBox(
                    height: 30,
                  )
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget card(
      name, contentShowStatus, contextDetail, contextAmount, cardStyle) {
    return Card(
      elevation: 1,
      color: cardStyle['background'],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: cardStyle['text'],
              ),
            ),
            trailing: Visibility(
                visible: true,
                child: Text(
                  contextAmount,
                  style: TextStyle(color: cardStyle['text']),
                )),
            onTap: () {
              contentShow(name, contextAmount);
            },
          ),
          const SizedBox(
            height: 10,
          ),
          // const Divider(),
          Visibility(
            visible: contentShowStatus,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: contextDetail != null ? contextDetail.length : 0,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        contextDetail.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
