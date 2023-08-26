//  이력 리스트 모델
class HistoryDailyRateList {
  late String play_date;
  late String ticker;
  late String t_name;
  late int yest_close;
  late String r_low_date;
  late int day1_buy_price;
  late int r_low_price;
  late double g_buy_rate;
  late String r_high_date;
  late int day2_sale_price;
  late int r_high_price;
  late double g_sale_rate;

  HistoryDailyRateList({
    required this.play_date,
    required this.ticker,
    required this.t_name,
    required this.yest_close,
    required this.r_low_date,
    required this.day1_buy_price,
    required this.r_low_price,
    required this.g_buy_rate,
    required this.r_high_date,
    required this.day2_sale_price,
    required this.r_high_price,
    required this.g_sale_rate,
  });

  HistoryDailyRateList.fromMap(Map<String, dynamic>? map) {
    play_date = map?['play_date'] ?? '';
    ticker = map?['ticker'] ?? '';
    t_name = map?['name'] ?? '';
    yest_close = map?['yest_close'] ?? 0;
    r_low_date = map?['r_low_date'] ?? '';
    day1_buy_price = map?['day1_buy_price'] ?? 0;
    r_low_price = map?['r_low_price'] ?? 0;
    g_buy_rate = map?['g_buy_rate'] ?? 0;
    r_high_date = map?['r_high_date'] ?? '';
    day2_sale_price = map?['day2_sale_price'] ?? 0;
    r_high_price = map?['r_high_price'] ?? 0;
    g_sale_rate = map?['g_sale_rate'] ?? 0;
  }
}