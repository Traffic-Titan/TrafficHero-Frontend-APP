
import 'package:traffic_hero/imports.dart';

class Tourist_Information_Page_Detail extends StatefulWidget {

  const Tourist_Information_Page_Detail({Key? key}) : super(key: key);

  @override
  State<Tourist_Information_Page_Detail> createState() => _Tourist_Information_Page_DetailState();

}

class _Tourist_Information_Page_DetailState extends State<Tourist_Information_Page_Detail> {
  late stateManager state;
  var data,mode;
  var screenWidth;
  var screenHeight;
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
    data = state.pageDetail;
    mode = state.modeName;
    screenWidth = MediaQuery. of(context). size. width ;
    screenHeight = MediaQuery. of(context). size. height;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(data['名稱']),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, //水平對齊方式
          children: <Widget>[
            AspectRatio(  //設定圖片的長寬比
              aspectRatio: 3/2,
              child: Image.network(data['圖片'],height: screenHeight*0.3,fit: BoxFit.fill,),
            ),
            Expanded(
              flex: 2,
                child: Align(
                  alignment: Alignment.center,
                  child:
                  TextButton(onPressed: () {
                    if(mode == "publicTransport"){
                      var directURL = 'https://www.google.com/maps/dir/?api=1&destination=${data['名稱']}&travelmode=transit';
                      launch(directURL);
                    }
                    else if(mode == "car"){
                      var directURL = 'https://www.google.com/maps/dir/?api=1&destination=${data['名稱']}&travelmode=driving';
                      launch(directURL);
                    }
                    else if(mode == "scooter"){
                      var directURL = 'https://www.google.com/maps/dir/?api=1&destination=${data['名稱']}&travelmode=motorcycle';
                      launch(directURL);
                    }

                  },
                    child: Text('地址：'+data['地址'],style: TextStyle(fontSize: 15)),),
                ),
            ),
            Expanded(
              flex: 2,
                child: Align(
                  alignment: Alignment.center,
                  child: Text('聯絡電話：'+data['聯絡電話'],style: TextStyle(fontSize: 15)),
                ),
            ),
            Expanded(
              flex: 15,
              child: ListView(children: [Text(data['說明'],style: TextStyle(fontSize: 20))],),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child:Text('超連結：'+data['連結'],style: TextStyle(fontSize: 15)),
              ),
            ),
          ],
        )
    );
  }
}
