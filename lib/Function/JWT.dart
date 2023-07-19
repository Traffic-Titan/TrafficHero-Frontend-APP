// ignore_for_file: camel_case_types, avoid_print, non_constant_identifier_names, void_checks, file_names
import 'package:traffic_hero/imports.dart';

class jwt {
  JWT jwtdecode (token){
     
    return JWT.decode(token);
  }
}