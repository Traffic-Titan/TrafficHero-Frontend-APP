// ignore_for_file: file_names, camel_case_types, use_super_parameters, prefer_typing_uninitialized_variables, unnecessary_brace_in_string_interps, avoid_print

import 'package:traffic_hero/Imports.dart';
class THSR_CarNumSearch extends StatefulWidget {
  const THSR_CarNumSearch({Key? key}) : super(key: key);

  @override
  State<THSR_CarNumSearch> createState() => _THSR_CarNumSearchState();
}
var carNum;
var state;

class _THSR_CarNumSearchState extends State<THSR_CarNumSearch> {

  @override
  Widget build(BuildContext context) {
    state = Provider.of<stateManager>(context, listen: false);
    var  screenWidth = MediaQuery. of(context). size. width ;

    //根據車次搜尋
    getStationList() async{
      var url = '${dotenv.env['THSR_SearchBy_EachCar']}?CarNo=${carNum}';
      var jwt = ',${state.accountState}';
      print(url);
      var response = await api().apiGet(url, jwt);
      if (response.statusCode == 200) {
        print(jsonDecode(utf8.decode(response.bodyBytes)));
        setState(() {
          state.updateTHSR_CarNumSearch_CarNum(carNum);
          state.updateTHSR_CarNumSearchResult(jsonDecode(utf8.decode(response.bodyBytes)));
        });
        Future.delayed(const Duration(seconds: 1),(){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const THSR_CarNumSearchResult()));
        });
      }
    }
    return Scaffold(
        backgroundColor: const Color.fromRGBO(221, 235, 247, 1),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10,top: 10),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(165, 201, 233, 1),
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                ),
                width: screenWidth - 30 > 600 ? 600 : screenWidth - 30,
                child: const Text('車次查詢',style: TextStyle(color: Color.fromRGBO(29, 73, 153, 1),fontSize: 25),textAlign:TextAlign.center,),
              ),
              //輸入車次框
              Container(
                  width: screenWidth - 30 > 600 ? 600 : screenWidth - 30,
                  height: 60,
                  alignment: Alignment.center,
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
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
              Container(
                  margin: const EdgeInsets.only(top: 20),
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(24, 60, 126, 1),
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                  ),
                  width: screenWidth - 30 > 600 ? 600 : screenWidth - 30,
                  child: TextButton(
                    onPressed: () async {
                      await getStationList();
                    },
                    child: const Text('搜尋',style: TextStyle(color: Colors.white,fontSize: 20),),
                  )
              ),
            ],
          ),
        )
    );
  }
}
