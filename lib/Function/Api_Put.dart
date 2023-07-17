// ignore_for_file: camel_case_types, avoid_print, non_constant_identifier_names, file_names
import 'package:traffic_hero/imports.dart';

class apiPut_Function {
  Future<Response> apiPut(
    Body,
    url,
  ) async {
    var api_Url = 'https://c175-106-1-187-119.ngrok-free.app';
    try {
      Response response = await put(Uri.parse(api_Url + url),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode(Body));
      if (response.statusCode == 200) {
        return response;
      } else {
        print(utf8.decode(response.bodyBytes));

        print('failed');
        return response;
      }
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
