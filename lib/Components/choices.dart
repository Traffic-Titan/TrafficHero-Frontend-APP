import 'package:awesome_select/awesome_select.dart' show S2Choice;

List<S2Choice<String>> days = [
  S2Choice<String>(value: 'mon', title: 'Monday'),
  S2Choice<String>(value: 'tue', title: 'Tuesday'),
  S2Choice<String>(value: 'wed', title: 'Wednesday'),
  S2Choice<String>(value: 'thu', title: 'Thursday'),
  S2Choice<String>(value: 'fri', title: 'Friday'),
  S2Choice<String>(value: 'sat', title: 'Saturday'),
  S2Choice<String>(value: 'sun', title: 'Sunday'),
];

List<S2Choice<String>> months = [
  S2Choice<String>(value: 'jan', title: 'January'),
  S2Choice<String>(value: 'feb', title: 'February'),
  S2Choice<String>(value: 'mar', title: 'March'),
  S2Choice<String>(value: 'apr', title: 'April'),
  S2Choice<String>(value: 'may', title: 'May'),
  S2Choice<String>(value: 'jun', title: 'June'),
  S2Choice<String>(value: 'jul', title: 'July'),
  S2Choice<String>(value: 'aug', title: 'August'),
  S2Choice<String>(value: 'sep', title: 'September'),
  S2Choice<String>(value: 'oct', title: 'October'),
  S2Choice<String>(value: 'nov', title: 'November'),
  S2Choice<String>(value: 'dec', title: 'December'),
];

List<S2Choice<String>> os = [
  S2Choice<String>(value: 'and', title: 'Android'),
  S2Choice<String>(value: 'ios', title: 'IOS'),
  S2Choice<String>(value: 'mac', title: 'Macintos'),
  S2Choice<String>(value: 'tux', title: 'Linux'),
  S2Choice<String>(value: 'win', title: 'Windows'),
];

List<S2Choice<String>> heroes = [
  S2Choice<String>(value: 'bat', title: 'Batman'),
  S2Choice<String>(value: 'sup', title: 'Superman'),
  S2Choice<String>(value: 'hul', title: 'Hulk'),
  S2Choice<String>(value: 'spi', title: 'Spiderman'),
  S2Choice<String>(value: 'iro', title: 'Ironman'),
  S2Choice<String>(value: 'won', title: 'Wonder Woman'),
];


List<S2Choice<String>> frameworks = [
  S2Choice<String>(value: 'ion', title: 'Ionic'),
  S2Choice<String>(value: 'flu', title: 'Flutter'),
  S2Choice<String>(value: 'rea', title: 'React Native'),
];



List<S2Choice<String>> sorts = [
  S2Choice<String>(value: 'popular', title: 'Popular'),
  S2Choice<String>(value: 'review', title: 'Most Reviews'),
  S2Choice<String>(value: 'latest', title: 'Newest'),
  S2Choice<String>(value: 'cheaper', title: 'Low Price'),
  S2Choice<String>(value: 'pricey', title: 'High Price'),
];

List<Map<String, String>> city = [
  {'value': '基隆市', 'title': '基隆市',  'body': '1. 北部區域'},
  {'value': '新北市', 'title': '新北市',  'body': '1. 北部區域'},
  {'value': '臺北市', 'title': '臺北市',  'body': '1. 北部區域'},
  {'value': '新竹市', 'title': '新竹市',  'body': '1. 北部區域'},
  {'value': '桃園市', 'title': '桃園市',  'body': '1. 北部區域'},
  {'value': '新竹縣', 'title': '新竹縣',  'body': '1. 北部區域'},
  {'value': '宜蘭縣', 'title': '宜蘭縣',  'body': '1. 北部區域'},
  {'value': '臺中市', 'title': '臺中市',  'body': '2. 中部區域'},
  {'value': '苗栗縣', 'title': '苗栗縣',  'body': '2. 中部區域'},
  {'value': '彰化縣', 'title': '彰化縣',  'body': '2. 中部區域'},
  {'value': '南投縣', 'title': '南投縣',  'body': '2. 中部區域'},
  {'value': '雲林縣', 'title': '雲林縣',  'body': '2. 中部區域'},
  {'value': '高雄市', 'title': '高雄市',  'body': '3. 南部區域'},
  {'value': '臺南市', 'title': '臺南市',  'body': '3. 南部區域'},
  {'value': '嘉義市', 'title': '嘉義市',  'body': '3. 南部區域'},
  {'value': '嘉義縣', 'title': '嘉義縣',  'body': '3. 南部區域'},
  {'value': '屏東縣', 'title': '屏東縣',  'body': '3. 南部區域'},
  {'value': '花蓮縣', 'title': '花蓮縣',  'body': '4. 東部區域'},
  {'value': '臺東縣', 'title': '臺東縣',  'body': '4. 東部區域'},
  {'value': '澎湖縣', 'title': '澎湖縣',  'body': '5. 離島區域'},
  {'value': '金門縣', 'title': '金門縣',  'body': '5. 離島區域'},
  {'value': '連江縣', 'title': '連江縣',  'body': '5. 離島區域'},
];

List<Map<String, String>> way = [
  {'value': '國道', 'title': '國道',  'body': '道路'},
  {'value': '省道', 'title': '省道',  'body': '道路'},
  {'value': '一般道路', 'title': '一般道路',  'body': '道路'},
];

List<Map<String, String>> scooterway = [
  {'value': '省道', 'title': '省道',  'body': '道路'},
  {'value': '一般道路', 'title': '一般道路',  'body': '道路'},
];

List<Map<String, String>> publicTransport = [
  {'value': '公車', 'title': '公車',  'body': '公路'},
  {'value': 'YouBike', 'title': 'You Bike',  'body': '公路'},
  {'value': '台鐵', 'title': '台鐵',  'body': '鐵路'},
  {'value': '高鐵', 'title': '高鐵',  'body': '鐵路'},
];

List<Map<String, String>> stationList = [
  {"time": "10","id": "201","station": "國立雲林科技大學站"},
  {"time": "10","id": "201","station": "國立雲林科技大學站"},
  {"time": "10","id": "201","station": "國立雲林科技大學站"},
  {"time": "10","id": "201","station": "國立雲林科技大學站"},
  {"time": "10","id": "201","station": "國立雲林科技大學站"},
  {"time": "10","id": "201","station": "國立雲林科技大學站"},
];
List<Map<String, String>> operationList = [
  {"type": "台鐵","state": "assets/home/light_normal.png","url":"台鐵後端API"},
  {"type": "高鐵","state": "assets/home/light_abnormal.png","url":"高鐵後端API"},
  {"type": "台北\n捷運","state": "assets/home/light_abnormal.png","url":"台北捷運後端API"},
  {"type": "新北\n捷運","state": "assets/home/light_partialAdnormal.png","url":"新北運後端API"},
  {"type": "桃園\n捷運","state": "assets/home/light_normal.png","url":"桃園運後端API"},
];