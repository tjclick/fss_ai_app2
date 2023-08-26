import 'dart:convert';

import 'package:fss_ai_app2/config/set_const.dart';
import 'package:fss_ai_app2/models/analysis_model.dart';
import 'package:http/http.dart' as http;

class AnalysisProviders{
  static const baseUrl = SetConfigInfo.baseUrl;
  
  // 추천 확인된 종목의 예측 데이타
  Future<List<TickerDailySiseData>> getTickerDailySiseData(String ticker) async {
    List<TickerDailySiseData> pTDSiseData = [];
    final response = await http.get(
      Uri.parse('$baseUrl/analysis/TickerDailySiseData?ticker=$ticker'),
    );
    if (response.statusCode == 200) {
      pTDSiseData = jsonDecode(response.body).map<TickerDailySiseData>( (analysisdatamap) {
        return TickerDailySiseData.fromMap(analysisdatamap);
      }).toList();
    }
    return pTDSiseData;
  }

  // analysis_point_list 에서 사용
  Future<List<TickerPointListData>> getTickerPointListData(String ticker) async {
    List<TickerPointListData> pTDPointList = [];
    final response = await http.get(
      Uri.parse('$baseUrl/analysis/TickerPointListData?ticker=$ticker'),
    );
    if (response.statusCode == 200) {
      pTDPointList = jsonDecode(response.body).map<TickerPointListData>( (analysisdatamap) {
        return TickerPointListData.fromMap(analysisdatamap);
      }).toList();
    }
    return pTDPointList;
  }

  // API > 분석 > 일별 거래량 데이타
  Future<List<TickerDailyAmountList>> getTickerDailyAmountList(String ticker) async {
    List<TickerDailyAmountList> pTDAmountData = [];
    final response = await http.get(
      Uri.parse('$baseUrl/analysis/TickerDailyAmountList?ticker=$ticker'),
    );
    if (response.statusCode == 200) {
      pTDAmountData = jsonDecode(response.body).map<TickerDailyAmountList>( (analysisdatamap) {
        return TickerDailyAmountList.fromMap(analysisdatamap);
      }).toList();
    }
    return pTDAmountData;
  }


}

