
// ignore_for_file: unused_local_variable

import 'package:traffic_hero/Imports.dart';

//高鐵頁面
Widget publicTransportInfoHighway(context){
  var state = Provider.of<stateManager>(context, listen: false);
  var  screenWidth = MediaQuery. of(context). size. width ;
  return Column(
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
        child:Text('1.起訖站查詢',style: TextStyle(color: Color.fromRGBO(29, 73, 153, 1),fontSize: 20),textAlign:TextAlign.left,),
      ),
      Container(
        alignment: Alignment.center,
        child: Row(
          children: [
            //選擇起始地
            TextButton(
              child: Text('起始地',style: TextStyle(color: Color.fromRGBO(29, 73, 153, 1),fontSize: 28),textAlign:TextAlign.center,),
              onPressed: (){},
              style: ButtonStyle(

              ),
            ),
            //交換按鈕
            Icon(Icons.cached,size: 20,),
            //選擇目的地
            TextButton(
              onPressed: (){},
              child: Text('目的地',style: TextStyle(color: Color.fromRGBO(29, 73, 153, 1),fontSize: 28),textAlign:TextAlign.center,),
            ),
          ],
        ),
      ),

    ],
  );
}



