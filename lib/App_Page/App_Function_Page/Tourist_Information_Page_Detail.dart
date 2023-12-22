// ignore_for_file: file_names, camel_case_types, use_super_parameters, prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings

import 'package:traffic_hero/imports.dart';

class Tourist_Information_Page_Detail extends StatefulWidget {
  const Tourist_Information_Page_Detail({Key? key, required this.detail})
      : super(key: key);
  final detail;
  @override
  State<Tourist_Information_Page_Detail> createState() =>
      _Tourist_Information_Page_DetailState();
}

class _Tourist_Information_Page_DetailState
    extends State<Tourist_Information_Page_Detail> {
  late stateManager state;
  var data, mode;
  var screenWidth;
  var screenHeight;
  PageController controller = PageController();

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
    data = widget.detail;
    print(data);
    mode = state.modeName;
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
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
            style: TextStyle(color: Colors.white),
          ),
        ),
        body:
        SingleChildScrollView(child:  Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            
            SizedBox(
              width: screenWidth,
              height: 287,
              child: Expanded(
                child: PageView.builder(
                  controller: controller,
                  itemCount: data['picture'].length,
                  itemBuilder: (context, index) {
                    final picture = data['picture'][index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AspectRatio(
                          // 設定圖片的長寬比
                          aspectRatio: 3 / 2,
                          child: Image.network(
                            picture,
                            height: screenHeight * 0.3,
                            fit: BoxFit.cover, // 修正此行，使用cover保持圖片比例填滿
                          ),
                        ),
                        // 在圖片下方加入一個文字說明，你可以根據需要修改文字內容
                      ],
                    );
                  },
                ),
              ),
            ),
            ListTile(
              title: Text('地址：' + data['address']),
            ),
            const Divider(thickness: 2, color: Colors.grey, indent: 15,endIndent: 15,),
            ListTile(
              title: Text('電話：' + data['phone']),
            ),
            const Divider(thickness: 2, color: Colors.grey, indent: 15,endIndent: 15,),
            const SizedBox(
              height: 10,
            ),
            const ListTile(
              title: Text(
                '詳細介紹',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: SizedBox(
                  width:
                      screenWidth > 600 ? 600 : screenWidth - 30,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(data['description_detail'].toString() == 'null'
                        ? data['description']
                        : data['description_detail']),
                  )),
            ),
            const ListTile(
              title: Text(
                '天氣資訊',
                style: TextStyle(fontSize: 20),
              ),
            ),

            Visibility(
              visible: data['weather'] == null ? false : true,
              child:  ListTile(
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
           
            const SizedBox(height: 30,)
          ],
        ),)
        
        );
  }
}
