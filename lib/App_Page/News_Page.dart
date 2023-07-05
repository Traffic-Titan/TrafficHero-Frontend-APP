import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Mode_State.dart';

class News extends StatelessWidget {
  const News({super.key});

  @override
  Widget build(BuildContext context) {
   // ignore: unused_local_variable
   String state = Provider.of<mode_state>(context).modeName;
    return const Placeholder();
  }
}