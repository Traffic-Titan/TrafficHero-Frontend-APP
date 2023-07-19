// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, non_constant_identifier_names, file_names, sized_box_for_whitespace
import 'package:traffic_hero/imports.dart';

class Textfield_password extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscurText;
  final bool error_status;
  final String error_text;
  final Function()? onTap;

  const Textfield_password({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscurText,
    required this.error_status,
    required this.error_text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 310,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: TextField(
          controller: controller,
          obscureText: obscurText,
          style: const TextStyle(height: 1, color: Colors.black),
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: onTap,
              child: Icon(
                obscurText
                    ? Icons.visibility_off_rounded
                    : Icons.visibility_rounded,
                size: 24,
              ),
            ),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.all(Radius.circular(50))),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(50))),
            fillColor: Colors.white,
            filled: true,
            hintText: hintText,
            errorText: error_status ? null : error_text,
            errorStyle: const TextStyle(color: Colors.white, fontSize: 15),
            errorMaxLines: 2,
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
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
