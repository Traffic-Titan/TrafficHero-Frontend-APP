// ignore_for_file: file_names, non_constant_identifier_names, unused_element
import 'package:traffic_hero/Imports.dart';

List<Map<String, String>> toolList = [
  {
    'value': '路邊停車費',
    'title': '停車費',
    'img': 'assets/home/parkinglot.png',
    'url': '後端API'
  },
    {
    'value': 'Etag',
    'title': 'Etag',
    'img': 'assets/home/Etag_Logo.png',
    'url': 'https://www.fetc.net.tw/UX/'
  },
    {
    'value': '交通罰緩',
    'title': '交通罰緩',
    'img': 'assets/home/監理站_Logo.png',
    'url': 'https://www.mvdis.gov.tw/m3-emv-vil/vil/penaltyQueryPay#gsc.tab=0'
  },

];
List<Map<String, String>> fastLocationCar = [
  {
    'value': '加油站',
    'title': '加油站',
    'img': 'assets/fastLocation/gaspumpStop.png',
    'url': dotenv.env['GasStation'].toString()
  },
  {
    'value': 'https://www.google.com/maps/dir/25.1737288,121.4341894/414%E5%8F%B0%E4%B8%AD%E5%B8%82%E7%83%8F%E6%97%A5%E5%8D%80%E4%B8%AD%E5%B1%B1%E8%B7%AF%E4%B8%89%E6%AE%B51165%E8%99%9F/@24.6413693,120.3359623,9z/data=!3m1!4b1!4m9!4m8!1m1!4e1!1m5!1m1!1s0x34693ec40c7103e3:0xcd8e2812aa561111!2m2!1d120.590033!2d24.1133503!11m1!6b1?entry=ttu',
    'title': '便利商店',
    'img': 'assets/fastLocation/convenientShop.png',
    'url': dotenv.env['ConvenientStore'].toString()
  },

  {
    'value': '充電站',
    'title': '充電站',
    'img': 'assets/fastLocation/chargingStation.png',
    'url': dotenv.env['QuickSearch_ChargingStation'].toString()
  },
  {
    'value': '汽車定位',
    'title': '汽車定位',
    'img': 'assets/fastLocation/car-placeholder.png',
    'url': dotenv.env['GetParkingLocation'].toString()
  },
];

List<Map<String, String>> fastLocationPublic = [
  {
    'value': '加油站',
    'title': '加油站',
    'img': 'assets/fastLocation/gaspumpStop.png',
    'url': dotenv.env['GasStation'].toString()
  },
  {
    'value': 'https://www.google.com/maps/dir/25.1737288,121.4341894/414%E5%8F%B0%E4%B8%AD%E5%B8%82%E7%83%8F%E6%97%A5%E5%8D%80%E4%B8%AD%E5%B1%B1%E8%B7%AF%E4%B8%89%E6%AE%B51165%E8%99%9F/@24.6413693,120.3359623,9z/data=!3m1!4b1!4m9!4m8!1m1!4e1!1m5!1m1!1s0x34693ec40c7103e3:0xcd8e2812aa561111!2m2!1d120.590033!2d24.1133503!11m1!6b1?entry=ttu',
    'title': '便利商店',
    'img': 'assets/fastLocation/convenientShop.png',
    'url': dotenv.env['ConvenientStore'].toString()
  },

  {
    'value': '停車定位',
    'title': '停車定位',
    'img': 'assets/fastLocation/car-placeholder.png',
    'url': dotenv.env['GetParkingLocation'].toString()
  },
];

List<Map<String, String>> fastLocationCarCms = [
  {
    'value': '加油站',
    'title': '加油站',
    'img': 'assets/fastLocation/gaspumpStop.png',
    'url': dotenv.env['CMS_GasStation'].toString()
  },
  {
    'value': 'https://www.google.com/maps/dir/25.1737288,121.4341894/414%E5%8F%B0%E4%B8%AD%E5%B8%82%E7%83%8F%E6%97%A5%E5%8D%80%E4%B8%AD%E5%B1%B1%E8%B7%AF%E4%B8%89%E6%AE%B51165%E8%99%9F/@24.6413693,120.3359623,9z/data=!3m1!4b1!4m9!4m8!1m1!4e1!1m5!1m1!1s0x34693ec40c7103e3:0xcd8e2812aa561111!2m2!1d120.590033!2d24.1133503!11m1!6b1?entry=ttu',
    'title': '便利商店',
    'img': 'assets/fastLocation/convenientShop.png',
    'url': dotenv.env['CMS_ConvenientStore'].toString()
  },

  {
    'value': '充電站',
    'title': '充電站',
    'img': 'assets/fastLocation/chargingStation.png',
    'url': dotenv.env['QuickSearch_ChargingStation'].toString()
  },
 
];

List<Map<String, String>> fastLocationScooter = [
  {
    'value': '加油站',
    'title': '加油站',
    'img': 'assets/fastLocation/gaspumpStop.png',
    'url': dotenv.env['GasStation'].toString()
  },
  {
    'value': 'https://www.google.com/maps/dir/25.1737288,121.4341894/414%E5%8F%B0%E4%B8%AD%E5%B8%82%E7%83%8F%E6%97%A5%E5%8D%80%E4%B8%AD%E5%B1%B1%E8%B7%AF%E4%B8%89%E6%AE%B51165%E8%99%9F/@24.6413693,120.3359623,9z/data=!3m1!4b1!4m9!4m8!1m1!4e1!1m5!1m1!1s0x34693ec40c7103e3:0xcd8e2812aa561111!2m2!1d120.590033!2d24.1133503!11m1!6b1?entry=ttu',
    'title': '便利商店',
    'img': 'assets/fastLocation/convenientShop.png',
    'url': dotenv.env['ConvenientStore'].toString()
  },
  {
    'value': '機車定位',
    'title': '機車定位',
    'img': 'assets/fastLocation/scooter-locate.png',
    'url': dotenv.env['GetParkingLocation'].toString()
  },

];


List<Map<String, String>> fastLocationScooter2 = [
  {
    'value': 'Gogoro',
    'title': 'Gogoro',
    'img': 'https://play-lh.googleusercontent.com/Bs4qlK0OaYAXWSiGDDKDrSOspEdnsJywkGocYxGY_6tkQB6Ei9SoAkFLSrDxStN83l_1',
    'url': dotenv.env['QuickSearch_BatterySwapStation_Gogoro'].toString()
  },
  {
    'value': 'Ionex',
    'title': 'Ionex',
    'img': 'https://play-lh.googleusercontent.com/D2wrctqAbQp6kWdnslPzLsqaUhXWFRn4JkW8wWkLySKS_9NtDdhb-0EaRZ4x3K1z0KdA',
    'url': dotenv.env['QuickSearch_BatterySwapStation_Ionex'].toString()
  },
  {
    'value': 'eMOVING',
    'title': 'eMOVING',
    'img': 'https://www.e-moving.com.tw/images/icons-192.png?v=20220317',
    'url': dotenv.env['QuickSearch_BatterySwapStation_eMOVING'].toString()
  },

];

//CMS List
List<Map<String, String>> cmsList = [
  {
    'type': '科技執法',
    'title': '前方有測速照相，速限50km/h',
    'img': 'assets/fastLocation/gaspumpStop.png',
  },
  {
    'type': '道路施工',
    'title': '中山北路一段進行道路施工',
    'img': 'assets/construction.png',
  },
  {
    'type': '道路壅塞',
    'title': '前方道路壅塞，建議改道通行',
    'img': 'assets/fastLocation/chargingStation.png',
  },
  {
    'type': '科技執法',
    'title': '前方有測速照相，速限40km/h',
    'img': 'assets/fastLocation/gaspumpStop.png',
  },
];

//fastLocation components 方便之後供使用者選擇新增修改
Map<String, String> fastLocation_chargingStation = {
  'value': '充電站',
  'title': '充電站',
  'img': 'assets/fastLocation/chargingStation.png',
  'url': '後端API'
};
Map<String, String> fastLocation_batterystop = {
  'value': '換電站',
  'title': '換電站',
  'img': 'assets/fastLocation/batteryStop.png',
  'url': '後端API'
};
Map<String, String> fastLocation_gaspump = {
  'value': '加油站',
  'title': '加油站',
  'img': 'assets/fastLocation/gaspumpStop.png',
  'url': '後端API'
};
Map<String, String> fastLocation_convientStore = {
  'value': '便利商店',
  'title': '便利商店',
  'img': 'assets/fastLocation/convenientShop.png',
  'url': '後端API'
};

//道路資訊 可篩選之路況list
List<String> roadInfoFilterList = [
  '停車場資訊',
  '交通管制',
  '交通事故',
  '道路施工',
  '道路壅塞'
];

//高雄捷運
List<String> MRTList_kaohsiung = ["小港","高雄國際機場","草衙","前鎮高中", "凱旋", "獅甲", "三多商圈","中央公園", "美麗島",
"高雄車站","後驛","凹子底","巨蛋","生態園區","左營","世運","油廠國小","楠梓加工區","後勁","都會公園","青埔","橋頭糖廠","橋頭火車站","岡山", "西子灣(中山大學)","鹽埕埔","市議會(舊址)","信義國小","文化中心","五塊厝","技擊館","衛武營","鳳山西站(高雄市議會)","鳳山","大東","鳳山國中","大寮"];


