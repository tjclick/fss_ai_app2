import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/home_model.dart';

class HomeProviders{
  static const baseUrl = 'http://10.21.1.61:8000/api/home';

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
}