import 'package:flutter/foundation.dart';

class mode_state with ChangeNotifier {
  String _modeName = 'car';

  String get modeName => _modeName;

  // set modeName(String name) {
  //   _modeName = name;
  //   notifyListeners();
  // }

  void updateState(String newValue) {
    _modeName = newValue;
    notifyListeners(); // 通知监听器状态已更新
  }
}
