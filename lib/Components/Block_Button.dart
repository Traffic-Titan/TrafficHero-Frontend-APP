import 'package:traffic_hero/imports.dart';

class block_button extends StatelessWidget {

  final String functionName;

  const block_button({
    super.key,
    required this.functionName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 130),
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(60)),
          child: Text(
            functionName,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ));
  }
}
