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