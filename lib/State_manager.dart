// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, file_names, unused_field, prefer_final_fields, avoid_print, non_constant_identifier_names
import 'imports.dart';

class stateManager with ChangeNotifier {
  String _modeName = 'car';
  var _accountState = '';
  var _test = [];
  String _verifyEmail = '';
  String _forgetToken = '';
  String _veriffyState = '';

  String get modeName => _modeName;
  String get accountState => _accountState;
  String get verifyEmail => _verifyEmail;
  String get forgetToken => _forgetToken;
  String get veriffyState => _veriffyState;

  void updateModeState(String newValue) {
    _modeName = newValue;
    notifyListeners();
  }

  void updateAccountState(newValue) {
    _accountState = newValue;
    notifyListeners();
  }

  void addNewState(newValue) {
    _test.add(newValue);
    notifyListeners();
  }

  void VerifyEmailSet(newValue) {
    _verifyEmail = newValue;
    notifyListeners();
  }

  void forgetTokenSet(newValue) {
    if (newValue == null) {
      print('off');
    } else {
      _forgetToken = newValue;
    }
    notifyListeners();
  }

  void veriffyStateSet(newValue) {
    _veriffyState = newValue;
    notifyListeners();
  }
}
