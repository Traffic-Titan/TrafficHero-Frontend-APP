// ignore_for_file: camel_case_types, file_names

import 'package:traffic_hero/imports.dart';

class button extends StatelessWidget {

  final String functionName;

  const button({
    super.key,
    required this.functionName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          width: 310,
          height: 55,
          padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 17),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255), borderRadius: BorderRadius.circular(60)),
          child: Text(
            functionName,
            style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 16),
          ),
        ));
  }
}
