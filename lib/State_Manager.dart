// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, file_names, unused_field, prefer_final_fields, avoid_print, non_constant_identifier_names
import 'imports.dart';

class stateManager with ChangeNotifier {
  String _modeName = 'car';
  var _accountState = '';
  String _verifyEmail = '';
  String _forgetToken = '';
  String _veriffyState = '';
  var _google_sso_status;
  var _google_sso;
  var _profile;

  var _appBarState = true;
  var _navigationBarState = true;
  var _floatingBtnState = true;


  String get modeName => _modeName;
  String get accountState => _accountState;
  String get verifyEmail => _verifyEmail;
  String get forgetToken => _forgetToken;
  String get veriffyState => _veriffyState;
  get google_sso_status => _google_sso_status;
  get google_sso => _google_sso;

  get profile => _profile;



  void updateModeState(String newValue) {
    _modeName = newValue;
    notifyListeners();
  }

  void updateAccountState(newValue) {
    _accountState = newValue;
    notifyListeners();
  }

  void VerifyEmailSet(newValue) {
    _verifyEmail = newValue;
    notifyListeners();
  }

  void forgetTokenSet(newValue) {
    if (newValue == null) {
    } else {
      _forgetToken = newValue;
    }
    notifyListeners();
  }

  void veriffyStateSet(newValue) {
    _veriffyState = newValue;
    notifyListeners();
  }

  void google_sso_status_Set(newValue) {
    _google_sso_status = newValue;
    notifyListeners();
  }

  void google_sso_Set(newValue) {
    _google_sso = newValue;
    notifyListeners();
  }

  void updateprofileState(newValue) {
    _profile = newValue;
    notifyListeners();
  }

}
