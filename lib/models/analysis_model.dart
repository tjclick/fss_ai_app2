// 추천 종목 일자별 시세 정보
class TickerDailySiseData{
  late String tds_datetime;
  late int tds_open;
  late int tds_high;
  late int tds_low;
  late int tds_close;
  late double tds_rate;

  TickerDailySiseData({
    required this.tds_datetime,
    required this.tds_open,
    required this.tds_high,
    required this.tds_low,
    required this.tds_close,
    required this.tds_rate,
  });

  TickerDailySiseData.fromMap(Map<String, dynamic>? map) {
    tds_datetime = map?['datetime'] ?? 'yyyymmdd';
    tds_open = map?['open'] ?? 0;
    tds_high = map?['high'] ?? 0;
    tds_low = map?['low'] ?? 0;
    tds_close = map?['close'] ?? 0;
    tds_rate = map?['rate'] ?? 0;
    
  }
}

// 분석 SUB Layer 01 포인트 정보
class TickerPointListData{
  late String play_date;
  late double company;
  late double volume;
  late double economic;
  late double news;
  late double day_rate;
  late double day1_low;
  late double day2_high;

  TickerPointListData({
  required this.play_date,
  required this.company,
  required this.volume,
  required this.economic,
  required this.news,
  required this.day_rate,
  required this.day1_low,
  required this.day2_high,
  });

  TickerPointListData.fromMap(Map<String, dynamic>? map) {
    play_date = map?['play_date'] ?? '';
    company = map?['company'] ?? 0;
    volume = map?['volume'] ?? 0;
    economic = map?['economic'] ?? 0;
    news = map?['news'] ?? 0;
    day_rate = map?['day_rate'] ?? 0;   // double NULL 처리
    day1_low = map?['day1_low'] ?? 0;
    day2_high = map?['day2_high'] ?? 0;
  }
}


class TickerDailyAmountList{
  late String tda_datetime;
  late int tda_gov;
  late int tda_person;
  late int tda_foreign;


  TickerDailyAmountList({
    required this.tda_datetime,
    required this.tda_gov,
    required this.tda_person,
    required this.tda_foreign,
  });

  TickerDailyAmountList.fromMap(Map<String, dynamic>? map) {
    tda_datetime = map?['datetime'] ?? 'yyyymmdd';
    tda_gov = map?['gov'] ?? 0;
    tda_person = map?['person'] ?? 0;
    tda_foreign = map?['foreign'] ?? 0;
  }
}