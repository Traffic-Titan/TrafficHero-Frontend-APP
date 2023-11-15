import 'package:traffic_hero/App_Page/App_Function_Page/Public_Transport_Information_Page/THSR_CarNumSearchResult.dart';
import 'package:traffic_hero/App_Page/App_Function_Page/Public_Transport_Information_Page/THSR_StartEndStationSearch_Result.dart';
import 'package:traffic_hero/Imports.dart';
class THSR_CarNumSearch extends StatefulWidget {
  const THSR_CarNumSearch({Key? key}) : super(key: key);

  @override
  State<THSR_CarNumSearch> createState() => _THSR_CarNumSearchState();
}
var carNum;

class _THSR_CarNumSearchState extends State<THSR_CarNumSearch> {

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<stateManager>(context, listen: false);
    var  screenWidth = MediaQuery. of(context). size. width ;
    return Scaffold(
        backgroundColor: Color.fromRGBO(221, 235, 247, 1),
        body: Column(
          children: [
            SizedBox(height: 10,),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(14)),
              child: Container(
                width: screenWidth - 30 > 600 ? 600 : screenWidth - 30,
                color: Color.fromRGBO(165, 201, 233, 1),
                child: Text('查詢條件(條件擇一即可)',style: TextStyle(color: Color.fromRGBO(29, 73, 153, 1),fontSize: 25),textAlign:TextAlign.center,),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child:Text('2.車次查詢',style: TextStyle(color: Color.fromRGBO(29, 73, 153, 1),fontSize: 20),textAlign:TextAlign.left,),
            ),
            SizedBox(height: 10,),

            //輸入車次框
            Container(
                width: screenWidth - 30 > 600 ? 600 : screenWidth - 30,
                height: 60,
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    fillColor: Color.fromRGBO(221, 235, 247, 1),
                    hintText: "輸入車次",
                    hintStyle: TextStyle(color: Color.fromRGBO(24, 60, 126, 1),fontSize: 20),
                    filled: true,
                    enabledBorder:  OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color:  Color.fromRGBO(24, 60, 126, 1)),
                    ),

                  ),
                  onChanged: (text){
                    carNum = text;
                  },
                )
            ),
            TextButton(
                onPressed: () async {
                  var url = dotenv.env['THSR_SearchBy_EachCar'].toString() +
                      '?CarNo=${carNum}';
                  var jwt = ',' + state.accountState.toString();
                  print(url);
                  var response = await api().apiGet(url, jwt);
                  if (response.statusCode == 200) {
                    print(jsonDecode(utf8.decode(response.bodyBytes)));
                    setState(() {
                      state.updateTHSR_CarNumSearch_CarNum(carNum);
                      state.updateTHSR_CarNumSearchResult(jsonDecode(utf8.decode(response.bodyBytes)));
                    });
                    Future.delayed(Duration(seconds: 1),(){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => THSR_CarNumSearchResult()));
                    });
                  }
                },
                child: Text("搜尋")
            )
          ],
        ),
    );
  }
}
