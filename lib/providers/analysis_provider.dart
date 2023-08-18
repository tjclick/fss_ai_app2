import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/analysis_model.dart';

class AnalysisProviders{
  // static const baseUrl = 'https://www.fssai.kr/api/home';
  // static const baseUrl = 'http://10.21.1.61:8000/api/home';
  // static const baseUrl = 'http://192.168.200.179:8000/api/home';
  static const baseUrl = 'http://192.168.200.154:8000/api/analysis';

  // 추천 확인된 종목의 예측 데이타
  Future<List<TickerDailySiseData>> getTickerDailySiseData(String ticker) async {
    List<TickerDailySiseData> pTDSiseData = [];
    final response = await http.get(
      Uri.parse('$baseUrl/TickerDailySiseData?ticker=$ticker'),
    );
    if (response.statusCode == 200) {
      pTDSiseData = jsonDecode(response.body).map<TickerDailySiseData>( (datamap) {
        return TickerDailySiseData.fromMap(datamap);
      }).toList();
    }
    return pTDSiseData;
  }




}