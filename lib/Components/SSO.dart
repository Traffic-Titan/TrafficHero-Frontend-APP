import 'package:traffic_hero/imports.dart';

class SquareTitle extends StatelessWidget {
  final String imagePath;

  const SquareTitle({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(40),
          color:const Color.fromARGB(255, 255, 255, 255),
      ),
      
      child: Image.asset(
        imagePath,
        height: 50,
      ),
    );
  }
}
