import 'package:traffic_hero/Imports.dart';

class MRT_DanhaiLRT extends StatefulWidget {
  const MRT_DanhaiLRT({Key? key}) : super(key: key);

  @override
  State<MRT_DanhaiLRT> createState() => _MRT_DanhaiLRTState();
}
var screenWidth;

class _MRT_DanhaiLRTState extends State<MRT_DanhaiLRT> {
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Stack(
        children:[
          WebViewForMRT(
            tt: 'https://tw.piliapp.com/mrt-taiwan/danhai/',
          ),
          // Align(
          //   alignment: Alignment.bottomLeft,
          //   child: DraggableScrollableSheet(
          //     builder: (BuildContext context,
          //         ScrollController scrollController) {
          //       return Container(
          //         width: screenWidth > 600
          //             ? screenWidth / 4 + 100
          //             : screenWidth,
          //         decoration: const BoxDecoration(
          //           color: Color.fromRGBO(222, 235, 247, 1),
          //         ),
          //         child: Column(
          //           children: [
          //             SizedBox(height: 10),
          //             SizedBox(
          //               width: 30,
          //               height: 5,
          //               child: Container(
          //                 decoration: BoxDecoration(
          //                     color: Colors.white,
          //                     borderRadius: BorderRadius.circular(50)),
          //               ),
          //             ),
          //             SizedBox(height: 14),
          //
          //           ],
          //         ),
          //       );
          //     },
          //     expand: false,
          //
          //     initialChildSize: 0.3, // 初始高度比例
          //     minChildSize: 0.2, // 最小高度比例
          //     maxChildSize: 1, // 最大高度比例
          //   ),
          // ),
        ]
    );
  }
}
