import 'package:traffic_hero/Imports.dart';

class MRT_Taoyuan extends StatefulWidget {
  const MRT_Taoyuan({Key? key}) : super(key: key);

  @override
  State<MRT_Taoyuan> createState() => _MRT_TaoyuanState();
}

class _MRT_TaoyuanState extends State<MRT_Taoyuan> {
  var screenWidth;
  Widget scrollView(ScrollController scrollController) {
    return SizedBox(
        child:ListView(
          controller: scrollController,
          children: [
            //搜尋欄
            ListTile(
                leading: Icon(
                  Icons.search,
                  color: Color.fromRGBO(46, 80, 140, 1),
                  size: 28,
                ),
                title: TextField(
                  decoration: InputDecoration(
                    hintText: '搜尋站點',
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(46, 80, 140, 1),
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                    ),
                    border: InputBorder.none,
                  ),
                  // 將搜尋欄中輸入的字傳到後端做關鍵字搜尋
                  // onChanged: (inputText) async {
                  //   // 若無輸入，則下排保持顯示"請輸入您想搜尋的地點"
                  //   if(inputText.length == 0){
                  //     setState(() {
                  //       searchResult_list=[{"UID":"0","名稱":"請輸入您想搜尋的地點"}];
                  //     });
                  //   }else{
                  //     searchResult(inputText);
                  //   }
                  // },
                  style: TextStyle(
                    backgroundColor: Color.fromRGBO(221, 235, 247, 1),
                    color: Color.fromRGBO(46, 80, 140, 1),
                  ),
                )
            ),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: Container(
                alignment: Alignment.bottomLeft,
                margin: EdgeInsets.only(left: 20,right: 20),
                padding: EdgeInsets.all(5),
                color: Color.fromRGBO(165, 201, 233, 1),
                child: Text('進站動態',style: TextStyle(color: Color.fromRGBO(29, 73, 153, 1),fontSize: 18),textAlign:TextAlign.center,),
              ),
            ),

          ],
        )
    );

    //   },
    // );
  }
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Stack(
        children:[
          WebViewForMRT(
            tt: 'https://tw.piliapp.com/mrt-taiwan/airport/',
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: DraggableScrollableSheet(
              builder: (BuildContext context,
                  ScrollController scrollController) {
                return Container(
                  width: screenWidth > 600
                      ? screenWidth / 4 + 100
                      : screenWidth,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(222, 235, 247, 1),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      SizedBox(
                        width: 30,
                        height: 5,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50)),
                        ),
                      ),
                      SizedBox(height: 14),
                      Expanded(
                        child: scrollView(scrollController),
                      ),
                    ],
                  ),
                );
              },
              expand: false,

              initialChildSize: 0.3, // 初始高度比例
              minChildSize: 0.2, // 最小高度比例
              maxChildSize: 1, // 最大高度比例
            ),
          ),
        ]
    );
  }
}
