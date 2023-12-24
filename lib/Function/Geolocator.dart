// ignore_for_file: camel_case_types, unused_element, unused_field, unused_local_variable, file_names

import 'package:geocoding/geocoding.dart';
import 'package:traffic_hero/Imports.dart';

class geolocator {
  late List<Placemark> placemarks;
  late stateManager state;

  StreamSubscription<Position>? _positionStreamSubscription;

  Future<Position> updataPosition(context) async {
    state = Provider.of<stateManager>(context, listen: false);
    Position position = await _determinePosition();
    state.changePositionNow(position);
    try {
      List pm =
          await placemarkFromCoordinates(position.latitude, position.longitude);
    } catch (e) {
      EasyLoading.showError('無法取得座標');
    }

    return position;
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
  }
}
// desiredAccuracy: LocationAccuracy.best)

  // @override
  // void dispose() {
  //   _stopTrackingPosition(); // 停止追踪位置更新
  //   super.dispose();
  // }

  // void _stopTrackingPosition() {
  //   // 取消位置更新的订阅
  //   _positionStreamSubscription?.cancel();
  // }
