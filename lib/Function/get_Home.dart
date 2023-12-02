import 'package:traffic_hero/Imports.dart';

class getHome {
  late stateManager state;
  late SharedPreferences prefs;

  gethome(context) async {
    prefs = await SharedPreferences.getInstance();
    state = Provider.of<stateManager>(context, listen: false);
    await getWeather(context);
    await getUser(context);
    await getOperationalStatus(context);
    await stationNearbySearchBus(context);
    await stationNearbySearchBike(context);
    await stationNearbySearchTrain(context);
  }

//抓取資料
  getOperationalStatus(context) async {
    prefs = await SharedPreferences.getInstance();
    state = Provider.of<stateManager>(context, listen: false);
    print('營運狀況開始抓取');
    var position = await geolocator().updataPosition(context);
    var url =
        '${dotenv.env['OperationalStatus']}?longitude=${position.longitude}&latitude=${position.latitude}';
    var jwt = ',${prefs.get('userToken')}';

    var response = await api().apiGet(url, jwt);
    print(jsonDecode(utf8.decode(response.bodyBytes)));
    if (response.statusCode == 200) {
      state
          .updateOperationalStatus(jsonDecode(utf8.decode(response.bodyBytes)));
      print('營運狀況抓取成功');
    } else {
      print(jsonDecode(utf8.decode(response.bodyBytes)));
      print('營運狀況抓取失敗');
    }
  }

  getWeather(context) async {
    prefs = await SharedPreferences.getInstance();
    state = Provider.of<stateManager>(context, listen: false);
    print('天氣資訊開始抓取');
    var position = await geolocator().updataPosition(context);
    var response;
    var url = dotenv.env['Weather'].toString() +
        '?longitude=${position.longitude}&latitude=${position.latitude}';
    var jwt = ',${prefs.get('userToken')}';
    print(jwt);
    try {
      response = await api().apiGet(url, jwt);
    } catch (e) {
      print(e);
      print('天氣資訊抓取失敗');
    }

    try {
      if (response.statusCode == 200) {
        state.updateWeatherState(jsonDecode(utf8.decode(response.bodyBytes)));
        print('天氣資訊資料' + state.weather.toString());
        print('天氣資訊抓取成功');
      } else {
        print(jsonDecode(utf8.decode(response.bodyBytes)));
        print('天氣資訊抓取失敗');
      }
    } catch (e) {
      print(e);
      print('天氣資訊抓取失敗');
    }
  }

  getUser(context) async {
    prefs = await SharedPreferences.getInstance();
    state = Provider.of<stateManager>(context, listen: false);
    print('會員資料開始抓取');
    var response;
    var url = dotenv.env['Profile'];
    var jwt = ',${prefs.get('userToken')}';
    print(jwt);
    try {
      response = await api().apiGet(url, jwt);
    } catch (e) {
      print(e);
      print('會員資料抓取失敗');
    }

    if (response.statusCode == 200) {
      state.updateprofileState(jsonDecode(utf8.decode(response.bodyBytes)));
      print(state.profile);
      print('會員資料抓取成功');
    } else {
      print(jsonDecode(utf8.decode(response.bodyBytes)));
      print('會員資料抓取失敗');
    }
  }

  // 取得附近站點資訊
  stationNearbySearchBus(context) async {
    prefs = await SharedPreferences.getInstance();
    state = Provider.of<stateManager>(context, listen: false);
    print('附近站點公車開始抓取');
    var jwt = ',${prefs.get('userToken')}';
    var position = await geolocator().updataPosition(context);
    var url =
        '${dotenv.env['StationNearbyBus']}?latitude=${position.latitude}&longitude=${position.longitude}';
    var response;
    try {
      response = await api().apiGet(url, jwt);
    } catch (e) {
      print(e);
      print('附近站點公車抓取失敗');
    }
    var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      print(responseBody);
      if (responseBody != []) {
        state.updateNearbyStationBus(responseBody);
        print('附近站點公車抓取成功');
      }
    } else {
      print('附近站點公車抓取失敗');
    }
  }

  stationNearbySearchTrain(context) async {
    prefs = await SharedPreferences.getInstance();
    state = Provider.of<stateManager>(context, listen: false);
    print('附近站點台鐵開始抓取');
    var jwt = ',${prefs.get('userToken')}';
    var position = await geolocator().updataPosition(context);
    var url =
        '${dotenv.env['StationNearbyTrain']}?latitude=${position.latitude}&longitude=${position.longitude}';
    var response;
    try {
      response = await api().apiGet(url, jwt);
    } catch (e) {
      print(e);
      print('附近站點台鐵抓取失敗');
    }
    var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      print(responseBody);
      state.updateNearbyStationTrain(responseBody);
      print('附近站點台鐵抓取成功');
    } else {
      print('附近站點台鐵抓取失敗');
    }
  }

  stationNearbySearchBike(context) async {
    prefs = await SharedPreferences.getInstance();
    state = Provider.of<stateManager>(context, listen: false);
    print('附近站點公共自行車開始抓取');
    var jwt = ',${prefs.get('userToken')}';
    var position = await geolocator().updataPosition(context);
    var url =
        '${dotenv.env['StationNearbyBike']}?os=${prefs.get('system')}&latitude=${position.latitude}&longitude=${position.longitude}';
    var response;
    try {
      response = await api().apiGet(url, jwt);
    } catch (e) {
      print(e);
      print('附近站點公共自行車抓取失敗');
    }
    try {
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        print(responseBody);
        state.updateNearbyStationBike(responseBody);
        print('附近站點公共自行車抓取成功');
        return responseBody;
      } else {
        print('附近站點公共自行車抓取失敗');
      }
    } catch (e) {
      print(e);
    }
  }

  getNearbyRoadCondition(context) async {
    prefs = await SharedPreferences.getInstance();
    state = Provider.of<stateManager>(context, listen: false);
    print('路況速報開始抓取');
    var position = await geolocator().updataPosition(context);
    var url =
        '${state.modeName == 'car' ? dotenv.env['NearbyRoadCondition'] : dotenv.env['NearbyRoadConditionScooter'].toString()}?longitude=${position.longitude}&latitude=${position.latitude}';
    var jwt = ',${prefs.get('userToken')}';

    var response = await api().apiGet(url, jwt);
    print(jsonDecode(utf8.decode(response.bodyBytes)));
    if (response.statusCode == 200) {
      state.updateNearbyRoadCondition(
          jsonDecode(utf8.decode(response.bodyBytes)));
      print('路況速報抓取成功');
    } else {
      print(jsonDecode(utf8.decode(response.bodyBytes)));
      print('路況速報抓取失敗');
    }
  }
}
