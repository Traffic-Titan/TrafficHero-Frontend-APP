// ignore_for_file: sized_box_for_whitespace, avoid_print, file_names, unnecessary_set_literal, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, non_constant_identifier_names, avoid_unnecessary_containers, sort_child_properties_last
import 'package:traffic_hero/Imports.dart';
import 'package:traffic_hero/Components/Choices.dart' as choices;

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  late stateManager state;
  var response;

  late var listView = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    EasyLoading.show(status: 'Loading.....');
    state = Provider.of<stateManager>(context, listen: false);
    get_News();

    //依照模式判斷顯示內容
    if (state.modeName == 'car') {
      setState(() {
        print(listView);
        List_City = choices.city;
        List_2 = choices.way;

        Select_1 = [];
        Select_2 = [];

        select_name = '選擇道路';
        select_name_English = 'Choose Way';
      });
    } else if (state.modeName == 'scooter') {
      setState(() {
        List_City = choices.city;
        List_2 = choices.scooterway;

        Select_1 = [];
        Select_2 = [];
        select_name = '選擇道路';
        select_name_English = 'Choose Way';
      });
    } else {
      setState(() {
        List_City = choices.city;
        List_2 = choices.publicTransport;

        Select_1 = [];
        Select_2 = [];
        select_name = '選擇交通工具';
        select_name_English = 'Choose Public Transport';
      });
    }
  }

  List<String> Select_1 = [];
  List<String> Select_2 = [];
  var List_City;
  var List_2;
  var select_name;
  var select_name_English;
  Color get primaryColor => Theme.of(context).primaryColor;

  get_News() async {
    var url = '/News/MRT';
    var jwt = state.accountState;
    try {
      response = await api().api_Get(url, jwt);
      setState(() {
        listView = jsonDecode(utf8.decode(response.bodyBytes));
      });
    } catch (e) {
      EasyLoading.showError(e.toString());
    }

    if (response.statusCode == 200) {
      listView = jsonDecode(utf8.decode(response.bodyBytes));
      EasyLoading.dismiss();
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
                    child: Container(
                      width: 250,
                      color: Color.fromARGB(40, 82, 145, 228),
                      child: dropdown_select(
                        '選擇城市',
                        "Choose City",
                        Select_1,
                        List_City,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 300,
                      color: Color.fromARGB(40, 82, 145, 228),
                      child: dropdown_select(
                        select_name,
                        select_name_English,
                        Select_2,
                        List_2,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                          width: 80,
                          height: 73,
                          color: Color.fromARGB(40, 82, 145, 228),
                          child: InkWell(
                            child: Center(
                                child: SizedBox(
                              width: 20,
                              child: Text('清除'),
                            )),
                            onTap: () {
                              get_News();
                              EasyLoading.show(status: 'Loading.....');
                              setState(() {
                                Select_1 = [];
                                Select_2 = [];
                              });
                            },
                          )),
                    ],
                  ),
                ]),
                Expanded(
                    child: ListView.builder(
                        itemCount: listView?.length,
                        itemBuilder: (context, index) {
                          final news = listView[index];
                          return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ListTile(
                                leading: Column(
                                  children: [
                                    Container(
                                      child: Image.network(
                                          'https://upload.wikimedia.org/wikipedia/zh/thumb/d/d1/Taipei_Metro_Logo.svg/1200px-Taipei_Metro_Logo.svg.png'),
                                      width: 50,
                                      height: 50,
                                      // fit: BoxFit.cover,
                                    )
                                  ],
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 1, horizontal: 30),
                                title: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          news['UpdateTime'].toString(),
                                          style: TextStyle(fontSize: 10),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            news['Title'].toString(),
                                            style: TextStyle(fontSize: 15),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                subtitle: Text(news['NewsCategory'].toString()),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 30,
                                ),
                                onTap: () {
                                  EasyLoading.show(status: 'loading...');
                                  if (news['NewsURL'].toString() != '') {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                WebViewExample(
                                                    tt: news['NewsURL']
                                                        .toString())));
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => NewsCardView(
                                                  list_view: news,
                                                )));
                                  }
                                },
                              ));
                        }))
              ],
            )),
      ),
    );
  }

  Widget dropdown_select(
      select_name, select_name_English, select_Value, list_value) {
    return SmartSelect<String>.multiple(
        title: select_name,
        placeholder: select_name_English,
        selectedValue: select_Value,
        onChange: (selected) {
          setState(() => {
                select_Value = selected.value,
                EasyLoading.show(status: 'Loading.....'),
                get_News(),
                print(listView)
              });
        },
        choiceItems: S2Choice.listFrom<String, Map<String, String>>(
          source: list_value,
          value: (index, item) => item['value'] ?? '',
          title: (index, item) => item['title'] ?? '',
          group: (index, item) => item['body'] ?? '',
        ),
        choiceActiveStyle: const S2ChoiceStyle(color: Colors.redAccent),
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
        groupHeaderBuilder: (context, state, group) {
          return Container(
            color: primaryColor,
            padding: const EdgeInsets.all(15),
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
          );
        });
  }
}
