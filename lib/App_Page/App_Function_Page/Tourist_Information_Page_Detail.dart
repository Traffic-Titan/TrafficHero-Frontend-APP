// ignore_for_file: file_names, camel_case_types, use_super_parameters, prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings, avoid_print

// 記得導入這個套件
import 'package:traffic_hero/imports.dart';

class TouristInformationPageDetail extends StatefulWidget {
  const TouristInformationPageDetail({Key? key, required this.detail})
      : super(key: key);
  final detail;

  @override
  State<TouristInformationPageDetail> createState() =>
      _TouristInformationPageDetailState();
}

class _TouristInformationPageDetailState
    extends State<TouristInformationPageDetail> {
  late stateManager state;
  late var data; // 增加 'late' 關鍵字
  late var mode;
  late double screenWidth; // 修正成 double 型態
  late double screenHeight; // 修正成 double 型態
  late PageController controller;

  @override
  void initState() {
    super.initState();
     // 在 initState 中初始化 controller
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
    data = widget.detail;
    mode = state.modeName;
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    controller = PageController();
  }

  @override
  void dispose() {
    controller.dispose(); // 在 dispose 中釋放 controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(62, 111, 179, 1),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        title: Text(
          data['name'],
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: screenWidth,
              height: 287,
              child: PageView.builder(
                controller: controller,
                itemCount: data['picture'].length,
                itemBuilder: (context, index) {
                  final picture = data['picture'][index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AspectRatio(
                        aspectRatio: 3 / 2,
                        child: Image.network(
                          picture,
                          height: screenHeight * 0.3,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            ListTile(
              title: Text('地址：' + data['address']),
            ),
            const Divider(
                thickness: 2, color: Colors.grey, indent: 15, endIndent: 15),
            ListTile(
              title: Text('電話：' + data['phone']),
            ),
            const Divider(
                thickness: 2, color: Colors.grey, indent: 15, endIndent: 15),
            const SizedBox(height: 10),
            const ListTile(
              title: Text(
                '詳細介紹',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 3),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: SizedBox(
                width: screenWidth > 600 ? 600 : screenWidth - 30,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(data['description_detail'].toString() == 'null'
                      ? data['description']
                      : data['description_detail']),
                ),
              ),
            ),
            const ListTile(
              title: Text(
                '天氣資訊',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Visibility(
              visible: data['weather'] == null ? false : true,
              child: ListTile(
                leading: Image.network(data['weather']['weather_icon_url']),
                title: Text(
                  '目前溫度：${data['weather']['temperature']}',
                  style: const TextStyle(fontSize: 20),
                ),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('今天最低溫：${data['weather']['the_lowest_temperature']}'),
                    Text('今天最高溫：${data['weather']['the_highest_temperature']}')
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
