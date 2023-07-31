// ignore_for_file: file_names, avoid_unnecessary_containers
// import 'dart:html';

import 'package:traffic_hero/imports.dart';
import 'package:traffic_hero/Components/choices.dart' as choices;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}


class _Home extends State<Home>{
  late stateManager state;
  late String display1,display2;
  void didChangeDependencies() {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);

    //依照模式判斷顯示內容
    if (state.modeName == 'car') {
      setState(() {
        display1 = "工具列";
        display2 = "路況速報";
      });
    } else if (state.modeName == 'scooter') {
      setState(() {
        display1 = "工具列";
        display2 = "路況速報";
      });
    } else {
      setState(() {
        display1 = "附近站點";
        display2 = "營運狀況";
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15,right: 15),
      child: Column(
        children: [
           Row(
              children: [
                SizedBox(height: 15,),
                Text('23°', style: TextStyle(
                  fontSize: 80, color: Color.fromRGBO(46, 117, 182, 1),),),
                //今日溫度
                Text('雲林縣斗六市', style: TextStyle(
                  fontSize: 20, color: Color.fromRGBO(46, 117, 182, 1),)),
              ],
           ),
          Expanded(//工具列
            child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              color: Color.fromRGBO(47, 125, 195, 1),
              child: Text(display1, textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.white),),
            ),
            flex: 0,
          ),
          Expanded(
            child:Container(
              color: Color.fromRGBO(221, 235, 247, 1),
              padding: EdgeInsets.only(top: 8,left: 8),
              child:Row(
                  children:[
                    InkWell(
                        child: Column(
                          children: [
                            Container(
                                width: 70,
                                margin: EdgeInsets.all(3.0),
                                child: Image.asset("assets/home/parkinglot.png")
                            ),
                            Text('路邊停車費',textAlign: TextAlign.center,)
                          ],
                        ),
                        onTap: () {
                          print("路邊停車費");
                        }
                    ),
                  ]
              ),
            ),
            flex: 2,
          ),
          Expanded(//快速尋找地點
            child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              color: Color.fromRGBO(47, 125, 195, 1),
              child: Text("快速尋找地點", textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.white),),
            ),
            flex: 0,
          ),
          Expanded(
            child:Container(
              color: Color.fromRGBO(221, 235, 247, 1),
              padding: EdgeInsets.only(top: 8,left: 8),
              margin: EdgeInsets.only(bottom: 15),
              child:Row(
                  children:[
                    InkWell(
                        child: Column(
                          children: [
                            Container(
                                width: 70,
                                margin: EdgeInsets.all(3.0),
                                child: Image.asset("assets/home/gaspump.png")
                            ),
                            Text('加油站',textAlign: TextAlign.center,)
                          ],
                        ),
                        onTap: () {
                          print("加油站");
                        }
                    ),
                    InkWell(
                        child: Column(
                          children: [
                            Container(
                                width: 70,
                                margin: EdgeInsets.all(3.0),
                                child:Image.asset("assets/home/batterystop.png")
                            ),
                            Text('換電站',textAlign: TextAlign.center,)
                          ],
                        ),
                        onTap: () {
                          print("換電站");
                        }
                    ),
                    InkWell(
                        child: Column(
                          children: [
                            Container(
                                width: 70,
                                margin: EdgeInsets.all(3.0),
                                child:Image.asset("assets/home/convientStore.png")
                            ),
                            Text('便利商店',textAlign: TextAlign.center,)
                          ],
                        ),
                        onTap: () {
                          print("便利商店");
                        }
                    ),
                  ]
              ),
            ),
            flex: 2,
          ),
          Expanded(//路況速報
            child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              color: Color.fromRGBO(47, 125, 195, 1),
              child: Text(display2, textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.white),),
            ),
            flex: 0,
          ),
          Expanded(//路況速報內容
            child:Container(
              color: Color.fromRGBO(221, 235, 247, 1),
              padding: EdgeInsets.only(top: 8,left: 8),
              margin: EdgeInsets.only(bottom: 15),
              child:Row(
                  children:[
                    Image.asset("assets/roadSign_icon/countyRoad/countyRoad_7.png",height: 80,),
                    Expanded(child:Text("台7線84K+100上邊坡刷坡工程",style: TextStyle(fontSize: 35),softWrap: true,),),
                  ]
              ),
            ),
            flex: 5,
          ),
        ],
      ),
      );
  }
}


// Expanded(//附近站點內容
//   child: Container(
//       margin: EdgeInsets.only(bottom: 10),
//       color: Color.fromRGBO(221, 235, 247, 1),
//       width: MediaQuery
//           .of(context)
//           .size
//           .width,
//       child: ListView.builder(
//         itemCount: stationList.length,
//         itemBuilder: (context, index) {
//           final stationNews = stationList[index];
//           return ListTile(
//             leading: Container(
//               padding: EdgeInsets.all(5.0),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: new Border.all(
//                     color: Color.fromRGBO(29, 73, 153, 1)),
//                 borderRadius: new BorderRadius.circular(5),
//               ),
//               child: Text(
//                 '${stationNews["time"].toString()}分',
//                 style: TextStyle(fontSize: 30),),
//             ),
//             title: Text('${stationNews["id"].toString()}',
//               style: TextStyle(
//                   fontSize: 20, color: Colors.red),),
//             subtitle: Text(
//               '往${stationNews["station"].toString()}',
//               style: TextStyle(fontSize: 20,
//                   color: Color.fromRGBO(29, 73, 153, 1)),),
//           );
//         },
//       )
//   ),
//   flex: 5,
// ),
// Expanded(//營運情況
//   child: Container(
//     width: MediaQuery
//         .of(context)
//         .size
//         .width,
//     color: Color.fromRGBO(47, 125, 195, 1),
//     child: Text("營運情況", textAlign: TextAlign.center,
//       style: TextStyle(fontSize: 20, color: Colors.white),),
//   ),
//   flex: 0,
// ),
// Expanded(//營運情況內容
//   child: Container(
//     color: Color.fromRGBO(221, 235, 247, 1),
//     width: MediaQuery
//         .of(context)
//         .size
//         .width,
//     padding: EdgeInsets.only(top: 20),
//     child: GridView(
//       scrollDirection: Axis.horizontal,
//       gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//           maxCrossAxisExtent: 200,
//           childAspectRatio: 3 / 2,
//           mainAxisSpacing: 20
//       ),
//       children: List.generate(operationList.length, (index) {
//         final operationNews =operationList[index];
//         return Column(
//           children: [
//             Image.asset(operationNews["state"].toString(),height: 30,),
//             Text(operationNews["type"].toString(),style: TextStyle(fontSize: 20),),
//           ],
//         );
//       },
//       ),
//     ),
//   ),
//   flex: 2,
// ),
// Expanded(//營運情況
//   child: Container(
//       margin: EdgeInsets.only(bottom: 10),
//       padding: EdgeInsets.all(8),
//       width: MediaQuery
//           .of(context)
//           .size
//           .width,
//       color: Color.fromRGBO(193, 219, 241, 1),
//       child: Row(
//         children: [
//           Image.asset("assets/home/light_normal.png",height: 15,),
//           Text("正常行駛  ",style: TextStyle(color: Color.fromRGBO(0, 32, 96, 1)),),
//           Image.asset("assets/home/light_partialAdnormal.png",height: 15),
//           Text("部分行駛  ",style: TextStyle(color: Color.fromRGBO(0, 32, 96, 1)),),
//           Image.asset("assets/home/light_abnormal.png",height: 15,),
//           Text("全部行駛",style: TextStyle(color: Color.fromRGBO(0, 32, 96, 1)),),
//         ],
//       )
//   ),
//   flex: 0,
// ),