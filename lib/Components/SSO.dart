import 'package:traffic_hero/imports.dart';

class SquareTitle extends StatelessWidget {
  final String imagePath;

  const SquareTitle({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(40),
          color: Color.fromARGB(109, 13, 66, 103),
      ),
      
      child: Image.asset(
        imagePath,
        height: 50,
      ),
    );
  }
}
