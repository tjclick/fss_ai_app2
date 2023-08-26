import 'dart:convert';

import 'package:fss_ai_app2/config/set_const.dart';
import 'package:fss_ai_app2/models/home_model.dart';
import 'package:http/http.dart' as http;

class HomeProviders{
  static const baseUrl = SetConfigInfo.baseUrl;
  
  // 추천된 종목 리스트
  Future<List<PredictedTickerList>> getPredictedTickerList() async {
    List<PredictedTickerList> pTickerList = [];
    final response = await http.get(
      Uri.parse('$baseUrl/home/HomePredictedTickerList?code=A001'),
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
      Uri.parse('$baseUrl/home/HomePredictedTickerList?code=A002&ticker=$ticker'),
    );
    if (response.statusCode == 200) {
      pTickerData = jsonDecode(response.body).map<PredictedTickerData>( (tickerdatamap) {
        return PredictedTickerData.fromMap(tickerdatamap);
      }).toList();
    }
    return pTickerData;
  }

  // 추천 확인된 종목의 예측 데이타
  Future<List<TickerSubLabelData>> getTickerSubLabelData(String ticker) async {
    List<TickerSubLabelData> pTSubLabelData = [];
    final response = await http.get(
      Uri.parse('$baseUrl/home/TickerSubLabelData?code=A003&ticker=$ticker'),
    );
    if (response.statusCode == 200) {
      pTSubLabelData = jsonDecode(response.body).map<TickerSubLabelData>( (datamap) {
        return TickerSubLabelData.fromMap(datamap);
      }).toList();
    }
    return pTSubLabelData;
  }



}