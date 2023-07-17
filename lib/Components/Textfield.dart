// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, file_names, avoid_unnecessary_containers

import 'package:traffic_hero/imports.dart';




class MyTextfield extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscurText;
  final bool error_status;
  final String error_text;

  

  const MyTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscurText,
    required this.error_status,
    required this.error_text,


  });



  @override
  Widget build(BuildContext context) {
    return 
    Container(
      width: 600,
      child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60.0),
      child: TextField(
        
        controller: controller,
        obscureText: obscurText,
        
        style: const TextStyle(height: 1, color: Colors.black),
        decoration: InputDecoration(
          enabledBorder:  const OutlineInputBorder(
              borderSide:  BorderSide(color: Colors.white,),
              borderRadius:  BorderRadius.all(Radius.circular(50))),
          focusedBorder:  const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius:  BorderRadius.all(Radius.circular(50))),
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          errorText: error_status ? null : error_text,
            errorStyle: const TextStyle(color: Colors.white,fontSize: 15),
            errorMaxLines: 2,
            errorBorder: OutlineInputBorder(
              borderSide:const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(50),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(50),
            ),
          
        ),
      ),
    ),
    ); 
    
  }
}
