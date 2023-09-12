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
List<Map<String, String>> fastLocation = [
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
    'value': '換電站',
    'title': '換電站',
    'img': 'assets/fastLocation/batteryStop.png',
    'url': '後端API'
  },
  {
    'value': '充電站',
    'title': '充電站',
    'img': 'assets/fastLocation/chargingStation.png',
    'url': '後端API'
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



