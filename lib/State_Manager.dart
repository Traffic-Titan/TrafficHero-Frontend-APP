// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, file_names, unused_field, prefer_final_fields, avoid_print, non_constant_identifier_names


import 'imports.dart';

class stateManager with ChangeNotifier {
  //首頁
 Map<String, dynamic> _profile = {
    "name": "",
    "email": "",
    "gender": "",
    "birthday": "",
    "google_id": "",
    "avatar":
        "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",
    "rule": null
  };
  Map<String, dynamic> _weather = {
    'area': '---',
    'url': 'https://www.cwa.gov.tw/V8/C/W/Town/Town.html?TID=1000901',
    'temperature': '--',
    'the_lowest_temperature': '--',
    'the_highest_temperature': '--',
    'weather': '-',
    'weather_icon_url': 'https://www.colorhexa.com/e7f1fe.png'
  };
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

    //附近站點資訊
  List<dynamic> _nearbyStationBus = [
    {
      'StopLatitude': '',
      'StopLongitude': '',
      '路線名稱': '',
      '站點名稱': '',
      '預估到站時間 (min)': 0,
      '終點站': ''
    },
  ];
  List<dynamic> _nearbyStationTrain = [
    {
      'StationUID': '',
      'StationName': '',
      'EndingStationName': '',
      'TrainNo': '',
      'Direction': '',
      'TrainTypeName': '',
      'ScheduleDepartureTime': ''
    },
  ];
  List<dynamic> _nearbyStationBike = [
  {
    "station_uid": "TPE500103027",
    "area": "TaipeiCity",
    "available_rent_bikes": '',
    "available_rent_bikes_detail": {
      "general_bikes": 2,
      "electric_bikes": 0
    },
    "available_return_bikes": '',
    "bikes_capacity": 41,
    "icon_url": "https://play-lh.googleusercontent.com/DmDUCLudSKb5hZV5P_i3S-oZkF-udIPfW1OSa-fq2FS9rTV5A2v_tTGgpS0wuSs0bA=w240-h480-rw",
    "location": {
      "longitude": 121.52063,
      "latitude": 25.05826
    },
    "service_status": "正常營運",
    "service_type": "",
    "station_address_zh_tw": "萬全街22號對面",
    "station_id": "500103027",
    "station_name_zh_tw": "",
    "distance": 0.2009265565158994
  },
  ];
  List<dynamic> _NearbyRoadCondition = [
    {
      "road_name": "",
      "content": [""]
    },
  ];
  String _modeName = 'car';
  var _accountState = '';
  String _verifyEmail = '';
  String _forgetToken = '';
  String _veriffyState = '';
  var _google_sso_status;
  var _google_sso;
  var _pageDetail;
  var _keyWord;
  var _searchPageDetail;
  var _cmsList_Car;
  var _busRouteDetail;
  var _appBarState = true;
  var _navigationBarState = true;
  var _floatingBtnState = true;
  var _THSR_StartEndSearchResult;
  var _THSR_StartEndSearch_StartName;
  var _THSR_StartEndSearch_EndName;
  var _THSR_CarNumSearch_CarNum;
  var _THSR_CarNumSearchResult;
  var _TRA_TimeTableSearch_StartStation;
  var _TRA_TimeTableSearch_EndStation;
  var _TRA_TimeTableSearch_StartEndStation_Result;
  var _TRA_TimeTableSearch_CarType;
  var _TRA_TimeTableSearch_CarNum;
  var _TRA_TimeTableSearch_CarNum_Result;
  var _TRA_TimeTableSearch_Station;
  var _TRA_TimeTableSearch_Station_Result_OutBound;
  var _TRA_TimeTableSearch_Station_Result_InBound;
  var _MRT_Taipei_DynamicInfo;
   List<dynamic>  _CMSSpeed = [];


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
  get busRouteDetail => _busRouteDetail;
  get THSR_StartEndSearchResult => _THSR_StartEndSearchResult;
  get THSR_StartEndSearch_StartName => _THSR_StartEndSearch_StartName;
  get THSR_StartEndSearch_EndName => _THSR_StartEndSearch_EndName;
  get THSR_CarNumSearch_CarNum => _THSR_CarNumSearch_CarNum;
  get THSR_CarNumSearchResult => _THSR_CarNumSearchResult;
  get TRA_TimeTableSearch_StartEndStation_Result => _TRA_TimeTableSearch_StartEndStation_Result;
  get TRA_TimeTableSearch_StartStation => _TRA_TimeTableSearch_StartStation;
  get TRA_TimeTableSearch_EndStation => _TRA_TimeTableSearch_EndStation;
  get TRA_TimeTableSearch_CarType => _TRA_TimeTableSearch_CarType;
  get TRA_TimeTableSearch_CarNum => _TRA_TimeTableSearch_CarNum;
  get TRA_TimeTableSearch_CarNum_Result => _TRA_TimeTableSearch_CarNum_Result;
  get TRA_TimeTableSearch_Station => _TRA_TimeTableSearch_Station;
  get TRA_TimeTableSearch_Station_Result_OutBound => _TRA_TimeTableSearch_Station_Result_OutBound;
  get TRA_TimeTableSearch_Station_Result_InBound => _TRA_TimeTableSearch_Station_Result_InBound;
  get MRT_Taipei_DynamicInfo => _MRT_Taipei_DynamicInfo;
  get CMSSpeed => _CMSSpeed;

  void updateMRT_Taipei_DynamicInfo(List<dynamic> newValue){
    _MRT_Taipei_DynamicInfo = newValue;
    notifyListeners();
  }

  void updateTRA_TimeTableSearch_Station_Result_OutBound(List<dynamic> newValue){
    _TRA_TimeTableSearch_Station_Result_OutBound = newValue;
   notifyListeners();
  }
  void updateTRA_TimeTableSearch_Station_Result_InBound(List<dynamic> newValue){
   _TRA_TimeTableSearch_Station_Result_InBound = newValue;
   notifyListeners();
  }
  void updateTRA_TimeTableSearch_Station(String newValue){
   _TRA_TimeTableSearch_Station = newValue;
   notifyListeners();
  }
  void updateTRA_TimeTableSearch_CarNum_Result(List<dynamic> newValue){
    _TRA_TimeTableSearch_CarNum_Result = newValue;
    notifyListeners();
  }
  void updateTRA_TimeTableSearch_CarType(String newValue){
   _TRA_TimeTableSearch_CarType = newValue;
   notifyListeners();
  }

  void updateTRA_TimeTableSearch_CarNum(String newValue){
    _TRA_TimeTableSearch_CarNum = newValue;
    notifyListeners();
  }

  void updateTRA_TimeTableSearch_EndStation(String newValue){
   _TRA_TimeTableSearch_EndStation = newValue;
   notifyListeners();
  }

  void updateTRA_TimeTableSearch_StartStation(String newValue){
    _TRA_TimeTableSearch_StartStation = newValue;
    notifyListeners();
  }
  void updateTRA_TimeTableSearch_StartEndStation_Result(List<dynamic> newValue){
    _TRA_TimeTableSearch_StartEndStation_Result = newValue;
    notifyListeners();
  }

 void updateTHSR_CarNumSearch_CarNum (String newValue){
   _THSR_CarNumSearch_CarNum = newValue;
   notifyListeners();
 }
 void updateTHSR_CarNumSearchResult (List<dynamic> newValue){
   _THSR_CarNumSearchResult = newValue;
   notifyListeners();
 }

 void updateTHSR_StartEndSearch_StartName (String newValue){
   _THSR_StartEndSearch_StartName = newValue;
   notifyListeners();
 }
 void updateTHSR_StartEndSearch_EndName (String newValue){
   _THSR_StartEndSearch_EndName = newValue;
   notifyListeners();
 }

  void updateTHSR_StartEndSearchResult (List<dynamic> newValue){
    _THSR_StartEndSearchResult = newValue;
    notifyListeners();
  }

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

  void updateBusRouteDetail(newValue) {
    _busRouteDetail = newValue;
    notifyListeners();
  }


  


  get NearbyRoadCondition => _NearbyRoadCondition;

  void updateNearbyRoadCondition(newValue) {
    _NearbyRoadCondition = newValue;
    notifyListeners();
  }

    void UpdateMessageList(newValue) {
    _CMSSpeed = newValue;
    notifyListeners();
  }
}
