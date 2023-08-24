// 추천 완료된 종목 리스트
class PredictedTickerList{
  late String play_time;
  late String ticker;
  late String name;

  PredictedTickerList({
    required this.play_time,
    required this.ticker,
    required this.name,
});

  PredictedTickerList.fromMap(Map<String, dynamic>? map) {
    play_time = map?['play_time'] ?? '';
    ticker = map?['ticker'] ?? '';
    name = map?['name'] ?? '';
  }
}

//  추천 완료된 예측 일-분 데이터
class PredictedTickerData{
  late int xaxis;
  late int yprice;

  PredictedTickerData({
    required this.xaxis,
    required this.yprice,
});

  PredictedTickerData.fromMap(Map<String, dynamic>? map) {
    xaxis = map?['xaxis'] ?? '';
    yprice = map?['yprice'] ?? '';
  }
}

//  추천 완료된 예측 일 시세정보
class TickerSubLabelData{
  late int yest_high;
  late int yest_low;
  late int yest_close;
  late double day1_high;
  late double day1_low;
  late int day1_buy_price;
  late double day2_high;
  late double day2_low;
  late int day2_sale_price;

  TickerSubLabelData({
    required this.yest_high,
    required this.yest_low,
    required this.yest_close,
    required this.day1_high,
    required this.day1_low,
    required this.day1_buy_price,
    required this.day2_high,
    required this.day2_low,
    required this.day2_sale_price,
  });

  TickerSubLabelData.fromMap(Map<String, dynamic>? map) {
    yest_high = map?['yest_high'] ?? 0;
    yest_low = map?['yest_low'] ?? 0;
    yest_close = map?['yest_close'] ?? 0;
    day1_high = map?['day1_high'] ?? 0;
    day1_low = map?['day1_low'] ?? 0;
    day1_buy_price = map?['day1_buy_price'] ?? 0;
    day2_high = map?['day2_high'] ?? 0;
    day2_low = map?['day2_low'] ?? 0;
    day2_sale_price = map?['day2_sale_price'] ?? 0;
    
  }
}