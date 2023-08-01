// ignore_for_file: file_names, camel_case_types, prefer_typing_uninitialized_variables
import 'package:traffic_hero/Imports.dart';

//主程式
class PublicTransportMode extends StatefulWidget {
  const PublicTransportMode({super.key});

  @override
  State<PublicTransportMode> createState() => _PublicTransportMode();
}

class _PublicTransportMode extends State<PublicTransportMode> {

 @override
  Widget build(BuildContext context) {
    return const PasserbyPage();
  
  }
}

