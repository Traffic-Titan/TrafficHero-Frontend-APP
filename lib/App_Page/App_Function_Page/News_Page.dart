// ignore_for_file: sized_box_for_whitespace, avoid_print, file_names, unnecessary_set_literal, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:traffic_hero/imports.dart';
import 'package:traffic_hero/Components/choices.dart' as choices;

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  late stateManager state;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
  }

  var pp =
      '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';
  var tttt = [
    {
      "Region": "TRTC",
      "NewsID": "9018055",
      "Title": "全臺捷運系統攜手結盟   首屆捷運聯盟交流會議7月21日舉行",
      "NewsCategory": "新聞稿",
      "Description":
          "臺北捷運公司、新北捷運公司、桃園捷運公司、臺中捷運公司及高雄捷運公司，全臺捷運公司共同成立「捷運聯盟(Metro Taiwan)」，第一屆交流會議7月21日(週五)在臺北捷運北投會館舉行，由新北捷運公司董事長林祐賢擔任召集人，以專題講座及「智慧營運」交流論壇，共創捷運知識力，提升軌道營運專業知能，進一步帶動國內軌道運輸產業整體產業鏈的蓬勃共榮。出席貴賓包括新北捷運公司董事長林祐賢、總經理吳國濟；桃園捷運公司董事長沈志藏、副總經理陳定漢；臺中捷運公司處長林永盛及高雄捷運公司副總經理林誌銘，率領相關部門專業人才約120人進行經驗分享及意見交流。&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;臺北捷運公司董事長趙紹廉致詞時指出，臺北捷運為臺灣第一家捷運系統，已累積豐富的營運經驗與能量，經驗分享與傳承更是責無旁貸，因此發起邀請所有城市捷運公司，共同成立「捷運聯盟(Metro Taiwan)」，以臺灣捷運結盟的形式，建立國內捷運同業建立良好橫向溝通管道，做為彼此間的交流平臺，定期舉辦捷運論壇、專題演講，促進捷運產業發展，共同提升技術品質與服務水準。「捷運聯盟(Metro Taiwan)」第一屆交流會議安排由北捷總經理黃清信以「ESG永續發展-企業生存/競爭力之戰」為題發表專題演講，分享北捷推動ESG減碳目標，調整營運方式減少能源使用、設備重置汰換提升能源使用效率；並且邀請新北捷運公司總經理吳國濟專題演講「與眾道不同」，說明全新交通品牌所面臨的挑戰及如何發展品牌差異化，開創交通品牌新格局。「智慧營運」為主題的「交流論壇」，則由5家捷運公司分享營運經驗和成果。北捷總經理黃清信專題演講中強調，在全球永續發展浪潮下，透過ESG檢視公司整體表現，推動落實公司治理、精進運輸系統、強化社會關懷、創新智慧營運、實踐環境永續5大經營策略，達成安全可靠、和諧共融、智慧營運、環境友善、高效運作等永續經營的願景。近年來，臺北捷運透過各大面向進行節能措施，推動ESG減碳的目標，包括調整營運方式減少能源使用、設備重置汰換提升能源使用效率，未來也將完成組織碳盤查，加入淨零碳排的行列。另一方面，積極發展應用再生能源，將6座捷運機廠屋頂轉化為太陽能光電廠，設置規模達21.5百萬瓦；配合2030年大客車全面電動化政策，於北投機廠規劃設置電動公車充電站，推動綠運具普及使用，貢獻企業社會責任。在交流論壇中，5家捷運公司緊扣「智慧營運」的主題，提出充滿創新、創意及科技的經營成果。臺北捷運提出「智慧營運、數位應用」的概念，分享近年智慧化成績；新北捷運「行動支付商業模式」，探討電子支付的無限商機，透過軟硬體的提升迎來雙贏局面；桃園捷運「雲網端規劃與應用」，運用5G高速網路及邊緣運算技術，發展「雲平臺架構」；臺中捷運「綠線鋼軌潤滑設備使用經驗分享」，提供有效的技術改善計畫；高雄捷運「智慧軌道發展現況」，提供營運面及維修面的智慧化成果。透過捷運聯盟交流會議，分享各自專業見解及營運經驗，加速提升國內運輸水準，達成智慧、低碳、永續、有效率的城市前景，讓民眾享受軌道運輸與經濟，帶來的美好、便利的生活型態。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=8E4FDF84F011B840",
      "StartTime": "2023-07-21T12:03:00+08:00",
      "EndTime": "2023-08-21T12:03:00+08:00",
      "PublishTime": "2023-07-21T12:03:00+08:00",
      "UpdateTime": "2023-07-21T12:03:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "9012263",
      "Title": "歷史文物玩創意！即日起故宮文創小物在捷運商品館Ｑ萌上市",
      "NewsCategory": "新聞稿",
      "Description":
          "臺北捷運公司跨界攜手國立故宮博物院，即日起在臺北捷運商品館忠孝復興店、南京復興店及中山店推出「故宮商品專區」：高人氣文物翠玉白菜，變身成夜光鑰匙圈、書籤夾及超微型積木；肉形石設計的國寶筆、畫工細緻的清明上河圖則成為一張張撲克牌；其他還有傳遞內心話的「朕知道了」紙膠帶、考生一定要買的「欽定一甲第一名」文件夾等，歡迎來逛逛。歷史文物融入創意時尚，還有故宮商品中精心挑選熱銷款，例如：迷你毛公鼎、迷你轉心瓶、迷你四方博古架文物組、迷你瓷器-故宮迷你汝窯紙槌瓶等，將文物擺放於書桌或展示櫃，可隨時賞玩，沉浸古物世界中。文具及生活創意商品更是令人會心一笑，如第一名鉛筆組、磁鐵聖旨、賜無畏馬克杯、蟈蟈聲LED鑰匙圈、玉辟邪小景磁鐵、翠玉白菜書籤夾、朕加恩賞銀紙膠帶等，快把歷史文物收進口袋名單中，為生活增添趣味。除了故宮創意小物，捷運淡水信義線臺北車站B3穿堂層的捷運藝文廊，展示「清 乾隆 瓷胎洋彩玉環蒜頭瓶」、「明 正德 青花龍紋高足碗」、「北宋 汝窯青瓷水仙盆」、「清院本清明上河圖卷」等故宮文物，歡迎旅客駐足欣賞。相關訊息請洽詢本公司24小時客服專線：（02）218-12345，或臺北市民當家熱線1999(外縣市02-27208889)或瀏覽本公司網站（https://www.metro.taipei/）。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=0B68D19999B640C3",
      "StartTime": "2023-07-13T11:56:00+08:00",
      "EndTime": "2023-08-13T11:56:00+08:00",
      "PublishTime": "2023-07-13T11:56:00+08:00",
      "UpdateTime": "2023-07-13T11:56:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "9010150",
      "Title": "7/24下午萬安46號演習 臺北捷運列車正常運行  演習期間捷運車站旅客只進不出 兒樂遊具暫停 敬請配合",
      "NewsCategory": "新聞稿",
      "Description":
          "「112年度萬安46號軍民聯合防空演習」於7月24日（週一）下午1時30分至2時舉行，演習期間臺北捷運正常運行，到站旅客則請暫時停留車站勿離站，並配合車站人員引導管制；臺北市兒童新樂園遊樂設施暫停使用，貓空纜車適逢週一例行維修日，未對外開放。依民防法第25條，民眾如違反演習規定，可處新臺幣3萬元以上15萬元以下罰鍰，敬請多加留意。臺北捷運公司表示，演習期間捷運車站及列車維持正常運行，到站旅客則請配合車站人員引導至大廳層或月臺層避難，同時各車站將會加強廣播宣導，請旅客勿在出入口逗留或張望。至於捷運販賣店、地下街及臺北小巨蛋，則均關閉門窗及燈光，臺北市兒童新樂園遊樂設施將暫停使用，請民眾配合各場所人員引導至適當地點避難；捷運轉乘停車場、臺北市兒童新樂園附屬停車場及小巨蛋附屬停車場皆維持車輛只進不出。詳情可洽詢本公司24小時客服專線：（02）218-12345，或臺北市民當家熱線1999(外縣市02-27208889)或瀏覽本公司網站（https://www.metro.taipei/）。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=547B6DCE3C8A36ED",
      "StartTime": "2023-07-10T13:48:00+08:00",
      "EndTime": "2023-08-10T13:48:00+08:00",
      "PublishTime": "2023-07-10T13:48:00+08:00",
      "UpdateTime": "2023-07-10T13:48:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "9009846",
      "Title": "臺北捷運親子友善彩繪列車「2023極地探索」板南線首航",
      "NewsCategory": "新聞稿",
      "Description":
          "親子友善彩繪列車「2023極地探索」出發！即日起，臺北捷運親子彩繪列車首度移至板南線行駛，並在板南線南港站設置「2023極地探索」打卡背板，現場布置歷屆親子彩繪列車展示牆，歡迎大小朋友在此拍照打卡，有精美小禮送給大家；同時，將合照上傳「台北捷運」粉絲專頁臉書參加抽獎，還有機會帶走獨家特製版悠遊卡。&nbsp;臺北捷運親子彩繪列車每年持續上線，今年規劃主題為「2023極地探索」，採用北歐雪季魔幻色調，以純白雪地結合冷色系天幕為設計主視覺，為炎炎仲夏帶來沁涼消暑的視覺感受，再搭配堆雪人、玩雪橇、滑冰等玩樂趣味，呈現美麗極光環繞下的豐富有趣活動。&nbsp;為慶祝親子彩繪列車首度於板南線行駛，板南線南港站特別設置「2023極地探索」打卡背板，現場更展示有歷屆親子彩繪列車，在主題背板前合照，並前往車站詢問處出示照片，即可獲得親子彩繪列車主題貼紙1張，限量貼紙有兩種款式，等大家來收集，貼紙贈送活動到7月23日止。&nbsp;此外，「台北捷運」粉絲專頁臉書推出兩波抽獎活動，7月12日及19日起限期將合照相片上傳至臉書貼文留言區，即可參加抽獎，有機會將「麻吉貓親子彩繪列車5th紀念悠遊卡」、「2023極地探索親子彩繪列車悠遊卡」等獎品帶回家。&nbsp;為提供親子、孕媽咪及推嬰兒車等旅客更友善服務，臺北捷運自104年起，陸續於淡水信義線、松山新店線、板南線、中和新蘆線列車第3節車廂第4個車門，至第4節車廂第1個車門之間，設置「親子友善區」。在「親子友善區」車廂區域相對位置的月臺門，貼有粉紅色「親子友善區」標示。歡迎有需要的大小朋友，在搭乘捷運時，多多選擇貼有粉紅色「親子友善區」標示的月臺候車，也請所有旅客發揮關懷禮讓精神，優先禮讓親子、孕婦及推嬰兒車旅客搭乘，共創友善有禮的乘車環境。&nbsp;想追逐親子友善彩繪列車「2023極地探索」，歡迎下載「台北捷運Go」App，隨時掌握「列車動態資訊」，相關資訊可洽詢本公司24小時客服專線：（02）218-12345，或臺北市民當家熱線1999(外縣市02-27208889)或瀏覽本公司網站（https://www.metro.taipei/ ）。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=B2A4B6BFA1AFA48D",
      "StartTime": "2023-07-10T09:41:00+08:00",
      "EndTime": "2023-08-10T09:41:00+08:00",
      "PublishTime": "2023-07-10T09:41:00+08:00",
      "UpdateTime": "2023-07-10T09:41:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "9009463",
      "Title": "臺北、臺東共榮共好！實踐ESG精神 臺北捷運臺東縣政府簽訂合作備忘錄",
      "NewsCategory": "新聞稿",
      "Description":
          "為實踐企業永續發展ESG精神，臺北捷運公司與臺東縣政府攜手朝向農產共銷、數位共建、觀光共榮、文化共好等四大面向簽訂合作備忘錄，7日在臺東縣長饒慶鈴與臺北捷運公司董事長趙紹廉一同見證下，由北捷總經理黃清信與臺東縣政府國際發展及計畫處處長曹劍秋共同簽署，希望能夠透過深度交流與合作，結合兩個城市的優勢，讓彼此更加共榮共好。臺北市為臺灣的代表城市之一，臺北捷運則是大臺北都會區交通大動脈，提供安全、可靠、舒適且便捷的運輸服務。臺東擁有最強大的資產好山好水，孕育出來的慢經濟優勢，延伸推出最美星空、部落旅遊、熱氣球嘉年華等深度體驗活動，以貼近永續的生活方式，推動臺東慢食節及土地友善耕作等。臺北捷運公司董事長趙紹廉指出，捷運不是只載運乘客，也是傳遞各地好玩、好吃、好去處的資訊載體，未來，透過備忘錄加強彼此交流，臺北捷運將成為最「了解臺東」的交通單位。臺北捷運落實ESG精神，將關懷社會的精神延伸，自2020年起透過「走近偏鄉 走入北捷」活動，以績優原住民同仁回饋母校的方式，將北捷無形的路網延伸到偏鄉地區。受到疫情影響，小農生計首當其衝，北捷發揮一己之力，過去曾與臺東縣政府合作，協助將臺東小農精心栽種的鳳梨、火龍果、釋迦、咖啡等農産品銷售推廣，並攜手原民會三方合作於心中山舉辦原創新美學活動，原汁原味複製臺東特色鐵花村意象及多元美食、文創商品，廣受社會大眾好評及臺東縣政府肯定。今年更進一步合作，將臺東慢經濟優勢引進臺北捷運，未來將結合北投會館捷之旅、臺東經典行程及深度旅遊等品牌行銷體驗，讓大臺北地區的民眾更了解臺東、體驗臺東慢活步調。詳情可洽詢本公司24小時客服專線：（02）218-12345，或臺北市民當家熱線1999(外縣市02-27208889)或瀏覽本公司網站（https://www.metro.taipei/）。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=BF9B9D3DEA4DE620",
      "StartTime": "2023-07-07T17:05:00+08:00",
      "EndTime": "2023-08-07T17:05:00+08:00",
      "PublishTime": "2023-07-07T17:05:00+08:00",
      "UpdateTime": "2023-07-07T17:05:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "9009286",
      "Title": "臺北捷運裝置「軌道溫度計」每日量「體溫」 確保營運安全",
      "NewsCategory": "新聞稿",
      "Description":
          "近日高溫炎熱，為避免軌道受到氣候影響，臺北捷運民國89年起，在淡水信義線復興崗站往忠義方向軌道下方裝設「軌道溫度計」，每天監測軌道溫度，確保捷運行車安全。臺北捷運高運量的軌道大部分在地下路段，不會受到氣候影響，其中淡水信義線圓山站到淡水站，屬於高架平面段，軌道會直接「感受」氣候變化。臺北捷運軌道設計容許軌溫在60度以上，捷運公司參考亞洲地區及高鐵的軌溫標準，將捷運軌溫監測標準訂在攝氏50度。當「軌道溫度計」監測到軌溫超過攝氏50度，便會馬上將資訊傳遞到遠端電腦，軌道維修人員接受到後立即出發車巡軌道，檢視軌道狀況。112年迄今共6天軌溫大於50度，其中七月到目前為止共3天軌溫大於50度，軌道維修人員當下立即出發巡視該路段軌道，確認系統營運正常。臺北捷運軌道維修人員以遠端監控方式，不但可隨時監測軌溫及大氣溫度變化，同時，針對軌溫及大氣溫度統計，分析相對變化值，亦可提供後續軌道維修參考。至於文湖線軌道，則與高運量長焊鋼軌的設計不同，木柵段為混凝土的行駛路面，而內湖段鋼製行駛路面，臺北市政府捷運工程局在建置時，已將溫差熱漲冷縮的變化量納入設計考量，因此每段鋼軌接續的部分已預留伸縮縫，確保行車安全。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=674F02B3AF6454C4",
      "StartTime": "2023-07-07T14:52:00+08:00",
      "EndTime": "2023-08-07T14:52:00+08:00",
      "PublishTime": "2023-07-07T14:52:00+08:00",
      "UpdateTime": "2023-07-07T14:52:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "9005225",
      "Title": "基北北桃都會通啟用首日順暢 臺北捷運呼籲民眾利用週末購退票",
      "NewsCategory": "新聞稿",
      "Description":
          "今(1)日是「TPASS行政院通勤月票/基北北桃都會通」上路第一天，持用「基北北桃都會通」電子票卡旅客，只需依照平日的通勤習慣快速進出臺北捷運任一閘門，一卡任悠遊，各車站運作相當順暢。臺北捷運自6月15日開放民眾辦理預購「基北北桃都會通」以來，迄今已累計達10萬張以上。啟用初期，臺北捷運特別加派人力，於重點車站接受旅客諮詢，建議大家利用啟用首週的週末假日，至捷運各車站辦理「1280定期票」退票及「基北北桃都會通」購票，輕鬆迎接7月3日上班日。&nbsp;7月1日凌晨0時，臺北捷運全線1,360個驗票閘門已正式啟用基北北桃都會通功能，臺北捷運公司董事長趙紹廉於凌晨時分親自前往臺北車站視察，確保系統均順利上線。&nbsp;臺北捷運票務系統為自行維護，擁有多年1280定期票經驗，為了配合基北北桃都會通時程，臺北捷運票務中心取得完整營運規則及技術文件後，立即著手進行軟體修改專案，經過為期3個月的開發測試，在7月1日凌晨「無縫接軌」啟動相關服務，提供民眾一卡在手，暢行無阻的乘車體驗。&nbsp;基北北桃都會通已正式啟用，為服務原有1280定期票旅客，臺北捷運特別推出3種退費方式，第1種為利用定期票退票線上申請網頁退費，使用手機或電腦即可完成，相關退費規定請瀏覽臺北捷運網站。&nbsp;第2種退費方式，至車站使用自動售票加值機辦理；至於第3種退費方式，則是親自前往各捷運站詢問處辦理。選擇2、3種方式的旅客，建議利用假日或離峰時段前往車站辦理，避免現場排隊或久候。&nbsp;臺北捷運全線車站共有645臺自動售票加值機提供基北北桃都會通購票及1280定期票退票服務，一機完成，相當便利，依照螢幕上的說明，點選「購買都會通」或「1280公共運輸定期票退票」，再將悠遊卡放在感應平臺上，即可進入操作畫面。&nbsp;若票卡內仍有尚未到期的1280定期票，請先退票再購買基北北桃都會通。1280定期票是依照「經過日數」(啟用當日起算至最後一次使用日之日數)退費，只要7月1日後不使用1280定期票，就不會影響退費比例。&nbsp;&nbsp;針對旅客需要的服務，臺北捷運已準備好了，全臺北捷運117個車站的：&nbsp;【諮詢服務】200個詢問處、16個臨時詢問處、1,070位服務同仁隨時提供「諮詢服務」。&nbsp;【購票、設定、退票服務】200個詢問處、16個臨時詢問處、645臺自動售票加值機、1,070位服務同仁隨時提供「購票、設定、退票服務」。&nbsp;【專屬通道】1,360個驗票閘門，每一個都是您的「專屬通道」。&nbsp;詳情可洽詢本公司24小時客服專線：（02）218-12345，或臺北市民當家熱線1999(外縣市02-27208889)或瀏覽本公司網站（https://www.metro.taipei/）。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=A18FE35177E812BD",
      "StartTime": "2023-07-01T11:20:00+08:00",
      "EndTime": "2023-08-01T11:20:00+08:00",
      "PublishTime": "2023-07-01T11:20:00+08:00",
      "UpdateTime": "2023-07-01T11:20:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "9004796",
      "Title": "基北北桃都會通7/1啟用！臺北捷運服務布點最廣、通行最便利 一卡在手 暢行無阻 基北北桃都會通 到哪都會通",
      "NewsCategory": "新聞稿",
      "Description":
          "「TPASS行政院通勤月票/基北北桃都會通」1日正式啟用，臺北捷運全線總動員提供基北北桃都會通服務，布點最廣、通行最便利，1,360個驗票閘門，每一個都是「專屬通道」，645臺自動售票加值機全天候提供購、退票服務，歡迎大家把握啟用首週的週末假日，至捷運車站購、退票，7月3日上班輕鬆GO。使用基北北桃公共運輸定期票，每天只要40元，30日內不限距離、次數搭乘臺北捷運、新北捷運、桃園機場捷運、基北北桃範圍內的公車、國道公路客運、臺鐵(部分對號列車除外)及YouBike租借優惠。7月1日基北北桃都會通正式啟用，為服務1280定期票旅客，臺北捷運特別推出3種退費方式，第1種為利用定期票退票線上申請網頁退費，利用手機或電腦即可完成，相關退費規定請瀏覽臺北捷運網站。第2種退費方式，至車站使用自動售票加值機辦理；至於第3種退費方式，則是親自前往各捷運站詢問處辦理。選擇2、3種方式的旅客，建議利用假日或離峰時段前往車站辦理，避免現場排隊或久候。臺北捷運全線車站共有645臺自動售票加值機提供基北北桃都會通購票及1280定期票退票服務，一機完成相當便利，依照螢幕上的說明，點選「購買都會通」或「1280公共運輸定期票退票」，再將悠遊卡放在感應平臺上，即可進入操作畫面。若票卡內仍有尚未到期的1280定期票，請先退票再購買基北北桃都會通。1280定期票是依照「經過日數」(啟用當日起算至最後一次使用日之日數)退費，只要7月1日後不使用1280定期票，就不會影響退費比例。「TPASS行政院通勤月票/基北北桃都會通」售價為1200元，購買時由悠遊卡扣除1200元並完成設定，若悠遊卡餘額不足時，請依設備提示加值完成後即可；悠遊聯名卡或悠遊Debit卡(含帳戶連結悠遊卡)開啟自動加值功能，即可在自動售票加值機選擇以自動加值方式購買。&nbsp;針對旅客需要的服務，臺北捷運已準備好了，全臺北捷運117個車站的：&nbsp;【諮詢服務】200個詢問處、16個臨時詢問處、1,070位服務同仁隨時提供「諮詢服務」。&nbsp;【購票、設定、退票服務】200個詢問處、16個臨時詢問處、645臺自動售票加值機、1,070位服務同仁隨時提供「購票、設定、退票服務」。&nbsp;【專屬通道】1,360個驗票閘門，每一個都是您的「專屬通道」。由交通部公路總局發行的TPASS行政院通勤月票，每張售價100元，即日起可至捷運各車站詢問處購買，就近於詢問處或自動售票加值機，完成「基北北桃都會通」購買設定。現在購買TPASS行政院通勤月票，並至悠遊卡公司網頁完成活動登錄，可享100元回饋(每人限領1次)，活動詳細辦法，請至悠遊卡官網查詢。除了「TPASS行政院通勤月票」，也可以使用未設定任何定期票的悠遊卡，至臺北捷運各車站自動售票加值機或詢問處，完成「基北北桃都會通」設定。臺北捷運公司網站已公告「TPASS行政院通勤月票/基北北桃都會通」使用須知及民眾常見問題，歡迎上網查詢；臺北捷運AI智慧客服「TPASS行政院通勤月票/基北北桃都會通」問答專區同步上架，歡迎多加利用。附錄【「基北北桃都會通」大補帖】◎適用範圍「基北北桃都會通」適用範圍包括：臺北捷運、新北捷運(含輕軌)、桃園機場捷運、基隆/新北/桃園市區公車、臺北市聯營公車及基北北桃範圍內的公路及國道客運。臺鐵適用範圍則有：縱貫線的基隆站至桃園市新富站，宜蘭線八堵站至福隆站，深澳支線及平溪支線，不限車種列車均適用；若具有專屬性及不發售無票座對號列車則不適用，例如：觀光、團體、太魯閣、普悠瑪、EMU3000列車等。新北市及臺北市YouBike 站點借車，前30分鐘免費；桃園市YouBike 站點借車，前60分鐘免費。◎購票方式及地點民眾可持悠遊卡、SuperCard超級悠遊卡（含TPASS）、電信悠遊卡、悠遊聯名卡或悠遊Debit卡(票卡效期需60天以上）、學生卡、數位學生證，至臺北捷運及桃園機場捷運各車站(A20興南站除外)、新北捷運設置詢問處的車站、臺鐵車站指定售票窗口、臺北市政府轉運站悠遊卡客服中心、國光客運(基隆站、臺北站、新北板橋轉運站、南港轉運站、桃園機場站及中壢站)悠遊卡售票加值機購買；至於Samsung Wallet悠遊卡，7月1日開放購票。◎適用票種目前僅開放悠遊卡設定，後續俟其他票證公司完成準備後，將陸續開放使用。至於敬老、愛心及優待卡等優惠票種，已依法提供大眾運輸搭乘優惠，因此無法設定「基北北桃都會通」。◎首次啟用期限及方式「基北北桃都會通」僅限一人使用，若超過30天未啟用，該票將失效，須辦理退費後重新購買（須加收手續費）。例如： 7月1日持悠遊卡購買，最遲必須於7月30日晚上12點前首次啟用。啟用方式非常簡單，將票卡輕觸捷運或臺鐵車站自動收費進站閘門，或公車、國道客運、公路客運、輕軌驗票機，即可啟用。「基北北桃都會通」無法於YouBike站點啟用，持卡人須先加入YouBike會員並以該悠遊卡卡號註冊，始可享臺北市及新北市YouBike站點借車前30分鐘免費、桃園市YouBike站點借車前60分鐘免費優惠。◎使用期間及續購方式「基北北桃都會通」有效期間為啟用日(含)起連續30日，可透過臺北捷運車站車票查詢機查詢，或於捷運、臺鐵閘門、輕軌及公車驗票機螢幕確認使用期限。例如：6月16日預購、7月1日啟用，有效期間為7月1日至7月30日。「基北北桃都會通」有效期間屆滿後，持卡人可再擇日重新購買，或者持原票卡在有效期間屆滿前10日起(即啟用後第21日)，至臺北捷運及桃園機場捷運各車站(A20興南站除外)、新北捷運設置詢問處的車站、臺鐵車站指定售票窗口、臺北市政府轉運站悠遊卡客服中心、國光客運(基隆站、臺北站、新北板橋轉運站、南港轉運站、桃園機場站及中壢站)悠遊卡售票加值機續購。使用SuperCard超級悠遊卡、Samsung Wallet悠遊卡等，可透過悠遊卡公司授權支付App辦理續購。例如：7月1日第一次使用「基北北桃都會通」，可自7月21日起續購，續購的「基北北桃都會通」將於原有效期限7月30日翌日（即7月31日）自動啟用，延長使用期限至8月29日。有效期間屆滿，民眾仍可持原票卡搭車，票卡則恢復原電子票證的計費方式。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=D15B0C0C069CAB7F",
      "StartTime": "2023-06-30T13:58:00+08:00",
      "EndTime": "2023-07-30T13:58:00+08:00",
      "PublishTime": "2023-06-30T13:58:00+08:00",
      "UpdateTime": "2023-06-30T13:58:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "9003741",
      "Title": "臺北捷運邀請合作廠商參與ESG課程 共同落實ESG精神 ",
      "NewsCategory": "新聞稿",
      "Description":
          "臺北捷運身為軌道運輸業之一員，近年來致力企業永續發展 ESG為經營目標，日前特別邀請中華民國企業永續發展協會秘書長莫冬立，在北捷捷韻國際廳舉辦「ESG發展趨勢與企業行動」講座，加強宣導推動ESG決心，讓公司同仁及合作供應商代表，對ESG能有進一步的認識，期許透過垂直與橫向溝通，達到員工、公司、供應商三者共生共榮，企業永續發展的目標。當日參與講習會議的供應商，共有100餘家廠商代表，包括西門子、神通資訊、台灣米其林、精誠資訊、漢翔航空、台灣奧的斯電梯、台灣新軻電子、工研院、萬成航空、台灣納博特斯克、台灣三菱電梯、台灣檢驗科技等，透過秘書長莫冬立的經驗分享，將全球商業市場對ESG的要求，分別以E(Environmental)環境保護、 S(Social)社會責任，以及G(Governance)公司治理等三面向區分，佐以相關案例說明，並鼓勵所有供應商推動ESG，提供勞工安全的工作環境，積極參與社會責任活動，及致力於環境保護等循環經濟措施，達到企業夥伴關係共榮共好。臺北捷運身為貫穿大臺北地區的重要交通命脈，肩負著「人本交通」、「綠色運具」的使命感，為了響應國家2050淨零排放政策及臺北市政府建構低碳城市的目標持續努力。今年臺北捷運榮獲第8屆「經濟部國家產業創新獎」的殊榮，肯定臺北捷運在「創新成就」、「產業高值化策略」、「國際競爭力優勢」、「履行社會責任」等各面向的表現。未來，臺北捷運將持續落實節能減碳，在不影響運輸本業的基礎上，嘗試做出更多綠色轉型的措施，善盡企業社會責任，和大眾共同面對日趨嚴峻的氣候變遷！-以下空白-",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=236CAC71636A8824",
      "StartTime": "2023-06-29T14:27:00+08:00",
      "EndTime": "2023-07-29T14:27:00+08:00",
      "PublishTime": "2023-06-29T14:27:00+08:00",
      "UpdateTime": "2023-06-29T14:27:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "8992797",
      "Title": "臺北捷運車站電視牆廣告內容 未來將以更嚴謹標準審視",
      "NewsCategory": "新聞稿",
      "Description":
          "有關本(8)日臺北市議會市政總質詢，議員關心忠孝復興站電視牆廣告內容，臺北捷運公司表示，將依市長指示，後續廣告審查，除廣告畫面外，包含背景音效、旁白或廣告語言等，均進行更嚴謹的審視，亦將民眾本次意見納入參考，降低可能引起的負面觀感。該廣告上刊時間為3月11日至4月10日，廣告內容經本公司依契約審查，已於上刊前要求將廣告內尖叫聲消除，另於3月15日、4月7日兩度降低現場設備音量。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=4A88D6FE434384C5",
      "StartTime": "2023-06-08T17:32:00+08:00",
      "EndTime": "2023-07-08T17:32:00+08:00",
      "PublishTime": "2023-06-08T17:32:00+08:00",
      "UpdateTime": "2023-06-08T17:32:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "8986144",
      "Title": "臺北捷運文湖線凌晨舉行多重災難模擬演練  加入塔吊墜落軌道情境 加強應變演練防範未然",
      "NewsCategory": "新聞稿",
      "Description":
          "為維護旅客安全，臺北捷運公司於27日凌晨進行文湖線多重災難模擬演練，動員臺北市政府捷運局、消防局、捷運警察隊及本公司行車處、站務處、工務處、工安處等10餘單位，約150人參與，演練過程逼真，於凌晨2時30分順利完成。臺北捷運公司表示，112年度文湖線多重災難模擬演練，同時加入臺中捷運塔吊意外的情境，模擬南港軟體園區站站外建案吊掛鋼樑時，因塔吊不堪負荷導致鋼樑及塔吊掉落至軌道區(南港軟體園區站往南港站覽館站)，上下行軌道皆有障礙物。營運期間，鄰近南港軟體園區站工地塔吊設施斷裂掉落站間軌道行駛路面。南港軟體園區站保全發現掉落物後阻止月臺上列車出發並通報站長，站長隨即壓下月臺緊急斷電鈕並通報行控中心，行控中心立即切斷軌道電力，對向列車仍煞車不及撞擊掉落物停於站間，並回傳障礙物、車門警訊，且電力設備亦有異常警訊。站長到達現場後回報列車撞擊軌道障礙物(塔吊)，有6名旅客受傷 (2名重傷、4名輕傷)，大型障礙物無法移除，且列車車頭窗戶破裂，偵障桿損壞，車門為半開啟及軌道電纜有破損狀況。站長疏散旅客至月臺，消防隊抵達車站，立即展開救援行動，車輛、號誌、供電、通訊、軌道及水電維修單位搶修人員陸續抵達現場，搶修設備並回報進度。此外，本次演練亦驗收日前修正的阻擋列車離站的應變作為，如前方軌道有異物侵入且危及系統安全時，車站人員或隨車人員可以立即阻擋車門或月臺門關閉、按下緊急斷電鈕切斷電力、或是下拉或上推列車內緊急逃生把手，優先阻止列車出發後回報行控中心；行控中心獲知軌道掉落物影響行車安全時，將立即按下緊急斷電鈕，切斷全線軌道電力。凌晨演練，臺北捷運公司總經理黃清信全程參與，除特別感謝市府各級長官及交通局指導，捷運工程局、消防局、捷運警察隊等市府相關單位投入演練外，並期許同仁落實演練情境及各相關單位橫向聯繫通報作業，唯有平日做好演練，意外來臨時才能儘速動員處理，維護旅客及系統安全。借鏡中捷事件，臺北捷運公司與市府局處相關單位，已加強捷運鄰近建案工地巡查，並精進應變程序及訓練、強化演練及優化設備等各項策進作為，以預防類似事件發生，目前北捷沿線高架平面段列管中的限建範圍內建案計有45件，其中8件設置塔吊進行吊掛作業，其他建案以移動式起重機(吊車)進行吊掛作業，均已納入巡檢監控。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=C2D69AA3ECB3965C",
      "StartTime": "2023-05-27T13:09:00+08:00",
      "EndTime": "2023-06-27T13:09:00+08:00",
      "PublishTime": "2023-05-27T13:09:00+08:00",
      "UpdateTime": "2023-05-27T13:09:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "8985580",
      "Title": "端午限定！強勢推出「北捷✕Miss V端午鳳梨夾心酥禮盒」 艾草、鹹蛋黃變身鳳梨夾心酥 甜甜蜜蜜過端午",
      "NewsCategory": "新聞稿",
      "Description":
          "臺北捷運公司首度與中山商圈知名甜點店「Miss V Bakery」攜手，推出「北捷✕Miss V端午鳳梨夾心酥禮盒」，即日起至6月9日止，於蝦皮商城「台北捷運官方直營店」 及「捷運商品館」臺北車站及中山店，「Miss V Bakery」赤峰、敦北與101店開放預購，內含端午獨家新口味「艾草鹹蛋黃鳳梨夾心酥」及「起司鹹蛋黃鳳梨夾心酥」各5入，歡迎搶先嘗鮮！&nbsp;「Miss V Bakery」發揮創意，將端午節門口懸掛的艾草及粽子必備的鹹蛋黃，製作成「端午限定」的艾草鹹蛋黃鳳梨夾心酥，豐富大家味蕾！香氣特殊的艾草，不僅可點燃作蚊香驅趕蚊蟲，也可食用入菜，將艾草加進奶油酥餅，搭配特選鹹蛋黃和依思尼奶油鳳梨餡，一口咬下的酥餅，既有鹹甜的口感，尾韻還帶著艾草特有的青草甘苦味，開啟味覺新世界。&nbsp;鹹香的帕瑪森起士粉，加入法國天然發酵奶油製作的奶油酥餅，夾上特選鹹蛋黃及拌入依思尼奶油的鳳梨餡，是回味再三的好味道。禮盒包裝設計亦別具巧思，以插畫風格描繪捷運沿線著名景點，其中穿插「Miss V Bakery」創立10週年以來經典點心插圖，文青又具質感，禮盒內更貼心附上點心介紹及捷運路網景點摺頁，兼具收藏及觀光導覽實用性。&nbsp;端午鳳梨夾心酥禮盒優惠價620元（原價720元），即日起至6月9日止，凡於「捷運商品館」臺北車站及中山店、蝦皮商城「台北捷運官方直營店」下單預購，即送可愛「粽子造型毛巾」1條（數量有限送完為止）。&nbsp;此外，「捷運商品館」臺北車站及中山店預購者，再享加碼抽好禮活動，含25週年限定造型悠遊卡、手搖磨豆機、財神到站發財金、捷運磁鐵及粽子造型毛巾等，贈品數量有限送完為止。預購商品將於6月12日至22日期間，開放取貨或配送。&nbsp;即日起至6月7日止，「台北捷運」臉書粉絲專頁上，按讚追蹤並於活動貼文留言，標註2名好友及寫下指定內容，有機會抽中「北捷✕Miss V端午鳳梨夾心酥禮盒」或「粽子造型毛巾」，相關訊息請務必持續關注臉書粉絲專頁。&nbsp;「捷運商品館」忠孝復興、南京復興、臺北車站及中山店，6月亦推出消費滿888元，即可以8折優惠購買限定悠遊卡活動，另有捷運紀念POLO衫買一送一的好康，把握機會先搶先贏。&nbsp;相關資訊可洽詢本公司24小時客服專線：（02）218-12345，或臺北市民當家熱線1999(外縣市02-27208889)或瀏覽本公司網站（https://www.metro.taipei/）。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=253FC29BEECA5AD4",
      "StartTime": "2023-05-26T10:06:00+08:00",
      "EndTime": "2023-06-26T10:06:00+08:00",
      "PublishTime": "2023-05-26T10:06:00+08:00",
      "UpdateTime": "2023-05-26T10:06:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "8981703",
      "Title": "跟著臺北捷運METRO FUN 一起玩！度假首選「北投會館」捷之旅　住宿、玩樂、美食全包辦",
      "NewsCategory": "新聞稿",
      "Description":
          "搭乘捷運來趟城市輕旅行！臺北捷運公司規劃「METRO FUN跟我一起玩」YouTube節目，介紹捷運沿線景點或店家，臺灣小姐Joyce擔任主持人，跟著臺北捷運METRO FUN一起玩！本集美麗的Joyce要帶大家去「都會秘境」，隱身在臺北捷運機廠的北投會館「捷之旅」，不論是身心放鬆還是美食享受，都能Have FUN！精采影片請到臺北捷運YouTube頻道觀看，看完還可以參加抽獎，有「捷之旅」免費住宿券、「桂華軒」豆腐水煮牛兌換券、北投會館暨逃生體驗營免費體驗券等好禮，活動只到5月23日止。抽獎活動請到臺北捷運FaceBook粉絲專頁。臺北捷運「北投會館」，緊鄰捷運淡水信義線「復興崗站」，鄰近北投溫泉區，面向關渡平原、遠眺陽明山，提供雅潔舒適的住宿環境，令您身心舒暢。園區內有知名潮廣料理「桂華軒」、健身房、游泳池等休閒設施，還有富有教育意義的「捷運逃生體驗營」，提供一站式體驗，全年齡層都適合的輕旅行。入住北投會館「捷之旅」，可以免費使用室內游泳池、健身房設施，讓旅途中的身心都能夠得到完全放鬆。完善的健身設施，還包括桌球、撞球、籃球、羽球、迴力球及兒童遊樂場等，豐富的運動休閒項目，專業明亮的設施與空間，可以盡情享受運動的樂趣。北捷獨家特色「捷運逃生體驗營」，設有擬真詢問處、動態模擬駕駛遊戲、隧道逃生區、列車逃生區、車站逃生室、濃煙體驗室、AR彩繪列車等。以寓教於樂方式，透過各項擬真設施，瞭解捷運系統設備，並學習防災、逃生知識，讓民眾學習如何應對危險和緊急情況。最後，別忘了到北投會館「桂華軒」餐廳大快朵頤！擁有多年的經驗和精湛的技藝，提供精緻潮廣料理，特別推薦餐廳的招牌菜「紅袍掛爐烤鴨」，一鴨三吃，肥美酥脆烤鴨，讓食客感受到不同的變化和風味，是「桂華軒」不可錯過的招牌菜之一。探索更多吃喝玩樂大小事，歡迎訂閱臺北捷運YouTube頻道，鎖定「METRO FUN跟我一起玩」遊臺北。相關訊息請洽詢本公司24小時客服專線：（02）218-12345，或臺北市民當家熱線1999(外縣市02-27208889)或瀏覽本公司網站(https://www.metro.taipei/)。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=54EE7C864EEC4FEA",
      "StartTime": "2023-05-17T09:41:00+08:00",
      "EndTime": "2023-06-17T09:41:00+08:00",
      "PublishTime": "2023-05-17T09:41:00+08:00",
      "UpdateTime": "2023-05-17T09:41:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "9018538",
      "Title": "臺北捷運展開防颱布署 嚴陣以待杜蘇芮颱風",
      "NewsCategory": "新聞稿",
      "Description":
          "因應杜蘇芮颱風可能帶來的雨勢及強風，臺北捷運公司已依據防颱防洪SOP，展開防颱布署及應變準備，確保颱風期間捷運系統和旅客安全，並持續密切注意颱風動向。颱風期間營運訊息將透過臺北市政府及臺北捷運公司網站、「台北捷運Go」App、車站旅客資訊系統、廣播系統、張貼告示及媒體宣導等方式公告。&nbsp;颱風瞬間陣風達一定程度，捷運系統、貓空纜車及兒童新樂園即會暫停營運，請民眾注意：&nbsp;淡水信義線、松山新店線（小碧潭站）、文湖線等路線的高架及平面段，當實際瞬間風速達10級風以上，或10分鐘內之平均風速達7級風時，即依照標準作業程序暫停營運；中和新蘆線、板南線，以及松山新店線、淡水信義線等地下段部分，仍將繼續運轉，並依人潮狀況彈性調整營運班距。&nbsp;此外，貓空纜車當發布陸上颱風警報(警戒區域含臺北地區)後，將視風雨情況決定是否暫停營運；若臺北市政府宣布停止上班或上課，將暫停營運。&nbsp;兒童新樂園當發布陸上颱風警報(警戒區域含臺北地區)後，將視風雨情況決定遊樂設施是否暫停營運；若臺北市政府宣布停止上班或上課，將暫停營運。&nbsp;為預防颱風帶來豪雨，捷運全系統（包括捷運機廠、車站，及停車場、地下商店街）、貓空纜車、兒童新樂園及臺北小巨蛋，均已加強檢視各項防洪設備，如防洪閘門及抽水機等，並完成防颱整備作業。&nbsp;長達7個月的防汛期（5月至11月），北捷啟動各場站防汛整備及強化防汛設施設備檢視、測試作業，無論小如手提式抽水機，大至隧道內全斷面防水隔艙閘門，均有一套完整保養測試及訓練SOP，確保防洪設施設備功能運作妥善。颱風期間也將透過中央氣象局及經濟部水利署網頁監看即時雨量，另隨時監測捷運周邊河川如基隆河、新店溪、大漢溪水位警戒情形，納入營運模式及是否停止營運參考。&nbsp;臺北捷運各車站出入口，依捷運防洪設計高程為200年頻率洪水位加高110公分，提升防洪能力，另部分重要車站隧道設置有防水隔艙閘門，避免因捷運隧道經過斷層帶、過河段或出土段等可能湧水處，造成洪水侵入隧道並漫延至捷運沿線各車站，形成重大損失。&nbsp;相關營運資訊請瀏覽本公司網站(https://www.metro.taipei) 或洽本公司24小時客服專線：（02）218-12345，或臺北市民當家熱線1999(外縣市02-27208889)。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=4F71CED7679EBD0F",
      "StartTime": "2023-07-23T12:37:00+08:00",
      "EndTime": "2023-08-23T12:37:00+08:00",
      "PublishTime": "2023-07-23T12:37:00+08:00",
      "UpdateTime": "2023-07-23T12:37:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "9007332",
      "Title":
          "最夯的「斯巴達障礙跑訓練賽」專屬捷運會員    8月北投會館登場    手刀加入「台北捷運Go」App會員    7月16日前登記抽報名資格",
      "NewsCategory": "新聞稿",
      "Description":
          "會員們運動囉！臺北捷運公司與美國知名運動賽事品牌「SPARTAN斯巴達障礙跑」合作，將於8月19日至8月27日期間假日，推出「斯巴達障礙跑訓練賽」捷運會員專屬場。在北投會館戶外空間及林地裡佈設多項最夯的戶外體能挑戰關卡，更邀請專業體適能教練帶領，此外還有隱藏版神祕關卡，歡迎大小朋友趁暑假一起來闖關動一動，挑戰自已！&nbsp;即日起至7月16日止，手機下載「台北捷運Go」App加入會員，於活動頁面點選「點我登記」，即可參加抽獎，有機會獲得8月19日、20日、26日及27日報名資格。每位幸運得獎者，可分別獲得小勇士組(4至14歲)、15歲以上組，2組別各1位報名參賽資格，歡迎喜愛戶外運動賽事的民眾與親子們踴躍參加，鍛鍊體力、意志力。與親朋好友一起深入北投會館，體驗不同的會員活動。&nbsp;除了最潮的戶外運動斯巴達，小勇士組(4至14歲)更有部分名額結合「北投會館逃生體驗營」中最熱門的設施「一日司機員-捷運駕駛體驗」。讓小勇士們先挑戰排除列車行駛中遇到的障礙關卡；再到戶外參與障礙跑訓練賽。讓來到捷運大本營的你，體驗豐富，收穫滿滿。&nbsp;得獎名單將於7月18日於活動臉書公告，並以簡訊通知，當天也會揭曉隱藏版神秘關卡。抽中報名資格的會員，須於7月19日至30日期間，至「台北捷運Go」App活動頁面，依照年齡組別(4至14歲小勇士組別、15歲以上組別)，各挑選1場次報名體驗；也可選擇只報名其中1組體驗。&nbsp;例如，爸爸抽中報名資格，除了替自己報名「斯巴達障礙跑訓練賽」外，還可以幫一名4至14歲的孩童，報名「小勇士訓練賽」或「捷運駕駛體驗x小勇士訓練賽」體驗。8月活動現場，也開放親友免費到場觀賽，替小勇士們加油歡呼。&nbsp;活動賽道係沿著北投會館園區設計，規劃多項體能訓練挑戰關卡，每位參加者僅需於報到時繳交該項目之場地維護費即可體驗，依年齡區分體驗項目如下：&nbsp;◎斯巴達障礙跑訓練賽限15歲以上民眾參加，賽道長約800公尺，沿途設置6項關卡，包括訓練翻越攀爬能力的「O.U.T.全面進攻」、訓練握力及臂力的「Monkey Bar飛猴單槓」、訓練全身肌耐力的「Jerry can Carry扛水袋」、運用四肢貼近地面的「Cord Crawl匍匐前進」，同時還有World Gym教練帶領民眾體驗「ViPR火箭推」及形狀像籃球的「Medicine Ball藥球」等訓練。每人場地維護費50元。&nbsp;◎小勇士訓練賽限4至14歲學童參加，10歲(含)以下兒童須由1位家長陪跑。賽道長約800公尺，設置6項關卡，包括訓練握力與攀爬技巧的「Slip Wall勝券在握」、訓練攀爬能力的「A Frame Cargo A型架」、考驗體力與手臂力的「Sandbag Carry抱沙包」、運用四肢貼近地面的「Cord Crawl匍匐前進」、跳輪胎及翻輪胎等。每人場地維護費50元。&nbsp;◎捷運駕駛體驗x小勇士訓練賽4至14歲學童先至「北投會館逃生體驗營」於擬真的捷運車廂內，化身為一日司機員，參與捷運駕駛體驗、排除列車行駛中遇到的障礙，有趣好玩，還可自行參觀逃生體驗營其他設施(12歲(含)以下兒童須由1位家長陪同進入逃生體驗營)。接著再參加小勇士訓練賽，挑戰6項關卡，征服體能的考驗。每人場地維護費80元。&nbsp;體能挑戰後犒賞自己，到北投會館「桂華軒」餐廳大快朵頤！擁有多年經驗和精湛廚藝，提供各式精緻潮廣料理，特別推薦餐廳的招牌菜「紅袍掛爐烤鴨」，一鴨三吃，肥美酥脆烤鴨，讓食客感受到不同的變化和風味，是「桂華軒」不可錯過的招牌菜之一。&nbsp;此外，暑假期間北投會館「捷之旅」推出的「一童趣FUN假」限定優惠，訂房就送量臺北市兒童新樂園一日樂FUN券、美食餐券、「北捷列車微型積木」及「北捷Q版職人悠遊房卡」，活動詳情可查詢KKday線上旅遊平台。「捷之旅」鄰近北投溫泉區，面向關渡平原、遠眺陽明山，提供雅潔舒適的住宿環境，住宿期間內，可免費使用健身房、游泳池及免費預約參加「捷運逃生體驗營」，住宿、玩樂、休閒一次包辦。&nbsp;8月19日、20日、26日及27日活動當天，還有「2023捷運盃街舞大賽嘻哈嘉年華」活動，非常熱鬧。更詳細豐富的內容請持續關注捷運這樣玩臉書 、臺北捷運臉書 ，或洽詢本公司24小時客服專線：（02）218-12345，或臺北市民當家熱線1999(外縣市02-27208889)或瀏覽本公司網站（ https://www.metro.taipei/）。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=FB45055A6CECCB83",
      "StartTime": "2023-07-05T09:44:00+08:00",
      "EndTime": "2023-08-05T09:44:00+08:00",
      "PublishTime": "2023-07-05T09:44:00+08:00",
      "UpdateTime": "2023-07-05T09:44:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "8999821",
      "Title": "「基北北桃都會通」現正預購中 傳授「速購法」方便又省時   多多利用自動售票加值機 「預先購買、延後退費」好輕鬆",
      "NewsCategory": "新聞稿",
      "Description":
          "眾所期待的端午連假即將開始，開心出門遊玩前，先來臺北捷運各車站，預購定價1200元的「基北北桃都會通」，7月1日起即可使用。首次購買的民眾，歡迎攜帶無設定任何定期票的悠遊卡或TPASS悠遊卡，到捷運各車站自動售票加值機或詢問處，預購「基北北桃都會通」；至於目前使用1280定期票的旅客，亦可先使用TPASS或另一張悠遊卡，利用自動售票加值機或至詢問處，優先預購「基北北桃都會通」，省時省錢好方便。【先買】預先購買基北北桃都會通臺北捷運公司表示，捷運全線超過600臺自動售票加值機開放預購服務，為方便民眾快速設定，螢幕上特別使用放大版的「綠色圖示」，讓大家一眼就可輕鬆選定預購選項，不用費時尋找；點選圖示後，再將悠遊卡放在加值平臺上，進入預購畫面後依序操作，立即完成預購。由交通部公路總局發行的TPASS悠遊卡，每張售價100元，即日起可至捷運各車站詢問處購買TPASS悠遊卡，就近於詢問處或自動售票加值機，完成「基北北桃都會通」預購。現在購買TPASS悠遊卡，並至悠遊卡公司網頁完成活動登錄，可享100元回饋(每人限領1次)，活動詳細辦法，請至悠遊卡官網查詢。除了選擇「TPASS悠遊卡」，也可以使用未設定任何定期票的悠遊卡，至臺北捷運各車站自動售票加值機或詢問處，完成「基北北桃都會通」預購。「基北北桃都會通」售價為1200元，購買時由悠遊卡扣除1200元並完成預購設定，若悠遊卡餘額不足時，請依設備提示加值完成後即可預購設定；悠遊聯名卡或悠遊Debit卡(含帳戶連結悠遊卡)開啟自動加值功能，即可在自動售票加值機選擇以自動加值方式預購。「基北北桃都會通」7月1日正式啟用，為避免民眾集中在7月1日購買，造成現場排隊或久候的情形，歡迎大家多多利用假日，先行預購「基北北桃都會通」，7月1日起直接持票卡走進車站，輕觸收費閘門立即啟用。【後退】延後退費1280定期票原先使用1280定期票的旅客，因一張卡片只能設定一種定期票，建議旅客可以購買TPASS或使用另一張悠遊卡，在7月1日之前，先到車站完成「基北北桃都會通」預購；等到7月1日之後，再辦理1280定期票退費。尚未到期的1280定期票，依照票卡「經過日數」比例退費，只要7月1日後不使用1280定期票，就不會影響退費金額。為服務1280定期票旅客，臺北捷運特別推出3種退費方式，第1種為利用定期票退票線上申請網頁退費，利用手機或電腦即可完成，相關退費規定，請瀏覽臺北捷運網站。第2種退費方式，至車站使用自動售票加值機，點選螢幕上的「1280公共運輸定期票退票」退費功能辦理；至於第3種退費方式，則是親自前往各捷運站詢問處辦理。選擇2、3種方式的旅客，建議利用假日或離峰時段前往車站辦理，避免現場排隊或久候。為協助民眾輕鬆購票，即日起至6月30日的工作日17時至20時，在淡水、新埔、海山、府中、亞東醫院、板橋、景安(中和新蘆線)、蘆洲、市政府、西門、臺北車站、松山、南港、北門、圓山等定期票熱門銷售車站及重要轉乘站，均加派支援人力，穿著黃色背心接受旅客洽詢，宣導期間將視車站預購狀況隨時調整。臺北捷運公司網站已公告「基北北桃都會通」使用須知及民眾常見問題，歡迎上網查詢；臺北捷運AI智慧客服「基北北桃都會通」問答專區已同步上架，歡迎多加利用。附錄【「基北北桃都會通」大補帖】◎適用範圍「基北北桃都會通」適用範圍包括：臺北捷運、新北捷運(含輕軌)、桃園機場捷運、基隆/新北/桃園市區公車、臺北市聯營公車及基北北桃範圍內的公路及國道客運。臺鐵適用範圍則有：縱貫線的基隆站至桃園市新富站，宜蘭線八堵站至福隆站，深澳支線及平溪支線，不限車種列車均適用；若具有專屬性及不發售無票座對號列車則不適用，例如：觀光、團體、太魯閣、普悠瑪、EMU3000列車等。新北市及臺北市YouBike&nbsp;站點借車，前30分鐘免費；桃園市YouBike&nbsp;站點借車，前60分鐘免費。◎購票方式及地點民眾可持悠遊卡、SuperCard超級悠遊卡（含TPASS）、電信悠遊卡、悠遊聯名卡或悠遊Debit卡(票卡效期需60天以上）、學生卡、數位學生證，自6月15日起至臺北捷運及桃園機場捷運各車站(A20興南站除外)、新北捷運設置詢問處的車站、臺鐵車站指定售票窗口(6月27日開放購票)、臺北市政府轉運站悠遊卡客服中心、國光客運(基隆站、臺北站、新北板橋轉運站、南港轉運站、桃園機場站及中壢站)悠遊卡售票加值機購買；至於Samsung Wallet悠遊卡，7月1日開放購票。◎適用票種目前僅開放悠遊卡設定，後續俟其他票證公司完成準備後，將陸續開放使用。至於敬老、愛心及優待卡等優惠票種，已依法提供大眾運輸搭乘優惠，因此無法設定「基北北桃都會通」。◎首次啟用期限及方式「基北北桃都會通」僅限一人使用，若超過30天未啟用，該票將失效，須辦理退費後重新購買（須加收手續費）。例如：&nbsp;7月1日持悠遊卡購買，最遲必須於7月30日晚上12點前首次啟用。啟用方式非常簡單，將票卡輕觸捷運或臺鐵車站自動收費進站閘門，或公車、國道客運、公路客運、輕軌驗票機，即可啟用。「基北北桃都會通」無法於YouBike站點啟用，持卡人須先加入YouBike會員並以該悠遊卡卡號註冊，始可享臺北市及新北市YouBike站點借車前30分鐘免費、桃園市YouBike站點借車前60分鐘免費優惠。◎使用期間及續購方式「基北北桃都會通」有效期間為啟用日(含)起連續30日，可透過臺北捷運車站車票查詢機查詢，或於捷運、臺鐵閘門、輕軌及公車驗票機螢幕確認使用期限。例如：6月16日預購、7月1日啟用，有效期間為7月1日至7月30日。「基北北桃都會通」有效期間屆滿後，持卡人可再擇日重新購買，或者持原票卡在有效期間屆滿前10日起(即啟用後第21日)，至臺北捷運及桃園機場捷運各車站(A20興南站除外)、新北捷運設置詢問處的車站、臺鐵車站指定售票窗口、臺北市政府轉運站悠遊卡客服中心、國光客運(基隆站、臺北站、新北板橋轉運站、南港轉運站、桃園機場站及中壢站)悠遊卡售票加值機續購。使用SuperCard超級悠遊卡、Samsung Wallet悠遊卡等，可透過悠遊卡公司授權支付App辦理續購。例如：7月1日第一次使用「基北北桃都會通」，可自7月21日起續購，續購的「基北北桃都會通」將於原有效期限7月30日翌日（即7月31日）自動啟用，延長使用期限至8月29日。有效期間屆滿，民眾仍可持原票卡搭車，票卡則恢復原電子票證的計費方式。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=A0CAAABC5A1D29C6",
      "StartTime": "2023-06-21T09:31:00+08:00",
      "EndTime": "2023-07-21T09:31:00+08:00",
      "PublishTime": "2023-06-21T09:31:00+08:00",
      "UpdateTime": "2023-06-21T09:31:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "8999199",
      "Title": "臺北捷運化身空間魔術師！繼龐巴迪列車改善後 文湖線馬特拉列車空間優化 試辦3列車拆除部分車廂座椅 增加旅客乘車站立空間",
      "NewsCategory": "新聞稿",
      "Description":
          "為進一步提升文湖線尖峰時段運能，臺北捷運試辦馬特拉(VAL256)車型空間優化，除第1、4節車廂則維持不變外，第2、3節車廂的中央區域座椅及行李架全數拆除，每列車的總載客數從約400名增加至約420名。臺北捷運公司表示，本項措施為試辦性質，目前已完成3部列車空間改造，即日起上線，將密切觀察文湖線實際輸運情形予以調整。&nbsp;臺北捷運參考新加坡、紐約等國外地鐵作法，試辦改裝3列馬特拉(VAL256)列車，提升車廂容納空間。每列車共有4節車廂，每節車廂有20個座位，在符合電聯車原廠規範的前提下，鎖定第2、3節人潮較多的車廂，保留前後端的8個博愛座，拆除中間區域的12個座位；至於第1、4節車廂則維持原有座位數不變，有座椅需求的旅客可多利用第1、4節車廂。&nbsp;第2、3節車廂，除了拆除車廂座椅，原有行李架一併拆除，並於車廂兩側增設橫向扶手，車廂頂部加裝16組手拉環供旅客使用，兼顧乘車安全及多功能性。&nbsp;此外，第1、4節車門旁扶手寬度從48公分縮減為26公分狹長型樣式，勻出更多空間，讓動線更加順暢；第1至第4節車廂車門前的部分立柱移除，輪椅、行李箱及嬰兒車進出更便利。&nbsp;臺北捷運首次嘗試推動車廂擁擠度管理觀念，加強宣導旅客充分使用車廂內部空間，本次改裝的3列車，車廂頂部及地板均張貼「請往車廂內部移動」、「下車等候區」宣導指標，分流上下車旅客，讓動線更加順暢。呼籲大家發揮禮讓精神，進入車廂後請記得抬頭，跟著藍色箭頭移動到車廂中央乘車；快到站前再遵循黃色的下車等候區指標，在車門前方準備下車。&nbsp;目前文湖線尖峰整體最高流量，以112年5月為例，早尖峰站間流量最高為忠孝復興站上行(往南港展覽館方向)，每小時約1萬3000人次，晚尖峰站間流量最高為南京復興站下行(往動物園方向)，每小時約1萬2000人次。&nbsp;為加強疏運文湖線尖峰人潮，臺北捷運今(112)年2月18日起，延長尖峰最密班距時段，並於今年1月完成改裝龐巴迪(BT370)車型座椅及部分行李架拆除，最尖峰時段每小時可增加約1,000人次載客量，以多管齊下方式，紓解文湖線部分車站擁塞情形。&nbsp;臺北捷運將持續加強管制與疏導尖峰人流，宣導旅客月台上分散候車，搭乘時多多往車廂內部移動，透過旅客自助互助，和臺北捷運一起努力，改善文湖線尖峰時段擁擠情形，提升搭乘舒適度。&nbsp;詳情可洽詢臺北捷運24小時客服專線：（02）218-12345，或臺北市民當家熱線1999(外縣市02-27208889)或瀏覽本公司網站（https://www.metro.taipei/ ）。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=86F98235BC105C44",
      "StartTime": "2023-06-20T10:03:00+08:00",
      "EndTime": "2023-07-20T10:03:00+08:00",
      "PublishTime": "2023-06-20T10:03:00+08:00",
      "UpdateTime": "2023-06-20T10:03:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "8998593",
      "Title":
          "貓空纜車重磅回歸 年度大修順利完成 6月22日恢復營運 購買「貓纜暢遊一日票」贈送造型棉花糖或貓空霜淇淋 暑假期間下午4時後 從貓纜動物園進站只要50元",
      "NewsCategory": "新聞稿",
      "Description":
          "貓空纜車年度大修可望順利完成，將於6月22日重磅回歸！適逢端午節連假恢復營運，想計畫郊外踏青出遊，不妨來趟搭貓纜遊貓空的低碳輕旅行。&nbsp;貓纜每年均依原廠建議，視各項設備的檢修週期，安排年度大修作業，以確保系統安全及穩定性。今年度大修及相關必要測試等作業共歷時14天，包含更換張緊液壓缸、救援馬達、迂迴輪襯墊、緊急煞車控制單元、轉轍器電動缸及軸承等設備改善與更新以及迂迴輪非破壞檢測工作；持續進行專案則包含動物園站屋頂修繕及T15~T17塔柱除鏽上漆，最後將進行電氣測試、載重測試及系統運轉測試，以確保系統安全無虞，再提供旅客搭乘。&nbsp;維修保養期間，因貓纜常遇山區落雷或強風，若無法進行戶外檢修，維修人員亦將立即調整工作，持續進行室內週轉件備品保養或翻修，並於隔日以提早上工方式補足戶外工作進度，以期能順利完成作業，準時提供運輸服務。&nbsp;為歡慶貓纜順利恢復營運，貓空纜車推出購買「貓纜暢遊一日票」贈送造型花式棉花糖或貓空霜淇淋優惠活動。6月22日至8月31日止，凡現場購買「貓纜暢遊一日票」，可選擇造型花式棉花糖的兌換序號，旅客持兌換序號至貓空站出站閘門口棉花糖機，可免費兌換1支造型花式棉花糖（售價100元，每日限量50支）；或選擇貓空限定霜淇淋1支免費兌換券，旅客持兌換券可至貓空站外指定商家，免費兌換1支霜淇淋（售價90元，每日限量100支，總計3千支），讓旅客搭乘纜車享受甜蜜蜜的快樂。未來亦將陸續不定期增加免費贈送的美食品項，最新活動可至貓空纜車官網查詢。&nbsp;另外，暑期期間為鼓勵家庭、親子及學生出外旅遊，貓纜推星光票活動，凡7月1日至8月31日期間，每日下午4時後，由貓纜動物園進站搭車的旅客，可享一趟50元星光票優惠（返程維持原價），在夏日傍晚搭乘纜車較為涼爽，推薦旅客可到貓空周邊茶行或風味茶餐廳，在山林中享受高貴又不貴的品茗或特色茶餐；隨著夜色來臨，還可欣賞貓空站光環境之美，置身在國際燈光大師周鍊精心打造的光環境，利用光影投射、色溫呈現站體的空間深度和多元層次，與夜間點點星空相互輝映，貓空站已漸漸成為熱門打卡景點之一。&nbsp;相關資訊可洽詢本公司24小時客服專線：（02）218-12345，或臺北市民當家熱線1999(外縣市02-27208889)或瀏覽本公司網站（https://www.metro.taipei/ ）。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=23A1FB13D6282385",
      "StartTime": "2023-06-19T09:59:00+08:00",
      "EndTime": "2023-07-19T09:59:00+08:00",
      "PublishTime": "2023-06-19T09:59:00+08:00",
      "UpdateTime": "2023-06-19T09:59:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "8995951",
      "Title": "基北北桃1200都會通定期票即日起開放預購 使用TPASS或悠遊卡 至各捷運車站詢問處或自動售票加值機辦理",
      "NewsCategory": "新聞稿",
      "Description":
          "臺北市市長蔣萬安今(15)日在捷運市政府站化身一日站務員，提醒大家「基北北桃1200都會通定期票」正式開始預購。即日起，民眾可持交通部公路總局發行的TPASS或未設定任何定期票的悠遊卡，至臺北捷運各車站詢問處或自動售票加值機，辦理1200都會通定期票預購，並於7月1日起啟用。&nbsp;【先買】預先購買基北北桃1200都會通定期票選擇1：超商取貨或車站購買TPASS 輕鬆預購1200都會通定期票由交通部公路總局發行的TPASS悠遊卡，每張售價100元，已於5月18日起，開放民眾至四大超商預購，並於6月15日起取貨；拿到預購TPASS悠遊卡的民眾，即可至捷運車站詢問處或自動售票加值機，完成1200都會通定期票預購。至於未在超商預購TPASS悠遊卡的民眾，即日起亦可至捷運各車站詢問處購買TPASS悠遊卡，並就近於詢問處或自動售票加值機，完成1200都會通定期票預購。TPASS悠遊卡於捷運車站首波發行兩萬張，後續將分批到貨。&nbsp;&nbsp;選擇2：使用悠遊卡 至詢問處或自動售票加值機均可預購民眾亦可使用未設定任何定期票的悠遊卡，至臺北捷運各車站詢問處或自動售票加值機辦理1200都會通定期票預購。為避免民眾久候，捷運全線超過600臺自動售票加值機同步開放預購服務，操作方式非常簡單，依照自動售票加值機螢幕上的說明，點選「購買都會通」，再將悠遊卡放在感應平臺上，便可進入預購畫面，建議大家多多利用自動售票加值機辦理，方便又省時。&nbsp;基北北桃1200都會通定期票售價為1200元，購買時由悠遊卡扣除1200元並完成預購設定，若悠遊卡餘額不足時，請依設備提示加值完成後即可預購設定；悠遊聯名卡或悠遊Debit卡(含帳戶連結悠遊卡)開啟自動加值功能，即可在自動售票加值機選擇以自動加值方式預購。&nbsp;【後退】延後退費1280定期票方法1：1280定期票 線上退費超方便原先使用1280定期票的旅客，因一張卡片只能設定一種定期票，如果沒有擴大使用範圍需求，票卡可沿用至期滿為止，再轉換基北北桃1200都會通定期票。為方便民眾辦理退費，避開捷運車站退費人潮，歡迎利用定期票退票線上申請網頁退費，相關退費規定，可瀏覽臺北捷運網站(https://reurl.cc/zY8kpy )。&nbsp;方法2：善用假日及離峰時段 避開人潮輕鬆退假如手邊沒有第二張票卡，建議7月1日和7月2日或其他離峰人潮較少的時段，至各捷運站詢問處辦理1280定期票退費，或利用自動售票加值機，點選螢幕上的「1280公共運輸定期票退票」退費；退完費之後，接著直接在詢問處或利用自動售票加值機，完成1200都會通定期票預購。&nbsp;尚未到期的1280定期票，係依照票卡「經過日數」比例退費，只要7月1日後不使用1280定期票，就不會影響退費金額。&nbsp;為協助民眾輕鬆購票，即日起至6月30日的工作日17時至20時，在淡水、新埔、海山、府中、亞東醫院、板橋、景安(中和新蘆線)、蘆洲、市政府、西門、臺北車站、松山、南港、北門、圓山等定期票熱門銷售車站及重要轉乘站，均加派支援人力，穿著黃色背心接受旅客洽詢，宣導期間將視車站預購狀況隨時調整。&nbsp;臺北捷運公司網站已公告基北北桃1200都會通定期票使用須知及民眾常見問題，歡迎上網查詢；臺北捷運AI智慧客服「基北北桃1200都會通定期票問答專區」已同步上架，歡迎多加利用。-以下空白-&nbsp;&nbsp;附錄【基北北桃1200都會通定期票大補帖】◎適用範圍「基北北桃1200都會通定期票」適用範圍包括：臺北捷運、新北捷運(含輕軌)、桃園機場捷運、基隆/新北/桃園市區公車、臺北市聯營公車及基北北桃範圍內的公路及國道客運。臺鐵適用範圍則有：縱貫線的基隆站至桃園市新富站，宜蘭線八堵站至福隆站，深澳支線及平溪支線，不限車種列車均適用；若具有專屬性及不發售無票座對號列車則不適用，例如：觀光、團體、太魯閣、普悠瑪、EMU3000列車等。新北市及臺北市YouBike&nbsp;站點借車，前30分鐘免費；桃園市YouBike&nbsp;站點借車，前60分鐘免費。&nbsp;◎購票方式及地點民眾可持悠遊卡、SuperCard超級悠遊卡（含TPASS）、電信悠遊卡、悠遊聯名卡或悠遊Debit卡(票卡效期需60天以上）、學生卡、數位學生證，自6月15日起至臺北捷運及桃園捷運各車站(A20興南站除外)、新北捷運設置詢問處的車站、臺鐵車站指定售票窗口(7月1日開放購票)、臺北市政府轉運站悠遊卡客服中心、國光客運(基隆站、臺北站、新北板橋轉運站、南港轉運站、桃園機場站及中壢站)悠遊卡售票加值機購買；至於Samsung Wallet悠遊卡，7月1日開放購票。&nbsp;◎適用票種目前僅開放悠遊卡設定，後續俟其他票證公司完成準備後，將陸續開放使用。至於敬老、愛心及優待卡等優惠票種，已依法提供大眾運輸搭乘優惠，因此無法設定基北北桃1200都會通定期票。&nbsp;◎首次啟用期限及方式基北北桃1200都會通定期票僅限一人使用，若超過30天未啟用，該票將失效，須辦理退費後重新購買（須加收手續費）。例如：&nbsp;7月1日持悠遊卡購買，最遲必須於7月30日晚上12點前首次啟用。啟用方式非常簡單，將票卡輕觸捷運或臺鐵車站自動收費進站閘門，或公車、國道客運、公路客運、輕軌驗票機，即可啟用。基北北桃1200都會通定期票無法於YouBike站點啟用，持卡人須先加入YouBike會員並以該悠遊卡卡號註冊，始可享臺北市及新北市YouBike站點借車前30分鐘免費、桃園市YouBike站點借車前60分鐘免費優惠。&nbsp;◎使用期間及續購方式基北北桃1200都會通定期票有效期間為啟用日(含)起連續30日，可透過臺北捷運車站車票查詢機查詢，或於捷運、臺鐵閘門、輕軌及公車驗票機螢幕確認使用期限。例如：6月16日持悠遊卡預購設定1200都會通，7月1日啟用，有效期間為7月1日至7月30日。基北北桃1200都會通定期票有效期間屆滿後，持卡人可再擇日重新購買，或者持原票卡在有效期間屆滿前10日起(即啟用後第21日)，至臺北捷運及桃園捷運各車站(A20興南站除外)、新北捷運設置詢問處的車站、臺鐵車站指定售票窗口、臺北市政府轉運站悠遊卡客服中心、國光客運(基隆站、臺北站、新北板橋轉運站、南港轉運站、桃園機場站及中壢站)悠遊卡售票加值機續購。使用SuperCard超級悠遊卡、Samsung Wallet悠遊卡等，可透過悠遊卡公司授權支付App辦理續購。例如：7月1日第一次使用基北北桃1200都會通定期票，可自7月21日起續購，續購的基北北桃1200都會通定期票將於原有效期限7月30日翌日（即7月31日）自動啟用，延長使用期限至8月29日。有效期間屆滿，民眾仍可持原票卡搭車，票卡則恢復原電子票證的計費方式。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=6BB5C02BE0D86292",
      "StartTime": "2023-06-15T11:06:00+08:00",
      "EndTime": "2023-07-15T11:06:00+08:00",
      "PublishTime": "2023-06-15T11:06:00+08:00",
      "UpdateTime": "2023-06-15T11:06:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "8993516",
      "Title": "甜點控注意！「北捷✕Miss V端午鳳梨夾心酥禮盒」快閃優惠來囉! 6月11日「捷運商品館-中山店」限定優惠！",
      "NewsCategory": "新聞稿",
      "Description":
          "甜點控手刀準備囉！為感謝消費者熱情支持「北捷✕Miss V端午鳳梨夾心酥禮盒」早鳥預購，臺北捷運公司接力推出「捷運端午聯名禮盒展售會」快閃活動，6月11日12時30分至19時30分，到「捷運商品館-中山店」選購「端午聯名鳳梨夾心酥禮盒」即可享有快閃優惠價，現場亦推出好康免費領等眾多活動！此外，6月10日零時起，「台北捷運Go」App推出多重好康優惠券，數量有限，把握機會！由臺北捷運公司與中山商圈知名甜點店「Miss V Bakery」攜手，推出「北捷✕Miss V端午鳳梨夾心酥禮盒」，內含端午獨家新口味「艾草鹹蛋黃鳳梨夾心酥」及「起司鹹蛋黃鳳梨夾心酥」各5入。鳳梨夾心酥融合艾草、鹹蛋黃，充滿香、鹹、甜及青草風味；另一款則是融合鹹香的帕瑪森起士及鹹蛋黃，鹹甜參半，口感甜而不膩。◎好康免費領6月11日於「捷運商品館-中山店」現場排隊前40名，完成FB打卡分享指定任務，前3名即可免費獲得端午聯名禮盒1盒(原價720元)，餘37名則可免費獲得鹹蛋黃鳳梨夾心酥1個(口味隨機)。◎現場快閃優惠價6月11日到「捷運商品館-中山店」購買端午聯名禮盒，立即享有9折優惠價，或可選擇端午限定贈品「粽子造型毛巾」1個(價值109元)。◎「台北捷運Go」App優惠券6月10日零時起，「台北捷運Go」App發送6月11日當日限定好康優惠券，包含「鹹蛋黃鳳梨夾心酥(單顆)兌換券」、「捷運粽子造型毛巾兌換券」及「端午聯名禮盒85折優惠券」，數量有限先搶先贏。此外，6月10日起至6月22日止，「捷運商品館-中山店」、「捷運商品館-臺北車站店」現場提供限量「端午聯名鳳梨夾心酥禮盒」，亦可依需求，到店預訂指定日期取貨；凡購買端午聯名禮盒者，「每筆訂單」即贈送限量可愛「粽子造型毛巾」，購買6盒以上，則可享85折優惠(不得與其他優惠活動併用)。本次禮盒由「Miss V Bakery」設計，以捷運沿線著名地標為主題，結合其創立10週年以來各色點心插圖，文青感十足，送禮自用兩相宜。相關資訊可洽詢本公司24小時客服專線：（02）218-12345，或臺北市民當家熱線1999(外縣市02-27208889)或瀏覽本公司網站（https://www.metro.taipei/）。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=23B289C5974B2C76",
      "StartTime": "2023-06-09T17:43:00+08:00",
      "EndTime": "2023-07-09T17:43:00+08:00",
      "PublishTime": "2023-06-09T17:43:00+08:00",
      "UpdateTime": "2023-06-09T17:43:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "8988091",
      "Title": "貓空纜車進行年度檢修 6/8至6/21暫停營運",
      "NewsCategory": "新聞稿",
      "Description":
          "貓空纜車自112年6月8日(週四)開始至6月21日(週三)止，進行為期14天年度檢修暫停營運，預計6月22日(週四)端午節恢復營運，相關資訊將於官方網站及貓纜車站張貼公告，請民眾多加留意。今年度重要設備大修工作包括更換張緊液壓缸、救援馬達、迂迴輪襯墊、緊急煞車控制單元、轉轍器電動缸及軸承等；設備改善與更新專案包含動物園站屋頂鋼構及T15~T17塔柱除鏽上漆，並進行電氣測試、載重測試及運轉測試等年度系統測試。貓空纜車自96年通車營運以來至今已逾16年，每年均依原廠建議週期執行各項設備大修及測試作業，讓旅客搭乘更放心。由於許多大修工程必須動員重型機具、人力進行拆裝及測試，工作時程長，無法於例行週一停機檢修日完成，因此每年均安排暫停營運，進行相關設備大修及年度系統測試，以確保系統安全及穩定性。貓空纜車年度停機檢修，原則上規劃於每年5月至6月進行，原因為貓空5月開始進入落雷頻繁季節，因此安排落雷季進行當年度大修工作；今年度檢修安排於6月8日至6月21日期間，並於6月22日端午節當天恢復營運，屆時歡迎民眾前來搭纜車過端午。貓空纜車去(111)年度系統平均可用度為99.98%、前(110)年為99.995%，顯示系統運轉穩定，是全世界採用POMA公司纜車系統中表現最佳之一。詳情可洽詢臺北捷運24小時客服專線：（02）218-12345，或臺北市民當家熱線1999(外縣市02-27208889)或瀏覽本公司網站（https://www.metro.taipei/）。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=753FAAEA45015544",
      "StartTime": "2023-05-31T14:43:00+08:00",
      "EndTime": "2023-06-30T14:43:00+08:00",
      "PublishTime": "2023-05-31T14:43:00+08:00",
      "UpdateTime": "2023-05-31T14:43:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "8983337",
      "Title": "臺北捷運會員專屬活動 5/20「搖滾北投」寵愛登場",
      "NewsCategory": "新聞稿",
      "Description":
          "臺北捷運公司與國泰世華銀行共同主辦的「2023捷運這樣玩-搖滾北投」會員專屬場活動，於5月20日14時至20時20分，在捷運北投園區熱鬧登場。園區有刺激的闖關遊戲、琳瑯滿目的市集，還有知名歌手及人氣樂團現場熱情開唱，會員們近距離欣賞心儀歌手表演，直呼太過癮。此外，更有幸運兒獲得神秘大禮包，開心得合不攏嘴。參加「職人體驗營」的會員，搭乘下午2點於士林站發車的專屬列車直達北投機廠，前往臺北捷運維修秘境，親自體驗列車「洗澎澎」、參觀各式工程車及參訪逃生體驗營等活動。5月20日專門為臺北捷運會員打造的「2023捷運這樣玩-搖滾北投」會員專屬場活動，邀請到Ozone、溫蒂漫步、冰球樂團、荷爾蒙少年、麋先生、持修、拍謝少年輪番熱力演出。活動現場祭出「大禮包」有獎問答，獎品包含風扇、野餐墊、紀念杯、北捷濾掛式咖啡及7組藝人簽名海報等實用好禮，送給在場的幸運兒。參加活動會員們依照「台北捷運Go」App服裝密碼，成功預測當天入場隊伍（捷米隊）或（列車隊）入場人數較多者獲勝，系統從該隊入場者中隨機抽出得獎者，幸運兒獲得桂華軒精心準備的免費餐券(烤鴨5份，價值2,080元/份、豆腐水煮牛20份，價值780元/份）。除了超強卡司演出外，活動現場設有各式闖關遊戲，會員們挑戰「愛要大聲說」嗓音大聲公、「捷運Online」記憶挑戰、「命運轉轉站」答題等趣味活動，完成指定任務，獲得實用小禮物，滿載而歸。此外，園區邀請超過60攤市集、胖卡餐車，讓大家一飽口福。更詳細豐富的內容請持續關注捷運這樣玩臉書 、臺北捷運臉書，隨時掌握即時好康資訊，或洽詢本公司24小時客服專線：（02）218-12345，或臺北市民當家熱線1999(外縣市02-27208889)或瀏覽本公司網站（ https://www.metro.taipei/）。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=66A651B2FBCC7D60",
      "StartTime": "2023-05-20T12:39:00+08:00",
      "EndTime": "2023-06-20T12:39:00+08:00",
      "PublishTime": "2023-05-20T12:39:00+08:00",
      "UpdateTime": "2023-05-20T12:39:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "8979571",
      "Title": "臺北捷運立即啟動沿線路段巡檢 並加強工地宣導  如有異物入侵軌道優先阻止列車出發或行進 滾動管理SOP",
      "NewsCategory": "新聞稿",
      "Description":
          "臺中捷運10日發生意外事件，臺北捷運公司董事長趙紹廉當日第一時間代表臺北市長蔣萬安前往臺中捷運，表達關心及慰問，如果臺中捷運有需要，將提供任何人力物力做後盾全力支持。經檢討文湖線，如前方軌道有異物侵入且危及系統安全時，月臺列車不得離站，站間列車應立即緊急停車。車站人員或隨車人員可以立即阻擋車門或月臺門關閉、按下緊急斷電鈕切斷電力或是下拉或上推列車內緊急逃生把手，優先阻止列車出發後回報行控中心；行控中心獲知軌道掉落物影響行車安全時，將立即按下緊急斷電鈕，切斷全線軌道電力。高運量各路線，司機員發現前方有軌道掉落物或影響行車安全情形，月臺上列車暫停離站，行進間應立即按下緊急停車按鈕停車，並回報行控中心。行控中心獲知軌道掉落物影響行車安全時，無線電通知相關區段司機員緊急停車，並立即切斷軌道電力。若第一時間無法確認地點，無線電通知全線司機員緊急停車，並切斷全線軌道電力。捷運系統沿線設有圍籬及隔音牆設備，全系統車站皆設有月臺門，降低異物入侵風險。全自動的無人駕駛捷運均有軌道偵測異物系統(障礙物偵障桿及偵測開關)，依照車輛功能設計，若碰觸到軌道上有異物，即會立即啟動自趨安全保護自動停車；行控中心會進行檢視確認，通知相關站車人員處理，確認排除後隨即恢復行駛。此外，文湖線列車旅客如發現軌道有障礙物，可透過緊急對講機通報行控中心，行控中心收到旅客緊急對講機告知軌道有障礙物危及系統安全，會立即按下緊急斷電鈕切斷全線軌道電力。未來也評估於月臺增設緊急停車按鈕，供旅客或值班人員緊急使用，暫停列車進出車站；至於是否加裝遠距異物偵測系統，後續將評估研議。依照「大眾捷運系統兩側禁建限建辦法」規定，臺北捷運系統路線為專屬路權6公尺內為禁建範圍，6公尺以外限建範圍，外界如有施工需求，需經捷運工程局審查(本公司會同審查)，要求不得影響營運。針對捷運高架及平面段鄰近建物或工程案件，共計列管32處，臺北捷運昨日即已派員現場巡查結果無異常，同時已對廠商完成臺中捷運案例宣導。其他有影響軌道行車施工，如隔音牆工程，均安排夜間非營運時段施作，避免影響營運。全自動無人駕駛捷運系統(如臺中捷運綠線，臺北捷運的文湖線與環狀線)行駛於獨立路權，擁有列車自動控制系統(ATC)【含列車自動駕駛(ATO)、列車自動監督(ATS)、列車自動防護(ATP)等】擁有相當高的營運安全實績，因此被各國陸續引入，已運作40年以上，引進臺灣亦已有27年，本起重大事故於臺灣首次發生，除已修改相關作業規定外，亦將研究評估是否可藉偵測系統輔助，以進一步提昇安全。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=7B987D7683EA2995",
      "StartTime": "2023-05-11T17:04:00+08:00",
      "EndTime": "2023-06-11T17:04:00+08:00",
      "PublishTime": "2023-05-11T17:04:00+08:00",
      "UpdateTime": "2023-05-11T17:04:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "8978562",
      "Title": "溫馨母親節 兒童新樂園「親子共遊超值優惠」來囉！",
      "NewsCategory": "新聞稿",
      "Description":
          "兒童新樂園母親節優惠來囉！5月13、14日兩天推出「親子共遊超值優惠」，家長帶12歲以下孩童入園，其中1名家長免門票；現場購買「一日樂FUN券」，買一張送一張；持「一日樂FUN券」穿親子裝在園區拍照打卡，標註「一起來兒童新樂園慶祝母親節」，即可把限量超值好禮帶回家，歡迎大家母親節來兒童新樂園，小孩玩整天，超值禮袋送媽媽！迎接母親節推出「親子共遊超值優惠」，5月13、14日陪同12歲以下孩童入園，其中1名家長入園不但不用錢，現場購買每張200元的「一日樂FUN券」，兒童新樂園免費再送1張，限當日使用；購買「一日樂FUN券」的親子遊客，除了免費招待1張外，隨票再送限量小禮物1份。母親節活動期間，「持一日樂FUN券」並「出動」親子裝的遊客，在園區內拍照打卡，標註「一起來兒童新樂園慶祝母親節」，可至遊客服務中心領取白蘭氏萃雞精、葉黃素精華凍、光茵生技有機鮮銀耳等超過10樣精美禮品的限量超值禮袋1份。「一日樂FUN券」就是超值一日票，園區13項大型遊樂設施不限次數一票暢玩到底，包含大人小孩都喜歡的「基本款」水果摩天輪、海洋總動員(旋轉木馬)，還有讓人尖叫指數爆表的叢林吼吼樹屋（自由落體）、尋寶船（海盜船），通通玩到飽。詳情可洽本公司24小時客服專線：（02）218-12345，或臺北市民當家熱線1999(外縣市02-27208889)或瀏覽本公司網站（https://www.metro.taipei/）。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=DCABB176A271E050",
      "StartTime": "2023-05-10T10:43:00+08:00",
      "EndTime": "2023-06-10T10:43:00+08:00",
      "PublishTime": "2023-05-10T10:43:00+08:00",
      "UpdateTime": "2023-05-10T10:43:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "9012123",
      "Title": "兒童新樂園「雷克士REKS嘉年華」熱鬧開跑     IG打卡必備 巨大娃娃牆佈景超吸睛",
      "NewsCategory": "新聞稿",
      "Description":
          "到臺北市兒童新樂園輕鬆Fun暑假！兒童新樂園與雷克士REKS嘉年華首度合作，即日起在樂園3樓為您帶來5款刺激的遊戲攤位，每個遊戲攤位的巨大娃娃牆設計，不用出國就可以拍出絕美照片，吸睛指數絕對是IG等社群必備景點！此外，7月15日及16日，&nbsp;Zespri&nbsp;奇異果的「蔬果活力大使&nbsp;KIWI兄弟」和YOYO&nbsp;家族哥哥姐姐，在樹蛙表演場與大家一起同樂「領鮮起跑每一天」，還有多種闖關遊戲歡迎來體驗，並從遊戲中了解均衡攝取蔬果的好處。&nbsp;雷克士REKS嘉年華付費遊戲攤位，歡迎玩家們來挑戰！◎BASKETBALL 6-PLAYER在這項投籃遊戲中，只要投進1球，即可贏得1個獎品。&nbsp;◎LOBSTER POT想辦法將球投進「龍蝦桶」，每局2顆球，若2顆球分別停留於桶內，則可贏得1個獎品。&nbsp;◎HOOK A DUCK通通有獎的「撈鴨子」遊戲，每隻鴨子底部有貼上代表分數的號碼，將號碼相加後的總分，能依分數多寡兌換不同的獎品，分數越多獎品越大。&nbsp;◎RING TOSS受大家喜歡的「套圈圈」遊戲，將圈圈一個個分別拋出，只要套中一個瓶子，可贏得1個獎品，如果套中金瓶，即可贏得1個特別獎品。&nbsp;◎PYRAMID SMASH在「金字塔」遊戲中，站在指定位置且不能越線扔球，將桌上堆疊的罐子盡數擊落和清空，可贏得1個獎品。&nbsp;兒童新樂園自即日起至8月28日，天天延長營運至晚上9時，搭配一日樂FUN券，大小朋友可從早玩到晚；下午4時後購買星光樂FUN券，享有120元超值優惠。&nbsp;不論是一日樂FUN券或星光樂FUN券，均可無限次數暢玩園區13項遊樂設施，包含尖叫指數破表的尋寶船（海盜船）、魔法星際飛車、叢林吼吼樹屋，有趣的宇宙迴旋、小飛龍巡弋飛椅，或愜意夢幻的海洋總動員（音樂馬車）、摩天輪等設施。&nbsp;夏日限定的小小水樂園，即日起開放至10月1日止（8月30日至10月1日僅假日開放），每一場次票價通通只要50元，讓大家盡情暢玩水隧道、水柱、水霧等多項噴水遊樂設施，感受清涼快感及打水仗的刺激樂趣，親子同遊涼爽一「夏」。&nbsp;相關資訊可洽詢本公司24小時客服專線：（02）218-12345，或臺北市民當家熱線1999(外縣市02-27208889)或瀏覽本公司網站（https://www.metro.taipei/）。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=4926307811F14832",
      "StartTime": "2023-07-13T10:20:00+08:00",
      "EndTime": "2023-08-13T10:20:00+08:00",
      "PublishTime": "2023-07-13T10:20:00+08:00",
      "UpdateTime": "2023-07-13T10:20:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "9011415",
      "Title": "捷運文湖線南京復興站緊急停車按鈕即日起啟用 全線24站預計年底前完成設置",
      "NewsCategory": "新聞稿",
      "Description":
          "臺北捷運文湖線南京復興站月臺增設緊急停車按鈕（EMS） 自即日起啟用，文湖線其他車站設置完成後將陸續啟用，預計全線24個車站將於112年底前全面設置完成，未來遇有緊急狀況，民眾立即按壓月臺緊急停車按鈕，即可讓列車無法進站及出發，確保旅客及行車安全。&nbsp;臺北捷運公司表示，目前規劃設置的捷運文湖線月臺緊急停車按鈕（EMS），裝設位置在列車第1節車廂及第4節車廂對應的月臺門旁，以利發生緊急狀況時，候車旅客可直覺式的操作因應。當緊急狀況時，可立即按下緊急停車按鈕，中斷月臺門的關門安全迴路，等同月臺門未關妥，阻止列車進出站。&nbsp;新設的緊急停車按鈕（EMS），已加設上掀式壓克力外蓋板，並張貼紅底白字警語標示、警示燈，避免旅客誤觸，兼顧行車順暢及安全。&nbsp;臺北捷運鑑於臺中捷運事件，在南京復興站試辦增設月臺緊急停車按鈕，並於6月10日凌晨偕同臺北市政府捷運工程局共同進行實車驗證測試，模擬列車可能遭遇的4種不同情境，均能順利阻止列車進出站，確認功能與設計相符，行控中心及站務人員，亦均已完成SOP訓練。&nbsp;未來臺北捷運也將持續精進應變程序訓練、強化演練及優化設備等各項措施，打造安全的捷運乘車環境。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=0AE3E16D36166D31",
      "StartTime": "2023-07-12T10:02:00+08:00",
      "EndTime": "2023-08-12T10:02:00+08:00",
      "PublishTime": "2023-07-12T10:02:00+08:00",
      "UpdateTime": "2023-07-12T10:02:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "9005660",
      "Title": "TPASS基北北桃都會通上班首日 臺北捷運通行順暢",
      "NewsCategory": "新聞稿",
      "Description":
          "今(3)日是通勤族首次於上班日使用「TPASS行政院通勤月票/基北北桃都會通」，臺北捷運公司特別於上下班尖峰時段，在紅線臺北車站、市政府站、南港站、板橋站、北門站等各大眾運輸轉乘站及旅客較多車站，加派服務人員協助，經觀察上午尖峰時段旅客使用一切順暢，均能快速通關輕鬆GO。迎接上班首日，3日上午6時，臺北捷運公司董事長趙紹廉率總經理黃清信及一級主管親至車站，關心相關軟硬體設備狀況及旅客通行順暢。自7月1日基北北桃都會通啟用至3日上午10時，臺北捷運已累積達近42萬使用人次。臺北捷運全線驗票閘門已正式啟用基北北桃都會通功能，全線車站自動售票加值機也提供基北北桃都會通購票及1280定期票退票服務，上班首日有許多民眾使用自動售票加值機購、退票，一機完成，相當便利。臺北捷運為服務旅客，即日起至7月5日止，於北門站、市政府站、西門站、亞東醫院站、府中站、松山站、板橋站、南港站、臺北車站(紅線及藍線)、海山站、淡水站、景安站、圓山站、新埔站、蘆洲站，上下班尖峰時段，加派身穿黃色背心服務人員，協助旅客相關諮詢。此外，臺北捷運全線車站共有200個詢問處、16個臨時詢問處、645臺自動售票加值機、1,070位服務同仁，隨時提供「TPASS行政院通勤月票/基北北桃都會通」的「購票、設定、諮詢服務」。一卡在手暢行無阻！使用基北北桃公共運輸定期票，平均每天只要40元，30日內不限距離、次數搭乘臺北捷運、新北捷運、桃園機場捷運、基北北桃範圍內的公車、國道公路客運、臺鐵(部分對號列車除外)及YouBike租借優惠。透過便利的公共交通網絡，滿足上班通勤族、休閒運動族、上課學生族及商務族等不同族群的需求。對小資上班族及學生，使用「TPASS行政院通勤月票/基北北桃都會通」，通勤往返省錢省時；對休閒運動族，悠遊範圍更廣大，爬山看海更便利；對商務族，可以輕鬆、快速優雅穿梭各城市。假日更能繼續享受省錢玩法，經濟實惠又便利。建議您可下載「台北捷運GO App」，加入會員並綁定設有TPASS行政院通勤月票/基北北桃都會通之載具(如悠遊聯名卡、數位學生證悠遊卡等)，日後如不慎遺失被拾獲，經車站同仁登錄系統比對符合，將主動發送簡訊通知，提高找回電子票證的機會。基北北桃都會通已正式啟用，為服務原有1280定期票旅客，臺北捷運特別推出3種退費方式，第1種為利用定期票退票線上申請網頁退費，第2種退費方式，至車站使用自動售票加值機辦理；第3種退費方式，則是親自前往各捷運站詢問處辦理。選擇2、3種方式的旅客，建議利用假日或離峰時段前往車站辦理，避免現場排隊或久候。&nbsp;臺北捷運公司網站已公告「TPASS行政院通勤月票/基北北桃都會通」使用須知及民眾常見問題，歡迎上網查詢；臺北捷運AI智慧客服「TPASS行政院通勤月票/基北北桃都會通」問答專區同步上架，歡迎多加利用。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=4F53A1278D78A8E8",
      "StartTime": "2023-07-03T11:30:00+08:00",
      "EndTime": "2023-08-03T11:30:00+08:00",
      "PublishTime": "2023-07-03T11:30:00+08:00",
      "UpdateTime": "2023-07-03T11:30:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "9000496",
      "Title": "文湖線試辦優化3列馬特拉(VAL256)列車 北捷尊重各界意見將持續蒐集作為營運參考",
      "NewsCategory": "新聞稿",
      "Description":
          "6/20文湖線試辦3列馬特拉(VAL256)列車座椅拆除上線營運，試辦案預計到今年底，北捷尊重各界意見，將持續蒐集作為後續營運參考。&nbsp;臺北捷運參考新加坡、紐約等國外地鐵作法，試辦改裝3列馬特拉(VAL256)列車，提升車廂容納空間。每列車共有4節車廂，每節車廂有20個座位，在符合電聯車原廠規範的前提下，鎖定第2、3節人潮較多的車廂，進行空間優化，前後端博愛座更保留由原4席增為8席，對身障長者更友善。&nbsp;另空間優化改裝係拆除中間區域的12個座位；至於第1、4節車廂則維持原有座位數不變，有座椅需求的旅客仍可多利用第1、4節車廂。&nbsp;施作前已洽捷運工程局及工研院共同研議討論，拆除後可承載人數1節車廂約110人，符合捷運局技術條款規範，不影響電聯車車體結構及乘載安全。&nbsp;三部列車試辦完成空間優化改裝後，為確保改裝品質及安全，首先於機廠內執行靜態測試，接著於廠區的測試軌執行動態測試後，方排定列車在夜間主線以不載客狀態執行測試作業，經確認試辦列車相關測試皆正常後，始安排上線營運載客，同時實際派員上車觀察，旅客整體搭乘秩序良好安全無虞。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=2A13FFBA1807C6E8",
      "StartTime": "2023-06-21T21:22:00+08:00",
      "EndTime": "2023-07-21T21:22:00+08:00",
      "PublishTime": "2023-06-21T21:22:00+08:00",
      "UpdateTime": "2023-06-21T21:22:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "9000085",
      "Title": "「台北捷運Go」App接軌國際 中英日韓語都會通",
      "NewsCategory": "新聞稿",
      "Description":
          "擁有百萬下載人次的「台北捷運Go」App，即日起英、日、韓語一同上線！只要在google play商店或App Store輸入《Taipei Metro》、《台北地下鉄》、《타이베이 &nbsp;메트로》，就能下載具備中英日韓4國文字的「台北捷運Go」App！趕快Tag你的國際好友下載「台北捷運Go」App！《Welcome to Taipei》、《台北へようこそ》、《타이베이에 오신 것을 환영합니다》，歡迎大家來臺北玩！因應疫情趨緩後，國際觀光客來臺漸增，臺北捷運特別於「台北捷運Go」App增設英、日、韓等版本，讓國際友人透過手機App即可查詢車票及旅遊票種類、路網圖、車站資訊、路線及班距、首末班車時間、帶自行車搭捷運等資訊，不論是出國前規劃路線與景點，抵達臺北後在捷運站購買適合的車票種類，善用App時刻表轉乘其他大眾運輸，甚至是騎自行車乘風遨遊臺北，有「台北捷運GO」App真的好輕鬆！臺北捷運以運輸為本，近年來不斷推陳出新，帶給民眾便利貼心的服務，以「台北捷運Go」App為例，持續增加各類資訊提供，提供抽獎活動回饋，更重視雙向溝通，將創新科技精神導入服務，增加「AI智慧客服」功能，民眾不需透過電話，免開口即可隨時與智慧客服互動。而為了慶祝端午節到來，「台北捷運GO」App也加入應景動畫，給App使用者一點驚喜，期望透過小巧思祝福大家端午節快樂！相關資訊可洽詢本公司24小時客服專線：（02）218-12345，或臺北市民當家熱線1999(外縣市02-27208889)或瀏覽本公司網站（https://www.metro.taipei/）。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=3A37430DBFF567DD",
      "StartTime": "2023-06-21T14:41:00+08:00",
      "EndTime": "2023-07-21T14:41:00+08:00",
      "PublishTime": "2023-06-21T14:41:00+08:00",
      "UpdateTime": "2023-06-21T14:41:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "8999417",
      "Title": "配合捷運松江南京站共構大樓施工  6月22日起封閉松江南京站2號出入口及電梯",
      "NewsCategory": "新聞稿",
      "Description":
          "配合捷運松江南京站共構大樓施工、無障礙坡道及周邊通風井景觀工程，松江南京站2號出入口將自6月22日起封閉，該出口電梯亦暫停使用；請往松江公園或長安東路2段的旅客，配合使用替代動線及電梯，或洽車站詢問處或服務人員協助。此外，松江南京站3號出入口則於8月26日起封閉，屆時請旅客加強留意。松江南京站2號出入口及該處電梯，配合共構大樓施工，預計於6月22日起封閉，8月下旬重新開放2號出入口，至於電梯則於12月中旬開放。施工期間，現場將加強公告，並請旅客改走其他出入口，需要使用電梯的旅客，請多利用1號出口的電梯。松江南京站3號出入口則於8月26日起封閉，預計12月中旬重新開放，屆時請旅客改走其他出入口，需要使用電梯的旅客，則請改用1號出口的電梯。相關訊息歡迎洽詢本公司24小時客服專線：（02）218-12345，或台北市民當家熱線1999(外縣市02-27208889)或瀏覽本公司網站(https://www.metro.taipei/)。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=35714DF54FA316AA",
      "StartTime": "2023-06-20T13:52:00+08:00",
      "EndTime": "2023-07-20T13:52:00+08:00",
      "PublishTime": "2023-06-20T13:52:00+08:00",
      "UpdateTime": "2023-06-20T13:52:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "8996969",
      "Title": "就從6月22日開始！兒童新樂園提前放暑假 小小水樂園清涼登場 營業時間延長至晚間9點",
      "NewsCategory": "新聞稿",
      "Description":
          "提早放暑假囉！兒童新樂園將自端午節起，提前推出多項夏日限定活動，包含天天延長營運至晚上9時、小小水樂園涼爽登場、星光樂FUN券120元超值優惠，還有現場臨櫃一次購買3張一日樂FUN券，立即免費送一張扭蛋券，有機會抽中手機iPhone14 Pro等好禮；此外，端午連假期間加碼舉辦熱鬧市集、胖卡美食、LIVE音樂表演等活動，吃喝玩樂嗨翻一整天！兒童新樂園自6月22日起至8月28日，天天延長營運至晚上9時，搭配一日樂FUN券，讓大小朋友從早玩到晚，下午4時後購買星光樂FUN券，更享120元超值優惠。不論是一日樂FUN券，或星光樂FUN券，均可無限次數暢玩13項遊樂設施，包含尖叫指數破表的尋寶船（海盜船）、魔法星際飛車、叢林吼吼樹屋，有趣的宇宙迴旋、小飛龍巡弋飛椅，或愜意夢幻的海洋總動員（音樂馬車）、摩天輪等設施。FUN假玩水趣！夏日限定的小小水樂園，將於6月22日起開放至10月1日（8/30~10/1僅假日開放），不管是大人、小孩，每一場次票價通通只要50元，盡情在50分鐘內，暢玩水隧道、水柱、水霧等多項噴水遊樂設施，感受清涼快感及打水仗的刺激樂趣，親子同遊涼爽一「夏」。童年玩具「鱷魚牙醫」放大版來囉！化身為好玩好拍的超大呆萌鱷魚造型扭蛋機，張開大嘴巴模樣「卡哇伊」。這次鱷魚不咬人，內藏驚喜扭蛋，走進嘴巴裡，就可以扭出幸運扭蛋！6月22日至7月31日期間，現場臨櫃一次購買3張一日樂FUN券，立即免費送一張扭蛋券(免費扭蛋券限量1500張，送完為止)，有機會將iPhone14 Pro、Switch、Dyson吹風機、AirPods Pro等大獎帶回家。端午連假，園區出動超巨大4米高的桃紅色萌兔「七桃」迎接大家，憑一日樂FUN券或兒童新樂園臉書按讚畫面，可至園內「吉刻市集」攤位，兌換美粒果鮮果蘇打及超營養羊乳及羊乳片（數量有限，送完為止），還有美食胖卡、文創攤位及LIVE音樂表演等豐富活動，歡迎前來過佳節。相關訊息歡迎至兒童新樂園臉書或洽詢本公司24小時客服專線：（02）218-12345，或臺北市民當家熱線1999(外縣市02-27208889)或瀏覽本公司網站(https://www.metro.taipei/)。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=6DB7481F6208C3CF",
      "StartTime": "2023-06-17T11:05:00+08:00",
      "EndTime": "2023-07-17T11:05:00+08:00",
      "PublishTime": "2023-06-17T11:05:00+08:00",
      "UpdateTime": "2023-06-17T11:05:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "8993691",
      "Title": "北捷文湖線南京復興站緊急停車按鈕 10日凌晨完成實車測試 全線預計年底前完成設置",
      "NewsCategory": "新聞稿",
      "Description":
          "臺北捷運文湖線南京復興站試辦月臺增設緊急停車按鈕（EMS），今（10）日凌晨由臺北市政府捷運局及本公司共同進行實車驗證測試，模擬列車可能遭遇的4種不同情境，均能順利阻止列車進出站，甫測試完成的緊急停車按鈕將擇日啟用，預計112年底前完成文湖線全線車站月臺增設緊急停車按鈕（EMS）。&nbsp;臺北捷運公司表示，目前規劃設置的捷運文湖線月臺緊急停車按鈕（EMS），裝設位置在列車第1節車廂及第4節車廂對應的月臺門旁，以利發生緊急狀況時，候車旅客可直覺式的操作因應。當按下緊急停車按鈕時，立刻中斷月臺門的關門安全迴路，等同月臺門未關妥，以阻止列車進出站。&nbsp;10日凌晨，由臺北市政府捷運局及本公司行車處、站務處、系統處、工安處等單位共同投入，分別對於列車進站前、列車進站中、列車準備出發以及列車剛出發等4種不同情境進行測試，確實驗證當按壓增設的緊急停車按鈕時，可使列車停車，行控中心亦可立即接獲相應告警訊息，後續將對於相關停車條件及範圍等進行討論，並依實際狀況研議標示，以確認適用情形。&nbsp;緊急停車按鈕（EMS）操作方式非常簡單，緊急時刻僅需按壓按鈕即可；然而為維護行車順暢，避免旅客誤觸，新設的緊急停車按鈕（EMS），會加設上掀式壓克力外蓋板，並張貼紅底白字警語標示。&nbsp;臺北捷運公司持續精進應變程序及訓練、強化演練及優化設備等各項策進作為，以建構安全的捷運環境。&nbsp;相關資訊可洽詢本公司24小時客服專線：（02）218-12345，或臺北市民當家熱線1999(外縣市02-27208889)或瀏覽本公司網站（https://www.metro.taipei/）。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=EC5E2B3EAC879859",
      "StartTime": "2023-06-10T10:47:00+08:00",
      "EndTime": "2023-07-10T10:47:00+08:00",
      "PublishTime": "2023-06-10T10:47:00+08:00",
      "UpdateTime": "2023-06-10T10:47:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "8984925",
      "Title": "臺北捷運AI智慧客服 功能再提升！新增「一般事件通報」 民眾免開口即可尋求協助",
      "NewsCategory": "新聞稿",
      "Description":
          "在捷運上需要協助，但又不好意思開口，或怕身旁其他人聽到，怎麼辦？臺北捷運公司去(111)年11月推出AI智慧客服，即日起服務再進化，增加「一般事件通報」功能，民眾在車站或列車上，如需即時協助，透過AI智慧客服，利用文字免通話，即可告知臺北捷運客服中心及行控中心，快速取得相關的服務。臺北捷運表示，民眾可透過「台北捷運Go」App、臺北捷運官網或是在捷運車站詢問處掃描QRCode，選擇戴著耳機的微笑娃娃圖示，進入AI智慧客服。一般事件通報功能的設計，是以直覺式操作為主，使用相當方便，以車廂內有飲料打翻為例，在系統頁面中間的選項直接點選「一般事件通報」，或是在系統下方的對話框簡單輸入「有人打翻飲料」或「車廂有飲料打翻」，就能自動觸發這項功能，以引導對話的方式，點選路線別、輸入車廂編號，經過手機認證後即可傳遞訊息。AI智慧客服串聯臺北捷運客服中心及行控中心，當有民眾通報事件，客服中心及行控中心的通報系統會立即發出「叮咚！旅客通報、旅客通報！」的提示音，確認時間、地點後，通知相關單位處理，省下民眾撥打客服電話或尋找服務人員的時間。日前即有民眾使用「一般事件通報」，反映列車上有飲料打翻，客服人員確認路線別及車廂資訊後，迅速通知相關單位派員上車處理，短短幾分鐘內就將車廂恢復潔淨明亮；也有民眾透過這項功能，反映車廂內有人嘔吐，捷運車站立刻派員前往協助。臺北捷運將創新、科技精神導入顧客服務，以多年來累積的客服經驗及豐富資料庫為基礎，在去年11月推出AI智慧客服，以即問即答、24小時全年無休的互動性文字諮詢服務，對於一般常見問答提供快速回應，至今突破25萬使用人次；同時串接遺失物系統，民眾可藉由線上文字問答選單點選，即時顯示協尋結果或是登錄資料，由臺北捷運幫忙協尋，大幅節省民眾來電客服中心的時間成本及費用。詳情可洽詢臺北捷運24小時客服專線：（02）218-12345，或臺北市民當家熱線1999(外縣市02-27208889)或瀏覽本公司網站（https://www.metro.taipei/）。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=07D3B50F1EB3EC98",
      "StartTime": "2023-05-25T09:04:00+08:00",
      "EndTime": "2023-06-25T09:04:00+08:00",
      "PublishTime": "2023-05-25T09:04:00+08:00",
      "UpdateTime": "2023-05-25T09:04:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "8980861",
      "Title": "國家認證！臺北捷運榮獲「經濟部國家產業創新獎」殊榮 「安全可靠的旅運服務」加「創新求變」思維 讓臺北捷運從A 朝A+邁進",
      "NewsCategory": "新聞稿",
      "Description":
          "國家認證！臺北捷運公司榮獲第8屆「經濟部國家產業創新獎」組織類-績優創新獎殊榮，15日由副總經理詹文滔代表領獎。本次獲獎，臺北捷運在「創新成就」、「產業高值化策略」、「國際競爭力優勢」、「履行社會責任」等面向，獲得肯定。特別感謝所有旅客的支持，並強調仍將秉持「提供安全、可靠、親切的運輸服務，追求永續發展」的使命，透過「安全的運輸服務」為導向、「豐富的便利生活」為藍圖，在力求精進與突破的同時，落實節能減碳、員工與社會關懷、公司治理，以善盡企業社會責任，實踐優質、便利、永續的城市生活理念，持續精進各項軟硬體設施，為旅客創造安全、舒適的乘車體驗。&nbsp;◎創新數位轉型臺北捷運近年來，戮力落實數位轉型，「Metro TIMES」為交通軌道業首創，尤其「Metro TIMES」獲得臺北市政府市長盃資料應用黑客松競賽冠軍、中華民國運輸學會頒發「傑出交通運輸計畫獎」殊榮。結合車站、列車、軌道電路等設備訊息資料，達成安全、品質及服務三大目的。例如透過人流總量管制，即時提供行控中心列車調度及車站人潮疏導資訊，保障系統營運安全；民眾則可透過不斷精進的「台北捷運Go」App、月臺電視獲知捷運車廂擁擠度，達到分散車廂人潮的效果；至於即時列車資訊，可讓旅客隨時掌握列車到站時間；另為提供旅客更好的服務體驗及貼近旅客的需求，App也提供「天氣觀測」功能，滑開頁面隨手一點，就可馬上知道欲前往車站的天氣概況，提供旅客更優質貼心的服務。&nbsp;◎捷運不只是捷運，積極推動生活事業在產業高值化策略方面，捷運南京復興站推出自營商業空間品牌「Metro Corner」，規劃創新空間及微型商場經營方式，正面推動多元化商業及生活事業；今年再開設「Metro Corner忠孝復興站」及「Metro Corner臺北車站」2處微型商場，針對學生及時尚族群，提供「順手買」的貼心生活服務及方便取用的點心商品。「Metro Corner」三個車站預估年營業額2.5億元，年租金收入4,000萬元。同時建置智慧農業展示區「Metro Fresh捷欣鮮」，運用高科技，突破天候、地理等限制，在捷運站栽培無毒蔬菜，提供民眾低碳好食材。為嘉惠旅客，配合常客優惠方案，與多家知名品牌異業合作推出抽獎活動，共同行銷提供更多優惠。&nbsp;◎各路線高準點率名列世界前茅臺北捷運在國際競爭力上亦有多項優勢，通車甫滿27周年，去（111）年系統營運可靠度（MKBF）創歷年最佳表現，達1,645萬車廂公里，各路線準點率均突破99％，旅客滿意度高達97％，品牌滿意度相當卓越。&nbsp;◎積極導入ESG為地球盡一份心力臺北捷運近年積極建立永續發展ESG策略與行動機制，落實企業永續經營。響應能源政策，將捷運資產活化再利用，分別將6座捷運機廠屋頂轉化為太陽能光電廠，穩定提供潔淨綠色能源，設置容量高達21.5百萬瓦，每年發電量約2,200萬度，減少二氧化碳排放量11,200公噸，相當於29座大安森林公園二氧化碳吸收量。捷運公益系列活動，則以「走近偏鄉、走入北捷」為活動啟航，以實際行動支持臺灣在地農業；另透過都市再生與社區營造，進行捷運線形公園景觀改造，融入市民日常生活。&nbsp;經濟部國家產業創新獎包含組織類、團隊類及個人類等三大類，以機電運輸、資訊通訊、生醫材化、服務文創等四大領域設計，選拔對產業具有創新貢獻的公司企業、研究機構、學術單位、個人等，藉以提升競爭力，創造臺灣產業價值新里程碑。&nbsp;相關資訊可洽詢本公司24小時客服專線：（02）218-12345，或臺北市民當家熱線1999(外縣市02-27208889) 瀏覽本公司網站（https://www.metro.taipei/ ）。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=C5CD2903A07E8BE2",
      "StartTime": "2023-05-15T16:22:00+08:00",
      "EndTime": "2023-06-15T16:22:00+08:00",
      "PublishTime": "2023-05-15T16:22:00+08:00",
      "UpdateTime": "2023-05-15T16:22:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "8978529",
      "Title": "「揪媽媽搭貓纜」！母親節親子同行 貓空纜車一日票買1送1",
      "NewsCategory": "新聞稿",
      "Description":
          "貓空纜車讓疫情降級後的母親節更溫馨，推出「揪媽媽搭貓纜」活動，5月14日親子同行，購買一日票，貓纜再送一張「免費一日票」，母親節陪媽媽無限搭乘貓纜，暢遊纜車沿線景點。另外，貓空纜車攜手臺北市立動物園，推出限量「動貓樂玩套票」，內含3張票券，包含貓空纜車一站票、臺北市立動物園入園門票及遊客列車乘車券各1張，只要99元，從貓纜「動物園站」搭到「動物園南站」，享受居高臨下俯瞰山谷美景、鳥瞰動物園全貌，再進入動物園，搭乘動物園遊客列車，抵達鳥園後以下山方式逛動物園。更多詳細套票內容介紹，請至北北基好玩卡官網( https://funpass.travel.taipei/tour/d2ml )。「揪媽媽搭貓纜」親子同行，母親節當天到貓纜各車站，購買原價260元的貓纜「暢遊一日票」，再送一張「免費一日票」，可不限次數搭乘纜車，暢遊貓空地區知名景點。當日前300名親子旅客再加碼送康乃馨1朵。貓空纜車沿線景點包含動物園、指南宮(包含竹柏參道、十二生肖步道、月老平臺等)、貓空站(包含樟樹步道、樟湖步道、壺穴地形區、樟山寺等)，另特別推薦從貓空站步行到銀河洞瀑布，一睹仙氣美景，約30分鐘、2公里的路程，沿途樹蔭涼爽適合親子同行；夜幕低垂，「貓空光環境」透過深淺光影，將貓空站化身為打卡及情侶約會聖地，超級浪漫，千萬不要錯過！時序進入五月，有「五月雪」之稱的桐花，已在貓空山頭陸續綻放，搭乘纜車即可居高臨下欣賞桐花叢花海遍布在山區；也可攜帶一壺貓空知名鐵觀音茶、特色茶點，在雪白的桐花地毯上，接受大自然的洗禮，享受片刻悠閒與寧靜。來貓空別忘了品嘗美食，以貓空站為蛋黃中心，出站特色茶坊林立，到貓空吃特色餐、喝鐵觀音茶，補足體力再出發！貓空地區以文山包種茶及鐵觀音茶聞名，是喝茶、買茶的絕佳聖地，親子步道可觀賞鐵觀音茶園，健行之餘，不妨至茶文化推廣中心、富有貓空茶業人文歷史的張迺妙茶師紀念館品茗、回味茶香，細細咀嚼茶藝之美。詳情可洽本公司24小時客服專線：（02）218-12345，或臺北市民當家熱線1999(外縣市02-27208889)或瀏覽本公司網站（https://www.metro.taipei/）。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=497614145DE2FA9E",
      "StartTime": "2023-05-10T10:26:00+08:00",
      "EndTime": "2023-06-10T10:26:00+08:00",
      "PublishTime": "2023-05-10T10:26:00+08:00",
      "UpdateTime": "2023-05-10T10:26:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "8976448",
      "Title": "母親節全家陪媽媽出去走走！搭捷運即可抵達的親山步道 乘車寶典大公開",
      "NewsCategory": "新聞稿",
      "Description":
          "帶媽媽出去走走！捷運鄰近許多親山步道，坡緩易行，沿途設有休憩涼亭，輕鬆搭捷運或轉乘公車就可抵達，非常適合闔家一起出遊，享受戶外綠林悠閒時光！今年的母親節，不妨換個方式，帶媽媽避開塞車及人潮，搭乘捷運照樣可以親近大自然，歡度充滿「芬多精」的母親節。臺北捷運公司挑選幾處捷運沿線親山步道，媽媽們可依照個人「勇腳」戰鬥力，選擇適合的步道健行，沿著山稜線欣賞自然風景，療癒身心又可增強體健，祝福全天下媽媽「母親節快樂」！◎土城桐花公園桐花公園位於土城最高峰天上山的半山腰，每年4、5月是欣賞浪漫五月雪「油桐花」、螢火蟲熱門景點，園內設有親水木棧道、觀景平臺、立體爬網及涼亭等設施，整座公園就像是一座森林遊戲場，適合大小朋友玩樂。只要搭捷運板南線到「永寧站」，於出口2轉乘公車藍43(延南天母)至「南天母廣場站」即可抵達。◎仙跡岩步道仙跡岩位於景美地區，傳說八仙中的呂洞賓曾至此留下足跡，自此聲名大噪。自景美景興路243巷牌樓拾級而上，經過78階的長壽梯與100階的登仙坡後，就是濃蔭密布的綠色步道，步道旁油桐花爭豔盛開，隨風飄落的花朵灑落滿地，浪漫破表。搭乘松山新店線到「景美站」，往1號出口步行約10分鐘。◎和美山自然步道座落於新店碧潭西岸，是一條老少咸宜的登山步道，沿途生態豐富，登上「和美山頂」可俯瞰碧潭風景區及新店溪河岸美景。搭乘松山新店線到「新店站」，走過紅色碧潭吊橋到對岸，於吊橋頭即可看見步道入口。此外，即日起至5月28日止，「2023碧潭水舞」每晚6時30分至8時30分間每半小時表演1次，並在晚上8時45分進行最後一場展演。光彩奪目的雷射燈光與水幕，搭配碧潭及和美山自然景色交織成絢爛光影秀！◎二叭子植物園位於新店安坑塗潭山上的二叭子植物園，生態豐富，規劃數條登山步道、核心廣場、運動區等，5月可欣賞油桐花似覆雪般的盛況，是賞桐步道勝地。自安坑輕軌通車後，造訪園區交通更為便利，可搭乘捷運環狀線到「十四張站」，轉乘安坑輕軌至「耕莘安康院區站」後，再轉乘公車839、安坑1線接駁車，僅需約10分鐘即能抵達。◎劍潭山親山步道位於臺北市士林區圓山風景區，是臺北市最接近市中心的小山，登山口位於中山北路四段公車劍潭站旁，拾級而上就可擁抱綠意山林。登上「老地方觀景平臺」遠眺臺北101，還可以看到淡水河與基隆河，以及松山機場飛機起降，傍晚則能欣賞觀音山的夕陽，也是夜間欣賞都市夜景好地點。搭乘淡水信義線到「劍潭站」，往2號出口步行約10分鐘。◎象山親山步道外形類似象頭而得名，與周邊獅山、虎山、豹山合稱為四獸山，擁有稜線、岩壁、山坡、山窪、山谷等各種不同微環境，著名景點包含，巨崖岩壁突出遮天的「一線天」、可俯瞰臺北101大樓全景及大屯火山群各景點的「超然亭」。搭乘淡水信義線至「象山站」，往2號出口步行約15分鐘。詳情請可查詢臺北旅遊網、新北市觀光旅遊網，或洽詢本公司24小時客服專線：（02）218-12345，或臺北市民當家熱線1999(外縣市02-27208889)或瀏覽本公司網站(https://www.metro.taipei/)。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=12FC6514E104F643",
      "StartTime": "2023-05-05T14:39:00+08:00",
      "EndTime": "2023-06-05T14:39:00+08:00",
      "PublishTime": "2023-05-05T14:39:00+08:00",
      "UpdateTime": "2023-05-05T14:39:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "9002708",
      "Title": "中山線形公園「兒童的繽紛世界」要拆？北捷尊重審議委員會審議結果並配合辦理後續事宜",
      "NewsCategory": "新聞稿",
      "Description":
          "有關捷運中山線形公園「兒童的繽紛世界」藝術品保留爭議，外界傳言臺北捷運公司決定將作品予以拆除，臺北捷運在此鄭重澄清，重申本案絕無預設立場。由於在地民眾對於保留與拆除分持兩派意見，經與臺北市政府捷運工程局綜整各方意見並提出可行方案後，將本案提送臺北市公共藝術審議委員會審議會說明討論，後續尊重審議委員會審議結果，配合辦理相關事宜，並呼籲各界尊重審議結果。臺北捷運公司強調，針對捷運中山線形公園「兒童的繽紛世界」藝術品，捷運局及捷運公司已彙整各方民眾反映意見，提送臺北市公共藝術審議委員會辦理審議，於審議會完成前，作品仍依原設計規劃原址存置並妥善保護。為辦理捷運中山站至臺北車站間線形公園空間改造，重新打造人本動線優質空間環境，於初期規劃及設計階段舉辦兩場次公民參與工作坊，廣泛接受民眾參與公共建設意見。針對該藝術品，部分在地居民認為作品11公尺長，但是線形公園只有15.6公尺寬，橫置在線形公園上對於通行有所阻礙，且牆面沒有視覺通透，恐有治安與安全的問題；另有部分民眾，主張該作品具有歷史性的保留意義。目前本公司及捷運局廣納各方意見，已將本作品擬定計畫提送臺北市公共藝術審議委員會辦理審議。有關部分人士表示公司已決定變更設計不保留該作品，此說法與事實並不相符，重申本案並無預設立場，後續亦將尊重審議委員會審議結果，並配合辦理後續事宜。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=4E7B127D3F93D485",
      "StartTime": "2023-06-28T11:04:00+08:00",
      "EndTime": "2023-07-28T11:04:00+08:00",
      "PublishTime": "2023-06-28T11:04:00+08:00",
      "UpdateTime": "2023-06-28T11:04:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "9001592",
      "Title": "臺北捷運竭誠為您的TPASS通勤月票 提供基北北桃都會通服務",
      "NewsCategory": "新聞稿",
      "Description":
          "你預購了嗎？「TPASS行政院通勤月票/基北北桃都會通」即將在7月1日正式啟用，臺北捷運竭誠提供旅客，包括諮詢、購票、設定、退票及預購等各項服務。&nbsp;針對旅客需要的服務，臺北捷運已準備好了，全臺北捷運117個車站提供：【諮詢服務】200個詢問處、16個臨時詢問處、1,070位服務同仁隨時提供「諮詢服務」。【購票、設定、退票服務】200個詢問處、16個臨時詢問處、645台自動售票加值機、1,070位服務同仁隨時提供「購票、設定、退票服務」。【專屬通道】1,360個驗票閘門，每一個都是您的「專屬通道」。【先買】預先購買TPASS行政院通勤月票或自備悠遊卡預購基北北桃都會通&nbsp;為方便民眾，北捷645台自動售票加值機自6月15日同步開放預購服務，特別將預購設計為「綠色圖示」，顯眼的放大效果，讓大家一眼就可輕鬆找到預購選項；點選圖示後，再將悠遊卡放在加值平臺上，進入預購畫面後依序操作，輕鬆完成預購。&nbsp;由交通部公路總局發行的TPASS行政院通勤月票，每張售價100元，即日起可至捷運各車站詢問處購買，就近於詢問處或自動售票加值機，完成「基北北桃都會通」預購。現在購買TPASS行政院通勤月票，並至悠遊卡公司網頁完成活動登錄，可享100元回饋(每人限領1次)，活動詳細辦法，請至悠遊卡官網查詢。&nbsp;除了「TPASS行政院通勤月票」，也可以使用未設定任何定期票的悠遊卡，至臺北捷運各車站自動售票加值機或詢問處，完成「基北北桃都會通」預購。&nbsp;「TPASS行政院通勤月票/基北北桃都會通」售價為1200元，購買時由悠遊卡扣除1200元並完成預購設定，若悠遊卡餘額不足時，請依設備提示加值完成後即可預購設定；悠遊聯名卡或悠遊Debit卡(含帳戶連結悠遊卡)開啟自動加值功能，即可在自動售票加值機選擇以自動加值方式預購。&nbsp;【後退】延後退費1280定期票原先使用1280定期票的旅客，因一張卡片只能設定一種定期票，建議旅客可以購買TPASS或使用另一張悠遊卡，在7月1日之前，先到車站完成「TPASS行政院通勤月票/基北北桃都會通」預購；等到7月1日之後，再辦理1280定期票退費。尚未到期的1280定期票，依照定期票「經過日數」(啟用當日起算至最後一次使用日之日數)退費，只要7月1日後不使用1280定期票，就不會影響退費比例。&nbsp;假如手邊沒有第二張票卡，建議7月1日和7月2日或其他離峰人潮較少的時段，至各捷運站自動售票加值機，點選螢幕上的「1280公共運輸定期票退票」退費或至詢問處辦理；退完費之後，接著直接在自動售票加值機或詢問處，完成「基北北桃都會通」預購。&nbsp;為服務1280定期票旅客，臺北捷運特別推出3種退費方式，第1種為利用定期票退票線上申請網頁退費，利用手機或電腦即可完成，相關退費規定，請瀏覽臺北捷運網站。&nbsp;第2種退費方式，至車站使用自動售票加值機，點選螢幕上的「1280公共運輸定期票退票」退費功能辦理；至於第3種退費方式，則是親自前往各捷運站詢問處辦理。選擇2、3種方式的旅客，建議利用假日或離峰時段前往車站辦理，避免現場排隊或久候。&nbsp;臺北捷運公司網站已公告「TPASS行政院通勤月票/基北北桃都會通」使用須知及民眾常見問題，歡迎上網查詢；臺北捷運AI智慧客服「TPASS行政院通勤月票/基北北桃都會通」問答專區同步上架，歡迎多加利用。-以下空白-&nbsp;&nbsp;附錄【「基北北桃都會通」大補帖】◎適用範圍「基北北桃都會通」適用範圍包括：臺北捷運、新北捷運(含輕軌)、桃園機場捷運、基隆/新北/桃園市區公車、臺北市聯營公車及基北北桃範圍內的公路及國道客運。&nbsp;臺鐵適用範圍則有：縱貫線的基隆站至桃園市新富站，宜蘭線八堵站至福隆站，深澳支線及平溪支線，不限車種列車均適用；若具有專屬性及不發售無票座對號列車則不適用，例如：觀光、團體、太魯閣、普悠瑪、EMU3000列車等。&nbsp;新北市及臺北市YouBike&nbsp;站點借車，前30分鐘免費；桃園市YouBike&nbsp;站點借車，前60分鐘免費。&nbsp;◎購票方式及地點民眾可持悠遊卡、SuperCard超級悠遊卡（含TPASS）、電信悠遊卡、悠遊聯名卡或悠遊Debit卡(票卡效期需60天以上）、學生卡、數位學生證，自6月15日起至臺北捷運及桃園機場捷運各車站(A20興南站除外)、新北捷運設置詢問處的車站、臺鐵車站指定售票窗口(6月27日開放購票)、臺北市政府轉運站悠遊卡客服中心、國光客運(基隆站、臺北站、新北板橋轉運站、南港轉運站、桃園機場站及中壢站)悠遊卡售票加值機購買；至於Samsung Wallet悠遊卡，7月1日開放購票。◎適用票種目前僅開放悠遊卡設定，後續俟其他票證公司完成準備後，將陸續開放使用。至於敬老、愛心及優待卡等優惠票種，已依法提供大眾運輸搭乘優惠，因此無法設定「基北北桃都會通」。&nbsp;◎首次啟用期限及方式「基北北桃都會通」僅限一人使用，若超過30天未啟用，該票將失效，須辦理退費後重新購買（須加收手續費）。例如：&nbsp;7月1日持悠遊卡購買，最遲必須於7月30日晚上12點前首次啟用。&nbsp;啟用方式非常簡單，將票卡輕觸捷運或臺鐵車站自動收費進站閘門，或公車、國道客運、公路客運、輕軌驗票機，即可啟用。&nbsp;「基北北桃都會通」無法於YouBike站點啟用，持卡人須先加入YouBike會員並以該悠遊卡卡號註冊，始可享臺北市及新北市YouBike站點借車前30分鐘免費、桃園市YouBike站點借車前60分鐘免費優惠。&nbsp;◎使用期間及續購方式「基北北桃都會通」有效期間為啟用日(含)起連續30日，可透過臺北捷運車站車票查詢機查詢，或於捷運、臺鐵閘門、輕軌及公車驗票機螢幕確認使用期限。例如：6月16日預購、7月1日啟用，有效期間為7月1日至7月30日。&nbsp;「基北北桃都會通」有效期間屆滿後，持卡人可再擇日重新購買，或者持原票卡在有效期間屆滿前10日起(即啟用後第21日)，至臺北捷運及桃園機場捷運各車站(A20興南站除外)、新北捷運設置詢問處的車站、臺鐵車站指定售票窗口、臺北市政府轉運站悠遊卡客服中心、國光客運(基隆站、臺北站、新北板橋轉運站、南港轉運站、桃園機場站及中壢站)悠遊卡售票加值機續購。使用SuperCard超級悠遊卡、Samsung Wallet悠遊卡等，可透過悠遊卡公司授權支付App辦理續購。&nbsp;例如：7月1日第一次使用「基北北桃都會通」，可自7月21日起續購，續購的「基北北桃都會通」將於原有效期限7月30日翌日（即7月31日）自動啟用，延長使用期限至8月29日。&nbsp;有效期間屆滿，民眾仍可持原票卡搭車，票卡則恢復原電子票證的計費方式。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=CFA472968DFA5CA6",
      "StartTime": "2023-06-26T17:40:00+08:00",
      "EndTime": "2023-07-26T17:40:00+08:00",
      "PublishTime": "2023-06-26T17:40:00+08:00",
      "UpdateTime": "2023-06-26T17:40:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "9000657",
      "Title": "6月27日新北投支線軌道鋼軌研磨作業 列車調整停靠月臺",
      "NewsCategory": "新聞稿",
      "Description":
          "臺北捷運新北投支線訂於112年6月27日上午10時至下午3時，進行例行鋼軌研磨及維護工程，期間將調整列車停靠月臺，北投站及新北投站張貼告示加強宣導，亦加強人員引導服務，屆時請旅客多加留意及配合。淡水信義線列車於當天作業期間營運模式如下：◎淡水-信義列車：維持原營運模式不變。◎北投-大安(區間車)列車：北投站下車的旅客：改由第1月臺下車。北投站(往大安站)的旅客：改由第2月臺上車。◎北投-新北投列車：北投站(往新北投站)的旅客：改由第3月臺上下車。新北投站(往北投站)的旅客：改由第2月臺上下車。捷運高運量系統軌道研磨作業，均在捷運營運結束後於夜間施工，為了維護居民的安寧及維持捷運服務品質，新北投支線是唯一且定期在白天進行鋼軌研磨的區段。由於鋼軌使用一段期間，會產生「波狀磨耗」，軌道表面會因金屬疲勞產生硬化層，造成些微不平整，必須經由適當工法研磨，不但可以保護鋼軌，亦可以延長鋼軌使用年限，降低列車行經造成的噪音。研磨作業現場，由維修人員熟練操作重達72噸的鋼軌研磨車，透過電腦準確控制磨石角度，鋼軌平順無稜角，讓列車行駛平穩，旅客得以有舒適的搭乘環境。在進行鋼軌研磨作業時，鋼軌研磨車必須在軌道上來回研磨，伴隨較大聲響及粉塵，同時還需要隨時進入軌道查看研磨情形，因此維修人員均需全程戴耳罩、防塵口罩，安全帽、反光背心及安全鞋，更是維護安全不可或缺的標準配備。相關資訊可洽詢本公司24小時客服專線：（02）218-12345，或臺北市民當家熱線1999(外縣市02-27208889)或瀏覽本公司網站（https://www.metro.taipei/）。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=7B40A4B3B255D8C1",
      "StartTime": "2023-06-24T09:26:00+08:00",
      "EndTime": "2023-07-24T09:26:00+08:00",
      "PublishTime": "2023-06-24T09:26:00+08:00",
      "UpdateTime": "2023-06-24T09:26:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "9000572",
      "Title": "跟著臺北捷運METRO FUN 一起玩！ 這樣遊臺北最FUN！購買捷運旅遊票優惠享不完",
      "NewsCategory": "新聞稿",
      "Description":
          "FUN暑假遊臺北，捷運旅遊票讓你優惠享不完！臺北捷運公司規劃「METRO FUN跟我一起玩」YouTube節目，介紹捷運沿線景點及店家，本集主持人阿彭、冠霖要介紹捷運旅遊票好康優惠，帶大家搭捷運探訪觀光客喜愛的古蹟景點，體驗歷史建築融合文創元素、品嘗創新茶飲及有趣的文創伴手禮！&nbsp;融合潮流、懷舊歷史的西門町，是觀光客必遊景點，此處最具代表性的建築，就是西門紅樓。擁有百年歲月的三級古蹟西門紅樓，其獨特八角造形紅磚洋樓，歷經市場、書場、電影院、劇場的角色轉換，現在則是充滿文創氣息的藝文據點，還有紅樓茶坊、紅樓劇場以及紅樓選品。持捷運旅遊票前往，可免費獲贈「百年磚紅樓情」明信片1張，到紅樓選品選購伴手禮可享9折優惠。&nbsp;位於臺北市東區的松山文創園區，是文青必訪朝聖地點，前身為日據時期「臺灣總督府專賣局松山煙草工場」，建築風格屬於三十年代現代主義建築，轉角弧形磁磚裝飾及對稱式中庭格局最具特色，巴洛克式花園、生態景觀池等設施，堪稱當時工業廠房的楷模。&nbsp;隱身於松山文創園區的Beryl & Co.是一間極具特色的茶風格店家，選用自然農法的臺灣茶葉、德國有機花草與熱帶可可茶，結合東西方元素，創造獨特茶飲。此外，店內創新的茶香檳，將無糖茶注入二氧化碳，綿密細緻氣泡如同香檳口感；另一款氮氣茶，在茶中打入氮氣，喝起來宛如啤酒的錯覺感，非常獨特。持捷運旅遊票好康優惠，購買經典茶禮盒/時尚茶隨行包，不限金額即贈茶香檳一杯。&nbsp;即日起至8月31日，到臺北捷運各車站旅客詢問處，或臺北車站、西門站、中山站等特定車站的多元支付售票機，購買捷運旅遊票（捷運一日票、24小時票、48小時票、72小時票），或交通聯票（北捷雙巴套票及機捷北捷聯票），加碼送「臺北特色禮品」優惠，有清新茶飲品、糕餅、文創小物伴手禮品，並享北投會館「捷之旅」、北捷嚴選咖啡、捷運商品，熱門景點故宮博物院、臺灣博物館、臺北市兒童新樂園及貓空纜車等專屬優惠。詳細內容及配合店家優惠資訊，歡迎至「搭捷運遊台北」活動網站查詢。&nbsp;探索更多吃喝玩樂大小事，歡迎訂閱臺北捷運YouTube頻道，鎖定「METRO FUN跟我一起玩」遊臺北。&nbsp;相關訊息請洽詢本公司24小時客服專線：（02）218-12345，或臺北市民當家熱線1999(外縣市02-27208889)或瀏覽本公司網站(https://www.metro.taipei/)。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=407345F61AB140C4",
      "StartTime": "2023-06-22T09:57:00+08:00",
      "EndTime": "2023-07-22T09:57:00+08:00",
      "PublishTime": "2023-06-22T09:57:00+08:00",
      "UpdateTime": "2023-06-22T09:57:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "8993877",
      "Title": "捷之旅「一童趣FUN假」暑期限定優惠來了 搭配兒樂一日樂FUN券、美食餐券 將獨家列車積木及悠遊卡帶回家",
      "NewsCategory": "新聞稿",
      "Description":
          "暑假優惠來了！即日起至8月底止，北投會館「捷之旅」與KKday線上旅遊平台攜手合作，熱推「一童趣FUN假」暑期限定優惠，入住「捷之旅」搭配臺北市兒童新樂園一日樂FUN券及美食餐券，加贈限量獨家小禮「北捷列車微型積木」及「北捷Q版職人悠遊房卡」！趕快「捷」足先登安排暑期行程，活動詳情請到KKday線上旅遊平台網址。&nbsp;暑假FUN電去，北投會館「捷之旅」推出暑期強檔優惠，滿足旅客的排程需求，要搶要快！&nbsp;◎隨時來趟說走就走的低碳輕旅程！「捷之旅」位於捷運淡水信義線復興崗站的北投機廠，「一童趣FUN假」優惠住宿期間，可免費預約參加「捷運逃生體驗營」，透過各項擬真設施，了解捷運系統中的設備及防災知識；亦可免費至健身房及游泳池揮灑汗水；或在1樓Metro Lounge悠閒聊天、看書、喝杯飲品；如果想要騎車漫遊，更可攜帶身分證件至櫃台，免費借用自行車，盡情享受悠閒時光。&nbsp;◎獨家小禮「北捷列車微型積木」及「北捷Q版職人悠遊房卡」親愛的，我把列車縮小了！一手掌握捷運車廂，透過積木堆疊創意，一起享受動手玩的樂趣；「捷之旅」住房房卡，卡面是限量手繪Q版職人及捷運列車，不僅值得保留珍藏，在儲值後更可當作悠遊卡使用，好處一舉兩得。&nbsp;◎超值方案包含臺北市兒童新樂園一日樂FUN券及美食餐券每張200元的「一日樂FUN券」，兒童新樂園13項大型遊樂設施，即可不限次數一票暢玩到底，包含大人小孩都喜歡的「基本款」水果摩天輪、海洋總動員（旋轉木馬），還有讓人尖叫指數爆表的叢林吼吼樹屋（自由落體）、尋寶船（海盜船），通通都在這。此外，持有兒童新樂園美食餐券，可至園區漢堡王兌換價值120元優惠套餐，讓大家玩得盡興、吃得開心。&nbsp;相關資訊可洽詢本公司24小時客服專線：（02）218-12345，或臺北市民當家熱線1999(外縣市02-27208889)或瀏覽本公司網站（https://www.metro.taipei/ ）。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=D6A150C8A0F8E57D",
      "StartTime": "2023-06-12T10:07:00+08:00",
      "EndTime": "2023-07-12T10:07:00+08:00",
      "PublishTime": "2023-06-12T10:07:00+08:00",
      "UpdateTime": "2023-06-12T10:07:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "8993355",
      "Title": "基北北桃1200都會通定期票預購＆1280定期票退費 報給你知 牢記「預先購買、延後退票」 輕鬆預購好便利",
      "NewsCategory": "新聞稿",
      "Description":
          "基隆市、臺北市、新北市及桃園市四市首長，今(9)日在市府轉運站共同宣布「基北北桃1200都會通定期票」正式啟動，自6月15日起開始預購，7月1日起正式啟用，臺北捷運各車站自動售票加值機及詢問處均可購票，建議1280定期票使用者「預先購買1200都會通定期票、延後退費1280定期票」，避開正式啟用初期購、換票人潮。為協助民眾輕鬆購票，臺北捷運公司特別在6月15日至30日的平常日17時至20時，在淡水、新埔、海山、府中、亞東醫院、板橋、景安(中和新蘆線)、蘆洲、市政府、西門、臺北車站、松山、南港、北門、圓山等定期票熱門銷售車站及重要轉乘站，加派支援人力，穿著黃色背心接受旅客洽詢，宣導期間將視車站預購狀況隨時調整。臺北捷運全線車站共有超過500臺自動售票加值機提供預購服務，操作方式非常簡單，依照自動售票加值機螢幕上的說明，點選「購買都會通」，再將悠遊卡放在感應平臺上，即可進入預購畫面。1200都會通定期票售價為1,200元，購買時，自動售票加值機將直接從悠遊卡電子錢包扣除，並完成都會通設定；若悠遊卡電子錢包內儲值金額不足時，請依設備提示投入足夠金額後即可購買設定，多投入的金額會自動轉為電子錢包儲值金額，不予找零。悠遊聯名卡或悠遊Debit卡(含帳戶連結悠遊卡)開啟自動加值功能，即可在自動售票加值機選擇以自動加值方式預購。若票卡內仍有未到期的1280定期票，須先點選螢幕上的「1280公共運輸定期票退票」辦理退費，退費金額將轉入悠遊卡電子錢包，再購買1200都會通定期票。再次提醒民眾，1280定期票於退費後將立即失效，後續乘車均將依一般悠遊卡扣款，7月1日前仍須使用1280定期票的民眾，可利用另一張票卡購買。臺北捷運特別針對1280定期票忠實顧客傳授「預先購買1200都會通定期票、延後退費1280定期票」超便利心法：由於每張票卡同一時間只能設定一種定期票，使用1280定期票的民眾，可以拿出手邊另外一張票卡，6月15日起事先到臺北捷運各車站的自動售票加值機預購1200都會通定期票，在6月30日（含）之前繼續使用原有的1280定期票，7月1日起「無縫接軌」1200都會通定期票。尚未到期的1280定期票係依照票卡「經過日數」比例退費，只要7月1日後不使用1280定期票，就不會影響退費金額。在1200都會通定期票和1280定期票轉換初期，使用1280定期票的民眾，建議預先購買1200都會通定期票、延後退費1280定期票，等到7月1日之後，再利用人潮較少的時段，至臺北捷運各車站自動加值售票機或詢問處辦理退費。如家裡找不到第二張票卡，建議7月1日和7月2日利用週末假日人潮較少的時段，至臺北捷運各車站辦理1280定期票退費，同時購買1200都會通定期票。如果平常沒有擴大使用範圍或其他運具需求的1280定期票使用旅客，更是建議持續使用至期滿為止，再轉換1200都會通定期票，避開正式啟用初期購、換票人潮。臺北捷運公司網站已公告1200都會通定期票使用須知及民眾常見問題，歡迎上網查詢；臺北捷運AI智慧客服「基北北桃1200都會通定期票問答專區」已同步上架，可多加利用。現行的1280定期票販售至6月30日止，歡迎利用定期票退票線上申請網頁退費，避開捷運車站退費人潮，相關退費規定，可瀏覽臺北捷運網站(https://reurl.cc/zY8kpy)。附錄【基北北桃1200都會通定期票大補帖】◎適用範圍「1200都會通定期票」適用範圍包括：臺北捷運、新北捷運(含輕軌路線)、桃園機場捷運、基隆市區公車路線、新北市區公車路線、臺北市聯營公車路線及桃園市區公車路線及基北北桃範圍內的公路及國道客運。臺鐵適用範圍則有：起訖站均位於縱貫線的基隆站至桃園市新富站，宜蘭線八堵站至福隆站，以及支線深澳線及平溪線各車站間、不限車種列車均適用；提醒大家，具有專屬性及不發售無票座對號列車則不適用，例如：觀光、團體、太魯閣、普悠瑪、EMU3000列車等。新北市及臺北市YouBike 站點借車，前30分鐘免費；桃園市YouBike 站點借車，前60分鐘免費。◎購票方式及地點民眾可持悠遊卡、SuperCard超級悠遊卡、電信悠遊卡、悠遊聯名卡或悠遊Debit卡(票卡效期需60天以上）、學生卡、數位學生證，自6月15日起至臺北捷運及桃園捷運各車站(A20興南站除外)、新北捷運設置詢問處的車站、臺鐵車站指定售票窗口(7月1日開放購票)、臺北市政府轉運站悠遊卡客服中心、國光客運(基隆站、臺北站、新北板橋轉運站、南港轉運站、桃園機場站及中壢站)悠遊卡售票加值機購買；至於Samsung Wallet悠遊卡，7月1日開放購票。◎適用票種目前開放悠遊卡設定1200都會通定期票，後續俟其他票證公司完成準備後，將陸續開放使用。至於敬老、愛心及優待卡等優惠票種，已依法提供大眾運輸搭乘優惠，因此無法設定1200都會通定期票。◎首次啟用期限及方式1200都會通定期票僅限一人使用，如果超過30天沒有啟用，該票將失效，須辦理退費後重新購買（須加收手續費）。例如： 7月1日持悠遊卡購買，最遲必須於7月30日晚上12點前首次啟用。啟用方式非常簡單，將票卡輕觸捷運或臺鐵車站自動收費進站閘門，或公車、國道客運、公路客運、輕軌驗票機，即可啟用。1200都會通定期票無法於YouBike站點啟用，持卡人須先加入YouBike會員並以該悠遊卡卡號註冊，始可享臺北市及新北市YouBike站點借車前30分鐘免費、桃園市YouBike站點借車前60分鐘免費優惠。◎使用期間及續購方式1200都會通定期票有效期間為自啟用當天開始起算連續30日，可透過臺北捷運車站車票查詢機查詢，或於捷運、臺鐵閘門、輕軌及公車驗票機螢幕了解使用期限。例如：7月5日持悠遊卡設定1200都會通定期票，7月10日啟用，有效期間為7月10日至8月8日。1200都會通定期票有效期間屆滿後，持卡人可再擇日重新購買，或者持原票卡在有效期間屆滿前10日起(即啟用後第21日)，至臺北捷運及桃園捷運各車站(A20興南站除外)、新北捷運設置詢問處的車站、臺鐵車站指定售票窗口、臺北市政府轉運站悠遊卡客服中心、國光客運(基隆站、臺北站、新北板橋轉運站、南港轉運站、桃園機場站及中壢站)悠遊卡售票加值機續購。使用SuperCard超級悠遊卡、Samsung Wallet悠遊卡等，可透過悠遊卡公司授權支付App辦理續購。例如：7月10日第一次使用1200都會通定期票，可自7月30日起續購，續購的1200都會通定期票將於原有效期限8月8日翌日（即8月9日）自動啟用，延長使用期限至9月7日。有效期間屆滿，如不再續購，民眾仍可持原票卡搭車，票卡則恢復原電子票證的計費方式。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=7342DFB59FBE8B98",
      "StartTime": "2023-06-09T14:12:00+08:00",
      "EndTime": "2023-07-09T14:12:00+08:00",
      "PublishTime": "2023-06-09T14:12:00+08:00",
      "UpdateTime": "2023-06-09T14:12:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "8990996",
      "Title": "臺北捷運將新增15站列車到站韓語廣播 提供更國際化的便利服務",
      "NewsCategory": "新聞稿",
      "Description":
          "為提升大臺北地區觀光服務及臺北市議會交通部門質詢許淑華議員關心，臺北捷運將在臺北車站、中山、東門、臺北101/世貿、淡水、西門、中正紀念堂、民權西路、松江南京、忠孝新生、古亭、南京復興、忠孝復興、大安及南港展覽館等15個車站，新增列車到站「韓語」廣播；並在原有的13站日語廣播外，再於8站轉乘站增加日語廣播，預計8月底上線，提供更國際化的服務。依交通部觀光局觀光統計資料，107年至112年3月，日本觀光客累計約342萬人次，其次為韓國觀光客累計約214 萬人次。依新住民全球新聞網資料顯示，近年韓國來台自由行旅客明顯增加，從社群打卡情形及網路相關討論，觀察韓國旅客來臺的雙北熱門景點，包括臺北101、華山文創園區、永康街、西門町、淡水、九份、平溪等，因此規劃以鄰近韓國旅客熱門景點車站及重要轉乘站共15個車站，增加韓語廣播。臺北捷運自107年8月10日起陸續於鄰近日本旅客熱門景點如士林、臺北101/世貿站等13個車站，增設列車到站日語廣播，考量觀光客轉乘需求，再於民權西路、松江南京、忠孝新生、古亭、南京復興、忠孝復興、大安及南港展覽館等8站新增日語廣播，總計提供列車到站日語廣播的車站共有21站。臺北捷運表示，未來新增的列車到站廣播方式，將調整為國、外(含英日韓語)、閩、客，車門上方顯示器則是以中、英文(含車站代碼以利各國遊客辨識)輪流播放到站站名，未來將持續蒐集國際觀光旅客需求調整更新。此外，為了讓日韓語廣播發音更為妥適，這次新增的列車到站日韓廣播，將請錄製單位選定專業錄音員，並委請專家學者協助審聽，以臻完善。臺北捷運廣播語言係依「大眾運輸工具播音語言平等保障法」第6條規定：「大眾運輸工具除國語外，另應以閩南語、客家語播音。」以及北市府為考量臺北都會區之國際化發展趨勢，依此提供國語、英語、閩南語及客家語4種播音語言，相關車站增設列車到站日韓語廣播，均已考量列車到站前可播放完畢。相關訊息可洽臺北捷運公司24小時客服專線(02)218-12345、臺北市民當家熱線：1999（外縣市02-27208889）或瀏覽本公司網站(https://www.metro.taipei/)。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=524F3E32210390E7",
      "StartTime": "2023-06-06T11:13:00+08:00",
      "EndTime": "2023-07-06T11:13:00+08:00",
      "PublishTime": "2023-06-06T11:13:00+08:00",
      "UpdateTime": "2023-06-06T11:13:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "8987913",
      "Title": "6/15起基北北桃1200定期票開放預購  1280定期票退費免擔心 捷運站詢問處、自動售票機均可辦理 手續簡單權益有保障",
      "NewsCategory": "新聞稿",
      "Description":
          "臺北市政府交通局宣布基北北桃1200定期票於6月15日開始預購，為利民眾了解相關資訊，臺北捷運公司網站已公告使用須知及民眾常見問題，歡迎民眾上網查詢。為方便1280定期票民眾辦理退費，臺北捷運公司自6月15日起，除車站詢問處受理外，另開放各捷運車站自動售票加值機退費服務，歡迎民眾多加利用。由基隆市政府、臺北市政府、新北市政府及桃園市政府共同推出基北北桃1200定期票，自6月15日開始，臺北捷運各車站詢問處及自動售票加值機開放預購，7月1日起正式啟用。使用1280定期票的旅客，如果沒有擴大使用範圍或其他運具需求，可持續使用至期滿為止，再購買基北北桃1200定期票。至於有擴大使用範圍或其他運具需求的1280定期票旅客，由於每張票卡只能設定一種定期票，建議可先利用另外一張票卡設定基北北桃1200定期票，1280定期票如需退票可選擇人潮較少的時段至臺北捷運各車站詢問處或自動售票機辦理退費，只要不使用1280定期票，就不會影響退費金額，請大家放心。如手邊沒有第二張票卡，建議7月1日起利用週末人潮較少的時段，至臺北捷運各車站申請1280定期票退費，再購買基北北桃1200定期票。現行的1280定期票販售至6月30日止，歡迎多加利用定期票退票線上申請網頁，避開捷運車站退費人潮，相關規定可瀏覽臺北捷運公司網站。◎適用範圍基北北桃1200定期票適用範圍包括：臺北捷運、新北捷運(含輕軌路線)、桃園機場捷運、基隆市區公車路線、新北市區公車路線、臺北市聯營公車路線、桃園市區公車路線、基北北桃範圍內的公路及國道客運。臺鐵適用範圍則有：起訖站均位於縱貫線的基隆站至桃園市新富站，宜蘭線八堵站至福隆站，以及支線深澳線及平溪線各車站間、不限車種列車均適用；提醒大家，具有專屬性及不發售無票座對號列車則不適用，例如：觀光、團體、太魯閣、普悠瑪、EMU3000列車等。新北市及臺北市YouBike&nbsp;站點借車，前30分鐘免費；桃園市YouBike&nbsp;站點借車，前60分鐘免費。◎購票方式及地點民眾可持悠遊卡、Samsung Wallet悠遊卡、SuperCard超級悠遊卡、電信悠遊卡、悠遊聯名卡或悠遊Debit卡(票卡效期需60天以上）、學生卡、數位學生證，自6月15日起至臺北捷運及桃園機場捷運各車站(A20興南站除外)、新北捷運設置詢問處的車站、臺鐵車站指定售票窗口(7月1日開放購票)、臺北市政府轉運站悠遊卡客服中心、國光客運(基隆站、臺北站、新北板橋轉運站、南港轉運站、桃園機場站及中壢站)悠遊卡售票加值機購買；使用SuperCard&nbsp;超級悠遊卡、Samsung Wallet悠遊卡的民眾，可利用悠遊卡公司授權支付App購買。◎適用票種目前開放悠遊卡設定基北北桃1200定期票，後續俟其他票證公司完成準備後，將陸續開放使用。至於敬老、愛心及優待卡等優惠票種，已依法提供大眾運輸搭乘優惠，因此無法設定基北北桃1200定期票。交通部公路總局發行的TPASS悠遊卡，每張售價100元，已於5月18日起開放民眾至四大超商預購，6月15日起可取貨，後續完成票卡記名後，可將100元退還至票卡內，建議可使用TPASS票卡，預購基北北桃1200定期票，詳細資訊可洽悠遊卡公司官網。◎首次啟用期限及方式&nbsp;基北北桃1200定期票僅限一人使用，如果超過30天沒有啟用，該定期票將失效，須辦理退費後重新購買（須加收手續費）。例如：&nbsp;7月1日持悠遊卡購買，最遲必須於7月30日晚上12點前首次啟用。啟用方式非常簡單，將票卡輕觸捷運或臺鐵車站自動收費進站閘門，或公車、國道客運、公路客運、輕軌驗票機，即可啟用。定期票無法於YouBike站點啟用，持卡人須先加入YouBike會員並以該悠遊卡卡號註冊，始可享臺北市及新北市YouBike站點借車前30分鐘免費、桃園市YouBike站點借車前60分鐘免費優惠。◎定期票使用期間及續購方式定期票有效期間為自啟用當天開始起算連續30日，可透過臺北捷運車站車票查詢機查詢，或於捷運、臺鐵閘門、輕軌及公車驗票機螢幕了解使用期限。例如：7月5日持悠遊卡設定基北北桃1200定期票，7月10日啟用，有效期間為7月10日至8月8日。定期票有效期間屆滿後，持卡人可再擇日重新購買，或者持原票卡在有效期間屆滿前10日起(即啟用後第21日)，至臺北捷運及桃園機場捷運各車站(A20興南站除外)、新北捷運設置詢問處的車站、臺鐵車站指定售票窗口、臺北市政府轉運站悠遊卡客服中心、國光客運(基隆站、臺北站、新北板橋轉運站、南港轉運站、桃園機場站及中壢站)悠遊卡售票加值機續購。使用SuperCard超級悠遊卡、Samsung Wallet悠遊卡等，可透過悠遊卡公司授權支付App辦理續購。例如：7月10日第一次使用定期票，可自7月30日起續購，續購的定期票將於原有效期限8月8日翌日（即8月9日）自動啟用，延長使用期限至9月7日。有效期間屆滿，如不再購買定期票，民眾仍可持原票卡搭車，票卡則恢復原電子票證的計費方式。基隆市政府、臺北市政府、新北市政府及桃園市政府共同發行的基北北桃1200定期票，主要是為鼓勵民眾多多搭乘大眾運輸工具，給予遠距離及重度使用大眾運具者更多優惠，對通勤族可說是一大福音。相關訊息歡迎洽詢臺北捷運公司24小時客服專線(02)218-12345、臺北市民當家熱線：1999（外縣市02-27208889）或瀏覽本公司網站(https://www.metro.taipei/)。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=07CB59A36B951382",
      "StartTime": "2023-05-31T11:12:00+08:00",
      "EndTime": "2023-06-30T11:12:00+08:00",
      "PublishTime": "2023-05-31T11:12:00+08:00",
      "UpdateTime": "2023-05-31T11:12:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "8986539",
      "Title": "嚴陣以待瑪娃颱風 北捷全力做好準備！",
      "NewsCategory": "新聞稿",
      "Description":
          "因應瑪娃颱風來襲，臺北捷運公司密切注意颱風動向，確保颱風期間捷運系統和旅客安全，並已依據防颱防洪SOP（標準作業程序），展開防颱布署及應變準備。颱風期間營運訊息將透過臺北市政府及臺北捷運公司網站、「台北捷運GO」App、車站旅客資訊系統、廣播系統、張貼告示及媒體宣導等方式公告。颱風瞬間陣風達一定程度，捷運系統、貓空纜車及兒童新樂園即會暫停營運，請民眾注意：淡水信義線、松山新店線（小碧潭站）、文湖線等路線的高架及平面段，當實際瞬間風速達10級風以上，或10分鐘內之平均風速達7級風時，即依照標準作業程序暫停營運；中和新蘆線、板南線，以及松山新店線、淡水信義線等地下段部分，仍將繼續運轉，並依人潮狀況彈性調整營運班距。此外，貓空纜車當發布陸上颱風警報(警戒區域含臺北地區)後，將視風雨情況決定是否暫停營運；若臺北市政府宣布停止上班或上課，將暫停營運。兒童新樂園當發布陸上颱風警報(警戒區域含臺北地區)後，將視風雨情況決定遊樂設施是否暫停營運；若臺北市政府宣布停止上班或上課，將暫停營運。為預防颱風帶來豪雨，捷運全系統（包括捷運機廠、車站，及停車場、地下商店街）、貓空纜車、兒童新樂園及臺北小巨蛋，均已加強檢視各項防洪設備，如防洪閘門及抽水機等，並完成防颱整備作業。長達7個月的防汛期（5月至11月），北捷啟動各場站防汛整備及強化防汛設施設備檢視、測試作業，無論小如手提式抽水機，大至隧道內全斷面防水隔艙閘門，均有一套完整保養測試及訓練SOP，確保防洪設施設備功能運作妥善。颱風期間也將透過中央氣象局及經濟部水利署網頁監看即時雨量，另隨時監測捷運周邊河川如基隆河、新店溪、大漢溪水位警戒情形，納入營運模式及是否停止營運參考。臺北捷運各車站出入口，依捷運防洪設計高程為200年頻率洪水位加高110公分，提升防洪能力，另部分重要車站隧道設置有防水隔艙閘門，避免因捷運隧道經過斷層帶、過河段或出土段等可能湧水處，造成洪水侵入隧道並漫延至捷運沿線各車站，形成重大損失。相關營運資訊請瀏覽本公司網站(https://www.metro.taipei) 或洽本公司24小時客服專線：（02）218-12345，或臺北市民當家熱線1999(外縣市02-27208889)。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=C25C9A62D36C4EE5",
      "StartTime": "2023-05-29T14:10:00+08:00",
      "EndTime": "2023-06-29T14:10:00+08:00",
      "PublishTime": "2023-05-29T14:10:00+08:00",
      "UpdateTime": "2023-05-29T14:10:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "8986314",
      "Title": "臺北捷運✕Semeur聖娜寵愛App會員 端午大放「粽」！",
      "NewsCategory": "新聞稿",
      "Description":
          "端午限定大放「粽」！臺北捷運公司與烘焙連鎖品牌「Semeur聖娜」聯手寵愛會員，6月1日至22日加入「台北捷運GO」App會員綁卡搭捷運，活動期間每搭乘一次捷運即抽獎一次，有機會帶回大杯紅茶及冰心粽2包85折優惠券，新會員加碼送蜂蜜小可頌優惠券，相關訊息請關注臺北捷運臉書粉絲專頁。&nbsp;南粽、北粽哪個好？端午節「粽」頭戲來了，臺北捷運廣召會員一起過端午，建議不妨選個冰心粽，再來杯紅茶及蜂蜜小可頌，沁涼過端午。&nbsp;◎冰心粽-2包85折優惠券「Semeur聖娜」與「卡娜赫拉的小動物」聯名的超萌包裝冰心粽，精選人氣暢銷口味水晶紅豆、黑糖花生及水晶芝麻，外皮透亮Q彈滑嫩，內餡飽滿扎實！活動期間憑優惠券至門市口味任選，貼心提醒，兌換至6月22日止。&nbsp;冰心粽「水晶紅豆」口味，嚴選在地好食材，精心熬煮的紅豆餡料，讓紅豆香氣在口中自然綻放，打造回味再三的經典風味。「黑糖花生」口味，將黑糖及花生巧妙融合，相互襯托出醇厚甜味口感，還可吃到花生顆粒，是今年夏季最棒享受！「水晶芝麻」口味，透亮的薄外皮包裹飽滿的黑芝麻，一口咬下層層堆疊的好味道，讓人意猶未盡，還想再吃一個。&nbsp;◎經典冰紅茶-大杯銅板價50元嚴選紅茶清爽又順口，搭配冰心粽或麵包糕點，絕對是速配組合，活動兌換至7月10日止。&nbsp;◎蜂蜜小可頌表面塗上以龍眼蜜為基底的蜂蜜醬，咬下的口感酥脆甜香、清爽不膩，相當適合當作點心或小零嘴，活動兌換至7月10日止。&nbsp;想要成為臺北捷運會員很簡單，下載「台北捷運GO」App，點選右上角選單中「登入/加入會員」，輸入會員資料，透過手機簡訊認證即可；如已下載者，可直接更新至最新版本，無須再重新下載。當加入App會員後，活動獎項匯入「我的優惠券」項目，前往門市秀出優惠券兌換，隨時享有美好的捷運日常生活。&nbsp;相關資訊可洽詢本公司24小時客服專線：（02）218-12345，或臺北市民當家熱線1999(外縣市02-27208889)或瀏覽本公司網站（https://www.metro.taipei/）。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=5E4E098653CBBBC6",
      "StartTime": "2023-05-29T10:01:00+08:00",
      "EndTime": "2023-06-29T10:01:00+08:00",
      "PublishTime": "2023-05-29T10:01:00+08:00",
      "UpdateTime": "2023-05-29T10:01:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "8985236",
      "Title": "2023捷運盃街舞大賽 總獎金138萬元 即日起開始報名！代言人鼓鼓、容容、B.T.O.D與夏沐 共邀舞林高手參賽",
      "NewsCategory": "新聞稿",
      "Description":
          "舞林界最大盛事「2023捷運盃街舞大賽」，即日起開始報名！歡迎舞林高手至捷運盃街舞大賽官網踴躍報名參加，展現街舞的動感活力，互相切磋舞技一較高下，高達138萬元的總獎金等你來爭取。今年適逢嘻哈文化50周年，而街舞與嘻哈文化正源自於紐約的街頭及地鐵。2023捷運盃街舞大賽特別以「來自街頭的力量」為主題，首度移師至捷運北投機廠舉辦，邀請大家「到北投BATTLE」。現場除搭建賽事主舞台外，還要讓霹靂舞海選「跳進」軌道維修工場，給選手們最特別的競賽體驗。持續走向國際化的捷運盃街舞大賽，今年更特地邀請到來自韓國、日本、美國的國際舞者擔任示範演出及客座評審；並舉辦分享論壇，提供國內外優秀選手經驗交流的機會。在8月19、20日初賽，8月26、27日決賽當天，也將搭配嘻哈音樂、DJ Battle、代言人演出等活動，舉辦熱鬧的「2023捷運盃街舞大賽嘻哈嘉年華」。帶給大家充滿街頭潮流元素的豐富饗宴，歡迎熱愛街舞的朋友一起來玩！今年捷運盃街舞大賽由鼓鼓(呂思緯)、容容、B.T.O.D與夏沐擔任代言人，一起推廣街舞魅力。5月25日記者會當天，鼓鼓更帶來精湛歌舞演出，期盼每一年的街舞大賽選手們都能有不同的火花、激發更多的創意。◎排舞賽8月19、20日進行初賽，8月26、27日進行決賽，地點為捷運北投會館。排舞賽分為YOUTH組及ADULT組，各組冠軍可獲得獎金新臺幣16萬元、亞軍10萬元、季軍5萬元、優勝(3隊)每隊2萬元、舞出勇敢獎(4隊)每隊 2,500元。各組別冠軍隊伍將可申請最高20萬元國際比賽補助(每人以3萬元為限)。◎霹靂舞賽賽事將於8月26日進行海選，陸續選出十六強、八強及四強，緊接著當天舉行冠軍賽。冠軍可分別獲得獎金新臺幣10萬元、亞軍4萬元、季軍2萬元。冠軍隊伍將可申請6萬元國際比賽補助(每人以3萬元為限)。由臺北捷運公司、國泰世華銀行共同主辦的「捷運盃街舞大賽」，多年來孕育許多優秀舞團或舞者，期盼賽事廣為宣傳紮根，持續舞動正能量，完整表現舞蹈的力與美。詳細活動內容、時間及參賽辦法等，請至街舞大賽官網或洽詢本公司24小時客服專線：（02）218-12345，或臺北市民當家熱線1999(外縣市02-27208889)或瀏覽本公司網站(https://www.metro.taipei/)。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=996CEE6081886B1C",
      "StartTime": "2023-05-25T14:32:00+08:00",
      "EndTime": "2023-06-25T14:32:00+08:00",
      "PublishTime": "2023-05-25T14:32:00+08:00",
      "UpdateTime": "2023-05-25T14:32:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "8984278",
      "Title": "臺北捷運公司說明 車站口罩販賣機未販售未經授權口罩",
      "NewsCategory": "新聞稿",
      "Description":
          "關於媒體本(23)日報導，有廠商承租口罩販賣機販賣未經授權的口罩，銷售點包括捷運車站。臺北捷運公司澄清，旅客在捷運車站所購買的口罩，並非該廠商提供的產品；至於報載廠商的口罩販賣機原本預計設置於環狀線幸福站及板橋站，因設備問題未通過竣工查驗，期間皆未營業，未售出相關商品，敬請旅客放心。&nbsp;臺北捷運公司表示，報載廠商的口罩販賣機於110年7月間，原規劃於環狀線幸福站及環狀線板橋站，設置自動販賣機販售，因設備問題未通過竣工查驗，期間皆未營業，亦無售出相關商品，後續本公司依契約規定於去(111)年5月解除契約。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=B6BB06B05FC845C5",
      "StartTime": "2023-05-23T18:26:00+08:00",
      "EndTime": "2023-06-23T18:26:00+08:00",
      "PublishTime": "2023-05-23T18:26:00+08:00",
      "UpdateTime": "2023-05-23T18:26:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "8978181",
      "Title": "臺北市議會9日交通部門質詢    臺北捷運公司活化場站空間 商業設置均以公共安全為優先考量",
      "NewsCategory": "新聞稿",
      "Description":
          "有關本(9)日臺北市議會交通部門質詢，議員關心忠孝新生站付費區內設置攤車一事，臺北捷運公司表示，本案依據111年11月公告《捷運場域商業展售實施辦法》設置，同時攤車位置並不影響消防設備及旅客通行；經檢討後，將以非付費區為優先實施範圍。臺北捷運公司說明，依據臺北捷運111年11月公告《捷運場域商業展售實施辦法》，忠孝新生站付費區內通道商業攤位設置，為活化場站空間，開放短期租借舉辦各類型商業展售活動，凡經政府登記立案之企業、公司行號、公私立團體均可依規定申請，提供旅客便利的生活體驗服務；且疫情後活絡地方經濟，利用捷運場站位置及人流優勢，開放捷運廣場及部分場域，短期租借舉辦商業展售會。臺北捷運公司強調，忠孝新生站付費區內通道的攤車，非固定式且可移動，設置位置不影響消防設備、逃生動線及防煙區劃等設計及規範；並且重申，任何計畫擬定及實施，均以公共安全為第一優先考量，經檢討後，實施範圍將以非付費區為優先辦理區域。同時，依據《臺北大眾捷運系統附屬事業經營管理辦法》規定，不得於禁止飲食區內販賣食品、飲料、檳榔、香菸及口香糖等物品，忠孝新生站室內場域因屬禁食區內，故該場域限定不得販售食品、僅能作為文創市集使用。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=36C183D94307D977",
      "StartTime": "2023-05-09T16:46:00+08:00",
      "EndTime": "2023-06-09T16:46:00+08:00",
      "PublishTime": "2023-05-09T16:46:00+08:00",
      "UpdateTime": "2023-05-09T16:46:00+08:00"
    },
    {
      "Region": "TRTC",
      "NewsID": "8976180",
      "Title": "中山站配合1號出口增設為雙向電扶梯施工  往象山月臺前端 5月9日起架設圍籬防護 請旅客多加留意",
      "NewsCategory": "新聞稿",
      "Description":
          "封閉改造中的臺北捷運中山站1號出口，即將進行增設雙向電扶梯施工，5月9日起該站淡水信義線往象山方向月臺（2月臺）前端部分區域（即月臺南端），將架設防護設施，屆時部分上下車動線會受影響，請旅客多加留意，配合使用引導動線，亦可洽車站詢問處或服務人員協助。一時不便期待未來更方便，請大家見諒並配合。臺北捷運公司說明，本工程是增設中山站1號出口至大廳層為雙向電扶梯，因構築電扶梯機坑需求，必須於往象山方向的2月臺前端區架設防護設施。施工期間，現場將使用微型擴音器語音加強提醒，請行經該區域旅客留意，車站亦加派服務人員引導，確保動線順暢。本項作業預計於今年11月底完成，屆時將撤除月臺區大部分施工圍籬。相關資訊可洽詢本公司24小時客服專線：（02）218-12345，或臺北市民當家熱線1999(外縣市02-27208889)或瀏覽本公司網站（https://www.metro.taipei/）。",
      "NewsURL":
          "https://www.metro.taipei/News_Content.aspx?n=30CCEFD2A45592BF&s=6C7604E0D3DBCBDC",
      "StartTime": "2023-05-05T10:00:00+08:00",
      "EndTime": "2023-06-05T10:00:00+08:00",
      "PublishTime": "2023-05-05T10:00:00+08:00",
      "UpdateTime": "2023-05-05T10:00:00+08:00"
    },
    {
      "Region": "KRTC",
      "NewsID": "act_348",
      "Title": "【揪咖來高雄】蜜柑站長與貓貓蟲咖波相見歡~聯名商品銷售須知.ᐟ.ᐟ.ᐟ",
      "NewsCategory": "活動訊息",
      "Description":
          "一、商品清單(詳附圖)：\r\n1.可愛折疊收納袋(1款) 350/個\r\n2.刺繡襪(22-25cm)(2款:咖波-藍/蜜柑咖波-黑白) 150/雙\r\n3.票卡夾掛繩組(1款) ${360}/個\r\n4.金屬胸針(2款:咖波輕軌在一起/蜜柑) ${160}/個\r\n5.壓克力鑰匙圈(2款:咖波與蜜柑/輕軌與咖波) ${200}/個\r\n6.造型明信片(6款:咖波車長/咖波輕軌在一起/咖波坐輕軌兜風/咖波小雞/咖波好...",
      "NewsURL":
          "https://www.krtc.com.tw/Information/events_more?id=845d350e445040b285a5c118a621a31c",
      "StartTime": "2023-07-12T00:00:00+08:00",
      "EndTime": "2037-12-31T23:59:59+08:00",
      "PublishTime": "2023-07-12T00:00:00+08:00",
      "UpdateTime": "2023-07-20T09:37:28+08:00"
    },
    {
      "Region": "KRTC",
      "NewsID": "news_1106",
      "Title": "高雄捷運「蜜柑站長」攜手「貓貓蟲咖波」 邀你揪咖來高雄，可愛到膨脹！",
      "NewsCategory": "新聞稿",
      "Description":
          "暑假期間高市府夏日最強企畫「海洋派對‧高雄聯萌」活動登場，本週在愛河灣陸續出現三座超大型氣球裝置，一上場就引起粉絲尖叫拍照並在社群管道瘋狂流傳，其中兩個角色就是全國最萌的高雄捷運「蜜柑站長」，以及百萬粉絲台灣原創IP角色「貓貓蟲咖波」。而兩個超高人氣角色，今日(7/15)共同在高雄捷運美麗島站舉行聯名記者會，吸引眾多粉絲前來追星，記者會後粉絲們更相約要搭乘捷運到O1西子灣站，再轉搭輕軌聯名彩繪列車...",
      "NewsURL":
          "https://www.krtc.com.tw/Information/news_more?id=f27b2076dba84ad1a61919bf66d4fdfe",
      "StartTime": "2023-07-21T00:00:00+08:00",
      "EndTime": "2037-12-31T23:59:59+08:00",
      "PublishTime": "2023-07-21T00:00:00+08:00",
      "UpdateTime": "2023-07-21T08:14:00+08:00"
    },
    {
      "Region": "KRTC",
      "NewsID": "act_350",
      "Title": "112年《小小站長體驗營》8月份暑假活動各梯錄取名單、繳費方式",
      "NewsCategory": "活動訊息",
      "Description":
          "一、感謝大家對於《小小站長體驗營》的熱烈支持，各梯次錄取名單請參考附件資料，並已E-mail通知錄取者。\r\n二、各梯次活動費用為新台幣700元，請錄取者於7月25日止完成繳費作業，繳費方式請連結繳費網址(以E-mail提供錄取者)。未於指定期間內完成繳費，將取消錄取資格並通知備取者遞補。\r\n三、繳費後如因個人因素不克參加者，請於該梯次活動開始日三天前以電話通知本公司，需自付退費匯費，活動前兩天通知...",
      "NewsURL":
          "https://www.krtc.com.tw/Information/events_more?id=232cc0b82c1d405bb3d7c9dc338a8b6f",
      "StartTime": "2023-07-20T00:00:00+08:00",
      "EndTime": "2023-07-31T23:59:00+08:00",
      "PublishTime": "2023-07-20T00:00:00+08:00",
      "UpdateTime": "2023-07-20T09:37:37+08:00"
    },
    {
      "Region": "KLRT",
      "NewsID": "act_348",
      "Title": "【揪咖來高雄】蜜柑站長與貓貓蟲咖波相見歡~聯名商品銷售須知.ᐟ.ᐟ.ᐟ",
      "NewsCategory": "活動訊息",
      "Description":
          "一、商品清單(詳附圖)：\r\n1.可愛折疊收納袋(1款) ${350}/個\r\n2.刺繡襪(22-25cm)(2款:咖波-藍/蜜柑咖波-黑白) ${1}{50}/雙\r\n3.票卡夾掛繩組(1款) ${360}/個\r\n4.金屬胸針(2款:咖波輕軌在一起/蜜柑) ${160}/個\r\n5.壓克力鑰匙圈(2款:咖波與蜜柑/輕軌與咖波) ${200}/個\r\n6.造型明信片(6款:咖波車長/咖波輕軌在一起/咖波坐輕軌兜風/咖波小雞/咖波好...",
      "NewsURL":
          "https://www.krtc.com.tw/Information/events_more?id=845d350e445040b285a5c118a621a31c",
      "StartTime": "2023-07-12T00:00:00+08:00",
      "EndTime": "2037-12-31T23:59:59+08:00",
      "PublishTime": "2023-07-12T00:00:00+08:00",
      "UpdateTime": "2023-07-20T09:37:28+08:00"
    },
    {
      "Region": "KLRT",
      "NewsID": "act_350",
      "Title": "112年《小小站長體驗營》8月份暑假活動各梯錄取名單、繳費方式",
      "NewsCategory": "活動訊息",
      "Description":
          "一、感謝大家對於《小小站長體驗營》的熱烈支持，各梯次錄取名單請參考附件資料，並已E-mail通知錄取者。\r\n二、各梯次活動費用為新台幣700元，請錄取者於7月25日止完成繳費作業，繳費方式請連結繳費網址(以E-mail提供錄取者)。未於指定期間內完成繳費，將取消錄取資格並通知備取者遞補。\r\n三、繳費後如因個人因素不克參加者，請於該梯次活動開始日三天前以電話通知本公司，需自付退費匯費，活動前兩天通知...",
      "NewsURL":
          "https://www.krtc.com.tw/Information/events_more?id=232cc0b82c1d405bb3d7c9dc338a8b6f",
      "StartTime": "2023-07-20T00:00:00+08:00",
      "EndTime": "2023-07-31T23:59:00+08:00",
      "PublishTime": "2023-07-20T00:00:00+08:00",
      "UpdateTime": "2023-07-20T09:37:37+08:00"
    },
    {
      "Region": "KLRT",
      "NewsID": "news_1106",
      "Title": "高雄捷運「蜜柑站長」攜手「貓貓蟲咖波」 邀你揪咖來高雄，可愛到膨脹！",
      "NewsCategory": "新聞稿",
      "Description":
          "暑假期間高市府夏日最強企畫「海洋派對‧高雄聯萌」活動登場，本週在愛河灣陸續出現三座超大型氣球裝置，一上場就引起粉絲尖叫拍照並在社群管道瘋狂流傳，其中兩個角色就是全國最萌的高雄捷運「蜜柑站長」，以及百萬粉絲台灣原創IP角色「貓貓蟲咖波」。而兩個超高人氣角色，今日(7/15)共同在高雄捷運美麗島站舉行聯名記者會，吸引眾多粉絲前來追星，記者會後粉絲們更相約要搭乘捷運到O1西子灣站，再轉搭輕軌聯名彩繪列車...",
      "NewsURL":
          "https://www.krtc.com.tw/Information/news_more?id=f27b2076dba84ad1a61919bf66d4fdfe",
      "StartTime": "2023-07-21T00:00:00+08:00",
      "EndTime": "2037-12-31T23:59:59+08:00",
      "PublishTime": "2023-07-21T00:00:00+08:00",
      "UpdateTime": "2023-07-21T08:14:00+08:00"
    }
  ];

  var test;
  var selected = [];
  var selected1 = [];
  List<String> City = [];
  List<String> Way = [];

  Color get primaryColor => Theme.of(context).primaryColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            width: 600,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: 230,
                        color: Color.fromARGB(40, 82, 145, 228),
                        child: SmartSelect<String>.multiple(
                          title: '選擇縣市',
                          placeholder: 'Choose City',
                          
                          selectedValue: City,
                          onChange: (selected) => setState(
                              () => {City = selected.value, print(City)}),
                          choiceItems:
                              S2Choice.listFrom<String, Map<String, String>>(
                            source: choices.city,
                            value: (index, item) => item['value'] ?? '',
                            title: (index, item) => item['title'] ?? '',
                            group: (index, item) => item['body'] ?? '',
                          ),
                          choiceActiveStyle:
                              const S2ChoiceStyle(color: Colors.redAccent),
                          modalType: S2ModalType.bottomSheet,
                          modalConfirm: true,
                          
                          modalFilter: true,
                          groupEnabled: true,
                          groupSortBy: S2GroupSort.byCountInDesc(),
                          groupBuilder: (context, state, group) {
                            return StickyHeader(
                              header: state.groupHeader(group),
                              content: state.groupChoices(group),
                            );
                          },
                          groupHeaderBuilder: (context, state, group) {
                            return Container(
                              color: primaryColor,
                              padding: const EdgeInsets.all(15),
                              alignment: Alignment.centerLeft,
                              child: S2Text(
                                text: group.name,
                                highlight: state.filter?.value,
                                highlightColor: Colors.teal,
                                style: const TextStyle(color: Colors.white),
                              ),
                            );
                          },
                          tileBuilder: (context, state) {
                            return S2Tile.fromState(
                              state,
                              isTwoLine: true,
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: 230,
                        color: Color.fromARGB(40, 82, 145, 228),
                        child: SmartSelect<String>.multiple(
                          title: '選擇道路',
                          placeholder: 'Choose way',
                          selectedValue: Way,
                          onChange: (selected) =>
                              setState(() => {Way = selected.value}),
                          choiceItems:
                              S2Choice.listFrom<String, Map<String, String>>(
                            source: choices.way,
                            value: (index, item) => item['value'] ?? '',
                            title: (index, item) => item['title'] ?? '',
                            group: (index, item) => item['body'] ?? '',
                          ),
                          choiceActiveStyle:
                              const S2ChoiceStyle(color: Colors.redAccent),
                          modalType: S2ModalType.bottomSheet,
                          modalConfirm: true,
                          modalFilter: true,
                          groupEnabled: true,
                          groupSortBy: S2GroupSort.byCountInDesc(),
                          groupBuilder: (context, state, group) {
                            return StickyHeader(
                              header: state.groupHeader(group),
                              content: state.groupChoices(group),
                            );
                          },
                          groupHeaderBuilder: (context, state, group) {
                            return Container(
                              color: primaryColor,
                              padding: const EdgeInsets.all(15),
                              alignment: Alignment.centerLeft,
                              child: S2Text(
                                text: group.name,
                                highlight: state.filter?.value,
                                highlightColor: Colors.teal,
                                style: const TextStyle(color: Colors.white),
                              ),
                            );
                          },
                          tileBuilder: (context, state) {
                            return S2Tile.fromState(
                              state,
                              isTwoLine: true,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: tttt.length,
                        itemBuilder: (context, index) {
                          final news = tttt[index];
                          return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ListTile(
                                leading: Column(
                                  children: [
                                    Container(
                                        child: Image.memory(
                                      base64Decode(state.profile['avatar']),
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    )),
                                  ],
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 1, horizontal: 30),
                                title: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          news['UpdateTime'].toString(),
                                          style: TextStyle(fontSize: 10),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            news['Title'].toString(),
                                            style: TextStyle(fontSize: 15),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                subtitle: Text(news['NewsCategory'].toString()),
                                trailing: const Icon(Icons.arrow_forward_ios,size: 30,),
                                onTap: () {
                                  EasyLoading.show(status: 'loading...');
                                  if (news['NewsURL'].toString() != '') {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                WebViewExample(
                                                    tt: news['NewsURL']
                                                        .toString())));
                                  }
                                },
                              ));
                        }))
              ],
            )),
      ),
    );
  }
}
