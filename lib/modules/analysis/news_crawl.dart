import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AnalysisNewsCrawl extends StatefulWidget  {
  final String ticker;                        // 상위 위젯 호출시 변수값 전달 받기 위함
  final String t_name;

  AnalysisNewsCrawl({                         // 상위 호출 인자 생성
    required this.ticker, 
    required this.t_name,
  });  

  @override
  _AnalysisNewsCrawlState createState() => _AnalysisNewsCrawlState();
}

class _AnalysisNewsCrawlState extends State<AnalysisNewsCrawl> {
  late String ticker; // 상위 위젯으로부터 호출시 변수값 전달 받기 위함
  late String t_name;
  static const baseUrl = 'https://openapi.naver.com/v1/search/news.json?display=10&start=1&sort=date';

  // 오늘 날짜와 2주 전 날짜를 구하기 위한 변수
  // DateTime now = DateTime.now();
  // DateTime twoWeeksAgo = DateTime.now().subtract(Duration(days: 16));
  // String today = DateTime.now().toString().substring(0, 10).replaceAll('-', '');
  // String twoWeeksAgoDay = DateTime.now().subtract(Duration(days: 16)).toString().substring(0, 10).replaceAll('-', '');

  // URL 크로링 데이터 가져오기
  Future<List<dynamic>> fetchData() async {
      final response = await http.get(
          Uri.parse('$baseUrl&query=$ticker $t_name'),
          headers: {
            'X-Naver-Client-Id': 'qP_NjLKn94lp1SmkG6LS',
            'X-Naver-Client-Secret': 'iWuN6JZwRI',
            'Content-Type': 'application/json; charset=utf-8',
          },
      );

      if (response.statusCode == 200) {
          List<dynamic> jsonData = [];
          List<dynamic> items = [];


          // 크로링 데이터 전처리 후 JSON 변환
          try {
              final jsonData = json.decode(response.body);
              final items = jsonData['items'];
              
              for (Map<String, dynamic> item in items) {
                print(item['title']);
                String description = item['description'].replaceAll('<b>', '');
                      description = item['description'].replaceAll('</b>', '');
                      description = item['description'].replaceAll('&apos;', '');
                      description = item['description'].replaceAll('&lt;', '');
                print(description);
                print(item['link']);
                print(item['pubDate']);
                print(item['originallink']);
              }

          } catch (e) {
              print('Response Body: ${response.body}');
              print('JSON Parsing Error: $e');
          }
          return jsonData;
      } else {
          throw Exception('Failed to load data');
      }
  }

  // 크로링 데이터 전처리 1행 컬럼 ROW 분리(1row = [,])
  // List<dynamic> _parseJsonRow(String rowString) {
  //   return List<dynamic>.from(rowString.split(", "));
  // }

  @override
  void initState() {
    super.initState();
    ticker = widget.ticker; // 상위 위젯으로부터 호출시 변수값 전달 받기 위함
    t_name = widget.t_name;
  }

  @override
  Widget build(BuildContext context) {
    // String _calcRate(String price1, String price2) {
    //     //두개의 string을 int로 변환하여 차이 증감% 계산 후 다시 string으로 변환
    //     return (((int.parse(price1) - int.parse(price2)) / int.parse(price2)) * 100).toStringAsFixed(1).toString();
    // }

    // final blue = charts.MaterialPalette.blue.shadeDefault;
    return Container(
      height: 100,
      //padding: EdgeInsets.only(top: 10.0),
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

                            return ListView.builder(
                                itemCount: jsonData?.length,
                                itemBuilder: (BuildContext context, int index) {

                                  // 1행 데이터 분리(,)
                                  //List<dynamic> rowData = _parseJsonRow(jsonData![index].toString());
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //   children: <Widget>[
                                  //     Row(
                                  //       children: <Widget>[
                                  //         Text(rowData[0].toString().substring(5, 7)+'/'+rowData[0].toString().substring(7, 9), 
                                  //                 style: const TextStyle(fontSize: 13.0, color: Color(0xFFededed))),
                                  //         SizedBox(width: 12.0, height: 20,),
                                  //         Text(rowData[1].toString(), 
                                  //                 style: const TextStyle(fontSize: 13.0, color: Color(0xFF797979))),
                                  //         SizedBox(width: 12.0,),
                                  //         Text(rowData[2].toString(), 
                                  //                 style: const TextStyle(fontSize: 13.0, color: Color(0xFFededed))),
                                  //         SizedBox(width: 12.0,),
                                  //         Text(rowData[3].toString(), 
                                  //                 style: const TextStyle(fontSize: 13.0, color: Color(0xFFededed))),
                                  //         SizedBox(width: 12.0,),
                                  //         Text(rowData[4].toString(), 
                                  //                 style: const TextStyle(fontSize: 13.0, color: Color(0xFFededed))),
                                  //         SizedBox(width: 12.0,),
                                  //         // container에 넣고 radius(3)로 둥글게 처리하고 color(빨강, 파랑)로 색상 처리
                                  //         Container(
                                  //           //text align left로 설정
                                  //           alignment: Alignment.centerRight,
                                  //           width: 55.0,
                                  //           height: 18.0,
                                  //           padding: EdgeInsets.fromLTRB(2, 0, 5, 0),
                                  //           decoration: BoxDecoration(
                                  //             borderRadius: BorderRadius.circular(3),
                                  //             color: _calcRate(rowData[4].toString(), rowData[1].toString()).contains('-') ?
                                  //             Color.fromARGB(255, 46, 117, 250) : Color.fromARGB(255, 251, 61, 61),
                                  //           ),
                                  //           child: Text(_calcRate(rowData[4].toString(), rowData[1].toString()) + '%', 
                                  //                   style: TextStyle(fontSize: 14.0, color: Color(0xFFededed))),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ],
                                  );
                                },
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

