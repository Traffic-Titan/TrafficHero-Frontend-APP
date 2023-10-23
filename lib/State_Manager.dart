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
  Map<String, dynamic> _weather = {
    'area': '---',
    'url': 'https://www.cwa.gov.tw/V8/C/W/Town/Town.html?TID=1000901',
    'temperature': '--',
    'the_lowest_temperature': '--',
    'the_highest_temperature': '--',
    'weather': '-',
    'weather_icon_url':
        'https://help.apple.com/assets/64067987823C71654C27CD1A/64067990823C71654C27CD47/zh_TW/1200cde3569cf69bd80e1ddabc0f15cd.png'
  };
  var _pageDetail;
  var _keyWord;
  var _searchPageDetail;
  var _cmsList_Car;

  var _appBarState = true;
  var _navigationBarState = true;
  var _floatingBtnState = true;
  Map<String, dynamic> _OperationalStatus = {
    'intercity': [
      {
        'name': '',
        'status': '',
        'status_text': '',
        'logo_url':
            'https://cdn3.iconfinder.com/data/icons/basic-2-black-series/64/a-92-256.png'
      },
    ],
     'local': [
      {
        'name': '',
        'status': '',
        'status_text': '',
        'logo_url':
            'https://cdn3.iconfinder.com/data/icons/basic-2-black-series/64/a-92-256.png'
      },
    ]
  };

  String get modeName => _modeName;
  String get accountState => _accountState;
  String get verifyEmail => _verifyEmail;
  String get forgetToken => _forgetToken;
  String get veriffyState => _veriffyState;
  get google_sso_status => _google_sso_status;
  get google_sso => _google_sso;
  get OperationalStatus => _OperationalStatus;
  get profile => _profile;
  get weather => _weather;
  get pageDetail => _pageDetail;
  get keyWord => _keyWord;
  get searchPageDetail => _searchPageDetail;
  get cmsCarList_Car => _cmsList_Car;

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

  void updateOperationalStatus(newValue) {
    _OperationalStatus = newValue;
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

  void updateWeatherState(newValue) {
    _weather = newValue;
    notifyListeners();
  }

  void updatePageDetail(newValue) {
    _pageDetail = newValue;
    notifyListeners();
  }

  void updateKeyWord(newValue) {
    _keyWord = newValue;
    notifyListeners();
  }

  void updateSearchPageDetail(newValue) {
    _searchPageDetail = newValue;
    notifyListeners();
  }

  void updateCMSList_Car(newValue) {
    _cmsList_Car = newValue;
    notifyListeners();
  }

  //會員管理頁面
  var _acctInforState = false;
  get acctInforState => _acctInforState;

  void changeAcctInforState(newValue) {
    _acctInforState = newValue;
    notifyListeners();
  }

  //使用者目前座標
  var _positionNow;
  get positionNow => _positionNow;

  void changePositionNow(newValue) {
    _positionNow = newValue;
    notifyListeners();
  }

  //附近站點資訊
  var _nearbyStationBus;
  var _nearbyStationTrain;
  var _nearbyStationBike;
  get nearbyStationBus => _nearbyStationBus;
  get nearbyStationTrain => _nearbyStationTrain;
  get nearbyStationBike => _nearbyStationBike;
  void updateNearbyStationBus(newValue) {
    _nearbyStationBus = newValue;
    notifyListeners();
  }
  void updateNearbyStationTrain(newValue) {
    _nearbyStationTrain = newValue;
    notifyListeners();
  }
  void updateNearbyStationBike(newValue) {
    _nearbyStationBike = newValue;
    notifyListeners();
  }
}
