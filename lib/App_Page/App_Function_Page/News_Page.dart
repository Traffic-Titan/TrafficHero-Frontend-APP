// ignore_for_file: sized_box_for_whitespace, avoid_print, file_names, unnecessary_set_literal, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, non_constant_identifier_names, avoid_unnecessary_containers, sort_child_properties_last, prefer_interpolation_to_compose_strings, dead_code, unused_field
import 'package:traffic_hero/Imports.dart';
import 'package:traffic_hero/Components/Choices.dart' as choices;
import 'package:geocoding/geocoding.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  late stateManager state;
  var response,
      test,
      listCity,
      listType,
      selectCitySubText = '',
      selectName,
      selectNameEnglish,
      urlApi,
      url_test;

  List<String> selectCity = [], selectType = ['All'];
  late List<Placemark> placemarks;
  StreamSubscription<Position>? _positionStreamSubscription;
  // Color get primaryColor => Theme.of(context).primaryColor;
  late var listView = [];

  @override
  void initState() {
    super.initState();
    location();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    EasyLoading.show(status: 'Loading.....');
    state = Provider.of<stateManager>(context, listen: false);
    location();

    //依照模式判斷顯示內容
    if (state.modeName == 'car') {
      setState(() {
        print(listView);
        urlApi = dotenv.env['News_Car'].toString();
        listCity = choices.city;
        listType = choices.way;

        selectName = '選擇道路';
        selectNameEnglish = 'All';
      });
    } else if (state.modeName == 'scooter') {
      setState(() {
        listCity = choices.city;
        urlApi = dotenv.env['News_Scooter'].toString();
        listType = choices.scooterway;
        selectName = '選擇道路';
        selectNameEnglish = 'All';
      });
    } else {
      setState(() {
        listCity = choices.city_Chiness;
        urlApi = dotenv.env['News_PublicTransport'].toString();
        listType = choices.publicTransport;
        selectName = '選擇類別';
        selectNameEnglish = 'All';
      });
    }
  }

//取得最新消息
  get_News() async {
    print(url_test);

    var url = urlApi.toString() +
        '?areas=' +
        url_test +
        "&types=" +
        selectType.join(',').toString();
    var jwt = ',' + state.accountState;
    try {
      response = await api().Api_Get(url, jwt);
    } catch (e) {
      EasyLoading.showError(e.toString());
    }

    if (response.statusCode == 200) {
      setState(() {
        listView = jsonDecode(utf8.decode(response.bodyBytes));

        EasyLoading.dismiss();
      });
    }
  }

  location() async {
    test = await geolocator().updataPosition();
    placemarks = await placemarkFromCoordinates(test.latitude, test.longitude);

    if ((placemarks.isNotEmpty
            ? placemarks[0].administrativeArea.toString()
            : '') ==
        'Taiwan') {
      setState(() {
        selectCitySubText = font2(text((placemarks.isNotEmpty
            ? placemarks[0].subAdministrativeArea
            : "")!));
        url_test = text((placemarks.isNotEmpty
                ? placemarks[0].subAdministrativeArea
                : "")!)
            .toString();
      });

      print(url_test);
    } else {
      setState(() {
        selectCitySubText = font2(text((placemarks.isNotEmpty
                    ? placemarks[0].administrativeArea.toString()
                    : '')
                .toString()))
            .toString();
        url_test = text((placemarks.isNotEmpty
                ? placemarks[0].administrativeArea.toString()
                : ''))
            .toString();
      });

      print(url_test);
    }
    get_News();
  }

  text(name) {
    try {
      for (var i = 0; i <= choices.city_ios.length; i++) {
        if (choices.city_Chiness[i]['title'] == name) {
          return choices.city_Chiness[i]['value'];
        } else if (choices.city_English[i]['title'] == name) {
          return choices.city_English[i]['value'];
        } else if (choices.city_ios[i]['title'] == name) {
          return choices.city_ios[i]['value'];
        }
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
    }
  }

  font2(name) {
    print(name + '2');
    for (var i = 0; i < choices.city_Chiness.length; i++) {
      if (name == 'Taipei_City') {
        return '臺北市';
      } else if (choices.city_Chiness[i]['value'] == name) {
        print('object');
        return choices.city_Chiness[i]['title'];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            width: 600,
            child: Column(
              children: [
                Row(children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 0),
                      width: 250,
                      height: 65,
                      color: Color.fromARGB(40, 82, 145, 228),
                      child: SmartSelect<String>.multiple(
                        onModalOpen: (state) {
                          setState(() {
                            selectCity = [];
                          });
                        },
                        title: '選擇區域',
                        placeholder: selectCitySubText,
                        selectedValue: selectCity,
                        onChange: (selected) {
                          setState(() {
                            selectCity = selected.value;
                            url_test = selectCity.join(',').toString();
                            print(url_test);
                            EasyLoading.show(status: 'Loading.....');
                            get_News();
                            // _stopTrackingPosition();
                          });
                        },
                        choiceItems:
                            S2Choice.listFrom<String, Map<String, String>>(
                          source: listCity,
                          value: (index, item) => item['value'] ?? '',
                          title: (index, item) => item['title'] ?? '',
                          group: (index, item) => item['body'] ?? '',
                        ),
                        choiceActiveStyle:
                            const S2ChoiceStyle(color: Colors.redAccent),
                        modalType: S2ModalType.bottomSheet,
                        modalConfirm: true,
                        modalFilter: true,
                        groupEnabled: true,
                        groupSortBy: S2GroupSort.byCountInDesc(),
                        groupBuilder: (context, state, group) {
                          return StickyHeader(
                            header: state.groupHeader(group),
                            content: state.groupChoices(group),
                          );
                        },
                        onModalClose: (state, confirmed) {},
                        modalFilterToggleBuilder: (context, value) {
                          return Center(
                            child: Container(
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                      location();
                                      EasyLoading.show(status: 'Loading.....');
                                    },
                                    child: Text(
                                      '目前位置',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color:
                                              const Color.fromARGB(255, 0, 0, 0)),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                 
                                ],
                              ),
                              
                            ),
                          );
                        },
                        
                        groupHeaderBuilder: (context, state, group) {
                          return Container(
                            color: Colors.blue,
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.centerLeft,
                            child: S2Text(
                              text: group.name,
                              highlight: state.filter?.value,
                              highlightColor: Colors.teal,
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        },
                        tileBuilder: (context, state) {
                          return S2Tile.fromState(
                            state,
                            isTwoLine: true,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        width: 300,
                        height: 65,
                        color: Color.fromARGB(40, 82, 145, 228),
                        child: SmartSelect<String>.multiple(
                            onModalOpen: (state) {
                              setState(() {
                                selectType.clear();
                              });
                            },
                            title: selectName,
                            placeholder: selectNameEnglish,
                            selectedValue: selectType,
                            onChange: (selected) {
                              setState(() => {
                                    selectType = selected.value,
                                    EasyLoading.show(status: 'Loading.....'),
                                    get_News(),
                                    // _stopTrackingPosition()
                                  });
                            },
                            choiceItems:
                                S2Choice.listFrom<String, Map<String, String>>(
                              source: listType,
                              value: (index, item) => item['value'] ?? '',
                              title: (index, item) => item['title'] ?? '',
                              group: (index, item) => item['body'] ?? '',
                            ),
                            choiceActiveStyle:
                                const S2ChoiceStyle(color: Colors.redAccent),
                            modalType: S2ModalType.bottomSheet,
                            modalConfirm: true,
                            modalFilter: true,
                            groupEnabled: true,
                            groupSortBy: S2GroupSort.byCountInDesc(),
                            groupBuilder: (context, state, group) {
                              return StickyHeader(
                                header: state.groupHeader(group),
                                content: state.groupChoices(group),
                              );
                            },
                            modalFilterToggleBuilder: (context, value) {
                              return Center(
                                child: Container(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                      EasyLoading.show(status: 'Loading.....');
                                      setState(() {
                                        selectType = ['All'];
                                        print(selectType);
                                        get_News();
                                      });
                                    },
                                    child: Text(
                                      '全選',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: const Color.fromARGB(
                                              255, 0, 0, 0)),
                                    ),
                                  ),
                                ),
                              );
                            },
                            groupHeaderBuilder: (context, state, group) {
                              return Container(
                                color: Colors.blue,
                                padding: const EdgeInsets.all(10),
                                alignment: Alignment.centerLeft,
                                child: S2Text(
                                  text: group.name,
                                  highlight: state.filter?.value,
                                  highlightColor: Colors.teal,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              );
                            },
                            tileBuilder: (context, state) {
                              return S2Tile.fromState(
                                state,
                                isTwoLine: true,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 0),
                              );
                            })),
                  ),
                ]),
                Expanded(child: listview())
              ],
            )),
      ),
    );
  }

  Widget listview() {
    return ListView.builder(
        itemCount: listView.length,
        itemBuilder: (context, index) {
          final news = listView[index];
          return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                leading: Column(
                  children: [
                    Container(
                      child: Image.network(news["logo_url"].toString()),
                      width: 50,
                      height: 50,
                      // fit: BoxFit.cover,
                    )
                  ],
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 1, horizontal: 30),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          news['update_time'].toString(),
                          style: TextStyle(fontSize: 12),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            news['title'].toString(),
                            style: TextStyle(fontSize: 15),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                subtitle: Text(news['news_category'].toString()),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 30,
                ),
                onTap: () {
                  EasyLoading.show(status: 'loading...');
                  if (news['news_url'].toString() != '') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                WebView(tt: news['news_url'].toString())));
                  } else {
                    print(news);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewsCardView(
                                  listView: news,
                                )));
                  }
                },
              ));
        });
  }
}
