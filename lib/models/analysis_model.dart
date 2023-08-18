// 추천 종목 일자별 시세 정보
class TickerDailySiseData{
  late String tds_datetime;
  late int tds_open;
  late int tds_high;
  late int tds_low;
  late int tds_close;
  late int tds_amount;
  late double tds_rate;

  TickerDailySiseData({
    required this.tds_datetime,
    required this.tds_open,
    required this.tds_high,
    required this.tds_low,
    required this.tds_close,
    required this.tds_amount,
    required this.tds_rate,
  });

  TickerDailySiseData.fromMap(Map<String, dynamic>? map) {
    tds_datetime = map?['datetime'] ?? '';
    tds_open = map?['open'] ?? '';
    tds_high = map?['high'] ?? '';
    tds_low = map?['low'] ?? '';
    tds_close = map?['close'] ?? '';
    tds_amount = map?['amount'] ?? '';
    tds_rate = map?['rate'] ?? '';
    
  }
}