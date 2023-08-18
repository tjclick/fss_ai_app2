// import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// import '../../models/analysis_model.dart';
// import '../../providers/analysis_provider.dart';

class AnalysisCrawlJson extends StatefulWidget  {
  final String ticker;                        // 상위 위젯 호출시 변수값 전달 받기 위함
  AnalysisCrawlJson({required this.ticker});  // 상위 위젯 호출시 변수값 전달 받기 위함

  @override
  _AnalysisCrawlJsonState createState() => _AnalysisCrawlJsonState();
}

class _AnalysisCrawlJsonState extends State<AnalysisCrawlJson> {
  late String ticker; // 상위 위젯으로부터 호출시 변수값 전달 받기 위함

  final String apiUrl = 'https://api.finance.naver.com/siseJson.naver?symbol=005930&requestType=1&startTime=20230801&endTime=20230812&timeframe=day';
  
  // URL 크로링 데이터 가져오기
  Future<List<dynamic>> fetchData() async {
      final response = await http.get(
          Uri.parse(apiUrl),
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
          },
      );

      if (response.statusCode == 200) {
          List<dynamic> jsonData = [];
          // 크로링 데이터 전처리 후 JSON 변환
          try {
              String responseBody = response.body;
              responseBody = responseBody.replaceAll(' ', '');
              responseBody = responseBody.replaceAll("['날짜','시가','고가','저가','종가','거래량','외국인소진율'],", "");
            
              jsonData = json.decode(responseBody);
          } catch (e) {
              print('Response Body: ${response.body}');
              print('JSON Parsing Error: $e');
          }
          return jsonData;
      } else {
          throw Exception('Failed to load data');
      }
  }

  @override
  void initState() {
    super.initState();
    ticker = widget.ticker; // 상위 위젯으로부터 호출시 변수값 전달 받기 위함

  }

  @override
  Widget build(BuildContext context) {
    // final blue = charts.MaterialPalette.blue.shadeDefault;

    return Container(
      height: 180,
      padding: EdgeInsets.only(top: 10.0),
      child: Card(
        color: Color.fromARGB(255, 0, 0, 0),
        // child: Padding(
        // padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          children: <Widget>[
            Expanded(

              child: FutureBuilder<List<dynamic>>(
                      future: fetchData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                        } else {
                            // JSON data is available
                            final jsonData = snapshot.data;
                            // Process and display jsonData as needed
                            return Text('$jsonData',
                                    style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFFEDEDED),
                                          //fontWeight: FontWeight.bold,
                                    )
                            );
                        }
                      },
                    ),

              ),
            
          ],
        ),
        // ),
      ),
    );
  }
}
