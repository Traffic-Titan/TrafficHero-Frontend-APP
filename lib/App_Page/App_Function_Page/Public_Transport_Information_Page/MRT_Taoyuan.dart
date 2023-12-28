// ignore_for_file: file_names, camel_case_types, use_super_parameters, prefer_typing_uninitialized_variables

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
            const ListTile(
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
                  style: TextStyle(
                    backgroundColor: Color.fromRGBO(221, 235, 247, 1),
                    color: Color.fromRGBO(46, 80, 140, 1),
                  ),
                )
            ),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              child: Container(
                alignment: Alignment.bottomLeft,
                margin: const EdgeInsets.only(left: 20,right: 20),
                padding: const EdgeInsets.all(5),
                color: const Color.fromRGBO(165, 201, 233, 1),
                child: const Text('進站動態',style: TextStyle(color: Color.fromRGBO(29, 73, 153, 1),fontSize: 18),textAlign:TextAlign.center,),
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
    return const Stack(
        children:[
          WebViewForMRT(
            tt: 'https://tw.piliapp.com/mrt-taiwan/airport/',
          ),
        ]
    );
  }
}
