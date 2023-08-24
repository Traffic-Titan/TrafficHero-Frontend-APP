// ignore_for_file: camel_case_types, avoid_print, non_constant_identifier_names, file_names, avoid_types_as_parameter_names, prefer_interpolation_to_compose_strings, use_rethrow_when_possible
import 'package:traffic_hero/imports.dart';

class api {
  var apiUrl = dotenv.env['TrafficHero-Backend'].toString();
  var apiJwtHeader = dotenv.env['appToken'].toString();
  Future<Response> Api_Post(
    Body,
    url,
    jwt,
  ) async {
    DateTime startTime = DateTime.now();
    try {
      Response response = await post(Uri.parse(apiUrl + url),
          headers: {
            "Authorization": 'Bearer ' + apiJwtHeader + jwt.toString(),
            "Content-Type": "application/json",
          },
          body: jsonEncode(Body));
      print(await response);
      if (response.statusCode == 200) {
        DateTime endTime = DateTime.now();
        Duration durationInMilliseconds = endTime.difference(startTime);
        print('${durationInMilliseconds.inSeconds}秒');
        return response;
      } else {
        EasyLoading.showError(
            jsonDecode(utf8.decode(response.bodyBytes))['detail'].toString());
        print(utf8.decode(response.bodyBytes));

        return response;
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
      print(e.toString());
      throw e;
    }
  }

  Future<Response> Api_Put(Body, url, jwt) async {
    DateTime startTime = DateTime.now();
    try {
      Response response = await put(Uri.parse(apiUrl + url),
          headers: {
            "Authorization": 'Bearer ' + apiJwtHeader + jwt.toString(),
            "Content-Type": "application/json",
          },
          body: jsonEncode(Body));
      if (response.statusCode == 200) {
        DateTime endTime = DateTime.now();
        Duration durationInMilliseconds = endTime.difference(startTime);
        print('${durationInMilliseconds.inMicroseconds}秒');
        return response;
      } else {
        print(utf8.decode(response.bodyBytes));
        EasyLoading.showError(
            jsonDecode(utf8.decode(response.bodyBytes))['detail'].toString());
        return response;
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
      print(e.toString());
      rethrow;
    }
  }

  Future<Response> Api_Get(
    url,
    jwt,
  ) async {
    DateTime startTime = DateTime.now();

    try {
      Response response =
          await get(Uri.parse(apiUrl + url.toString()), headers: {
        "Authorization": 'Bearer ' + apiJwtHeader + jwt.toString(),
        "Content-Type": "application/json",
      });

      if (response.statusCode == 200) {
        DateTime endTime = DateTime.now();
        Duration durationInMilliseconds = endTime.difference(startTime);
        print('${durationInMilliseconds.inSeconds}秒');
        return response;
      } else {
        EasyLoading.showError(
            jsonDecode(utf8.decode(response.bodyBytes))['detail'].toString());
        print(utf8.decode(response.bodyBytes));

        return response;
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
      print(e.toString());
      throw e;
    }
  }
}
