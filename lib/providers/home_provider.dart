import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/home_model.dart';

class HomeProviders{
  static const baseUrl = 'http://10.21.1.61:8000/api/home';
  
  // 추천된 종목 리스트
  Future<List<PredictedTickerList>> getPredictedTickerList() async {
    List<PredictedTickerList> pTickerList = [];
    final response = await http.get(
      Uri.parse('$baseUrl/HomePredictedTickerList?code=A001'),
    );
    if (response.statusCode == 200) {
      pTickerList = jsonDecode(response.body).map<PredictedTickerList>( (tickerlistmap) {
        return PredictedTickerList.fromMap(tickerlistmap);
      }).toList();
    }
    return pTickerList;
  }

  // 추천 확인된 종목의 예측 데이타
  Future<List<PredictedTickerData>> getPredictedTickerData(String ticker) async {
    List<PredictedTickerData> pTickerData = [];
    final response = await http.get(
      Uri.parse('$baseUrl/HomePredictedTickerList?code=A002&ticker=$ticker'),
    );
    if (response.statusCode == 200) {
      pTickerData = jsonDecode(response.body).map<PredictedTickerData>( (tickerdatamap) {
        return PredictedTickerData.fromMap(tickerdatamap);
      }).toList();
    }
    return pTickerData;
  }
}