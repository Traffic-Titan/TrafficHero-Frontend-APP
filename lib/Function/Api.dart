// ignore_for_file: camel_case_types, avoid_print, non_constant_identifier_names, file_names, avoid_types_as_parameter_names, prefer_interpolation_to_compose_strings
import 'package:traffic_hero/imports.dart';

class api {
  var api_Url = dotenv.env['TrafficHero-Backend'].toString() + '/APP';

  Future<Response> Api_Post(
    Body,
    url,
    jwt,
  ) async {
    // var api_Url = dotenv.env['TrafficHero-Backend'].toString();
    try {
      Response response = await post(Uri.parse(api_Url + url),
          headers: {
            "Authorization": 'Bearer ' + jwt.toString(),
            "Content-Type": "application/json",
          },
          body: jsonEncode(Body));
      if (response.statusCode == 200) {
        return response;
      } else {
        EasyLoading.showError('伺服器沒有連線');
        print(utf8.decode(response.bodyBytes));

        print('failed');
        return response;
      }
    } catch (e) {
      EasyLoading.showError('伺服器連線失敗');
      print(e.toString());
      rethrow;
    }
  }

  Future<Response> Api_Put(Body, url, jwt) async {
    // var api_Url = dotenv.env['TrafficHero-Backend'].toString();
    try {
      Response response = await put(Uri.parse(api_Url + url),
          headers: {
            "Authorization": 'Bearer ' + jwt.toString(),
            "Content-Type": "application/json",
          },
          body: jsonEncode(Body));
      if (response.statusCode == 200) {
        return response;
      } else {
        print(utf8.decode(response.bodyBytes));
        EasyLoading.showError('伺服器沒有連線');
        print('failed');
        return response;
      }
    } catch (e) {
      EasyLoading.showError('伺服器連線失敗');
      print(e.toString());
      rethrow;
    }
  }

  Future<Response> api_Get(
    url,
    jwt,
  ) async {
    // var api_Url = dotenv.env['TrafficHero-Backend'].toString();
    try {
      Response response = await get(
        Uri.parse(api_Url + url),
        headers: {
          "Authorization": 'Bearer ' + jwt.toString(),
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        return response;
      } else {
        print(utf8.decode(response.bodyBytes));
        EasyLoading.showError('伺服器沒有連線');
        print('failed');
        return response;
      }
    } catch (e) {
      print(e.toString());
      EasyLoading.showError('伺服器連線失敗');
      rethrow;
    }
  }
}
