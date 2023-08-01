// ignore_for_file: file_names, camel_case_types, prefer_typing_uninitialized_variables
import 'package:traffic_hero/imports.dart';

//主程式
class CarMode extends StatefulWidget {
  const CarMode({super.key});
  @override
  State<CarMode> createState() => _CarMode();
}

class _CarMode extends State<CarMode> {

  @override
  Widget build(BuildContext context) {
    return const PasserbyPage();
  }
}
