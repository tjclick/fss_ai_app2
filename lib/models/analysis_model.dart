// 추천 종목 일자별 시세 정보


class TickerDailySiseData{
  late String tds_datetime;
  // late int tds_open;
  // late int tds_high;
  // late int tds_low;
  // late int tds_close;
  // late int tds_amount;
  // late int tds_buy;
  late double tds_rate;

  TickerDailySiseData({
    required this.tds_datetime,
    // required this.tds_open,
    // required this.tds_high,
    // required this.tds_low,
    // required this.tds_close,
    // required this.tds_amount,
    // required this.tds_buy,
    required this.tds_rate,
  });

  TickerDailySiseData.fromMap(Map<String, dynamic>? map) {
    tds_datetime = map?['datetime'] ?? '';
    // tds_open = map?['open'] ?? '';
    // tds_high = map?['high'] ?? '';
    // tds_low = map?['low'] ?? '';
    // tds_close = map?['close'] ?? '';
    // tds_amount = map?['amount'] ?? '';
    // tds_buy = map?['amount'] ?? '';
    tds_rate = map?['rate'] ?? '';
    
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
    company = map?['company'] ?? '';
    volume = map?['volume'] ?? '';
    economic = map?['economic'] ?? '';
    news = map?['news'] ?? '';
    day_rate = map?['day_rate'] ?? 0.0;   // double NULL 처리
    day1_low = map?['day1_low'] ?? 0.0;
    day2_high = map?['day2_high'] ?? 0.0;
  }
}