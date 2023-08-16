// ignore_for_file: camel_case_types, avoid_print, non_constant_identifier_names, file_names, avoid_types_as_parameter_names, prefer_interpolation_to_compose_strings, use_rethrow_when_possible
import 'package:traffic_hero/imports.dart';

class api {
  var api_Url = dotenv.env['TrafficHero-Backend'].toString();
  var api_jwt_header = dotenv.env['appToken'].toString();
  Future<Response> Api_Post(
    Body,
    url,
    jwt,
  ) async {
    try {
      Response response = await post(Uri.parse(api_Url + url),
      // dotenv.env['appToken'].toString()  +
          headers: {
            "Authorization": 'Bearer ' + api_jwt_header + jwt.toString(),
            "Content-Type": "application/json",
          },
          body: jsonEncode(Body));
      if (response.statusCode == 200) {
        return response;
      } else {
        EasyLoading.showError(jsonDecode(utf8.decode(response.bodyBytes))['detail']
                  .toString());
        print(utf8.decode(response.bodyBytes));

        print('failed');
        return response;
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
      print(e.toString());
      throw e;
    }
  }

  Future<Response> Api_Put(Body, url, jwt) async {
    // var api_Url = dotenv.env['TrafficHero-Backend'].toString();
    try {
      Response response = await put(Uri.parse(api_Url + url),
          headers: {
            "Authorization": 'Bearer ' + api_jwt_header + jwt.toString(),
            "Content-Type": "application/json",
          },
          body: jsonEncode(Body));
      if (response.statusCode == 200) {
        return response;
      } else {
        print(utf8.decode(response.bodyBytes));
        EasyLoading.showError(jsonDecode(utf8.decode(response.bodyBytes))['detail']
                  .toString());
        return response;
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
      print(e.toString());
      rethrow;
    }
  }

  Future<Response> api_Get(
    url,
    jwt,
  ) async {
    try {
      Response response = await get(
        Uri.parse(api_Url + url),
        headers: {
          "Authorization": 'Bearer ' + api_jwt_header + jwt.toString(),
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        return response;
      } else {
        print(utf8.decode(response.bodyBytes));
        EasyLoading.showError(jsonDecode(utf8.decode(response.bodyBytes))['detail']
                  .toString());
        print('failed');
        return response;
      }
    } catch (e) {
      print(e.toString());
      EasyLoading.showError(e.toString());
      rethrow;
    }
  }
}
