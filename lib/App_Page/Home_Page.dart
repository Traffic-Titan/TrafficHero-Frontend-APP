// ignore_for_file: file_names
import 'package:flutter/material.dart' show BuildContext, Container, Key, SingleChildScrollView, StatelessWidget, Widget;
import 'package:provider/provider.dart';
import '../Mode_State.dart';


class Home extends StatelessWidget {
  const Home({Key? key,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
   // ignore: unused_local_variable
   String state = Provider.of<mode_state>(context).modeName;
   return Container(
        child : const SingleChildScrollView(
          
        ));
  }
}