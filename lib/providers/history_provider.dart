import 'dart:convert';

import 'package:fss_ai_app2/config/set_const.dart';
import 'package:fss_ai_app2/models/history_model.dart';
import 'package:http/http.dart' as http;

class HistoryProviders {
  static const baseUrl = SetConfigInfo.baseUrl;

  // 추천종목 이력 리스트
  Future<List<HistoryDailyRateList>> getHistoryDailyRateList() async {
    List<HistoryDailyRateList> pTDHistoryList = [];
    final response = await http.get(
      Uri.parse('$baseUrl/history/HistoryDailyRateList?code=H001'),
    );
    if (response.statusCode == 200) {
      pTDHistoryList =
          jsonDecode(response.body).map<HistoryDailyRateList>((histlistmap) {
        return HistoryDailyRateList.fromMap(histlistmap);
      }).toList();
    }
    return pTDHistoryList;
  }
}