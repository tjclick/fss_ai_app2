import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});
  // final String ticker;
  // final String t_name;
  
  // NewsScreen({required this.ticker, required this.t_name,});  

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
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

  @override
  void initState() {
    super.initState();
    ticker = Get.arguments["ticker"];
    t_name = Get.arguments["t_name"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'News',
          style: TextStyle(
            color: Color(0xFFEDEDED),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            color: Color(0xFFEDEDED),
            onPressed: () {
              // Handle search action
            },
          ),
        ],
        backgroundColor: Color(0xFF292929),
      ),
      
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              // 기업의 개요를 보여주는 카드
              // children: Container(),
            ),
          ),
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

                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //   children: <Widget>[
                                  //     Row(
                                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

    );

  }

}

