import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/home_model.dart';
import '../modules/analysis/chart_daily_rating.dart';
import '../modules/analysis/point_uri_crawl_sise_.dart';
// import '../modules/analysis/news_crawl.dart';
import '../providers/home_provider.dart';

class AnalysisScreen extends StatefulWidget {
  @override
  _AnalysisScreenState createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  int _selectedIndex = 1;
  List<PredictedTickerList> pTickerList = [];
  bool isLoading = true;
  HomeProviders homeProvider = HomeProviders();


  void _onItemTapped(int index) {
    if (index == 0) Get.toNamed("/home");
    if (index == 1) Get.toNamed("/analysis");
    if (index == 2) Get.toNamed("/perform");
    if (index == 3) Get.toNamed("/users");
  }


  Future initPredictedTickerList() async {
    pTickerList = await homeProvider.getPredictedTickerList();
  }

  @override
  void initState() {
    super.initState();
    initPredictedTickerList().then((_) {
      setState(() {
        isLoading = false;
      });
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '분석 결과',
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

      body: CustomScrollView(
          // AI가 패턴 분석하여 평가 기준데이터 조합(POINT)
          // 일일 시세 차트(3 charts) ,  상단서브탭((company | news) 2 tabs)
          // 일일 시세 차트 1)high/close-라인, 2)rate-막대, 3)volume 전체(라인), 4)개인/기관/외국인(막대)
          // 기업개요 (app 자체 크랩핑)
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                // Here, you can return a widget for each item based on the index.
                return Container(
                  padding: EdgeInsets.fromLTRB(15, 20, 0, 0),
                  child: Column(
                    children: [
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(pTickerList[index].name,
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFFEDEDED),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 20),
                          Text(pTickerList[index].ticker,
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF797979),
                              //fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('AI indexing',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFFEDEDED),
                              //fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 130),
                          TextButton(
                            onPressed: () {
                              print('TextButton Clicked');
                            },
                            child: Text('Company', style: TextStyle(fontSize: 16, color: Color(0xFF797979)),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              print('TextButton Clicked');
                            },
                            child: Text('News', style: TextStyle(fontSize: 16, color: Color(0xFF797979)),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        //row children right
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                            height: 470,
                            width: MediaQuery.of(context).size.width * 0.92,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 0, 0, 0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              //column children left 위치 정렬
                              //padding left 15
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // 인덱싱 포인트 레이어 구성 (기업회사 | 뉴스)
                                SizedBox(
                                  height: 200,
                                  width: MediaQuery.of(context).size.width * 0.99,
                                  //chart(home_chart) widget 호출 ticker변수 전달
                                  child: AnalysisCrawlJson(ticker: pTickerList[index].ticker),
                                ),
                                SizedBox(height: 10),

                                // 서브 버튼 레이어 구성=============================
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          print('TextButton Clicked');
                                        },
                                        child: Text('시세', style: TextStyle(fontSize: 16, color: Color(0xFF797979)),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          print('TextButton Clicked');
                                        },
                                        child: Text('등락율', style: TextStyle(fontSize: 16, color: Color(0xFF797979)),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          print('TextButton Clicked');
                                        },
                                        child: Text('거래량', style: TextStyle(fontSize: 16, color: Color(0xFF797979)),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          print('TextButton Clicked');
                                        },
                                        child: Text('거래상세', style: TextStyle(fontSize: 16, color: Color(0xFF797979)),
                                        ),
                                      ),
                                    ],
                                  ),

                                // 서브 챠트 레이어 구성 (시세|등락률|거래량|거래상세)
                                SizedBox(
                                  height: 180,
                                  width: MediaQuery.of(context).size.width * 0.99,
                                  //chart(home_chart) widget 호출 ticker변수 전달
                                  child: AnalysisItemChart(ticker: pTickerList[index].ticker),
                                ),
                                // 뉴스 크롤링
                                // SizedBox(
                                //   height: 100,
                                //   width: MediaQuery.of(context).size.width * 0.99,
                                //   child: AnalysisNewsCrawl(ticker: pTickerList[index].ticker, t_name: pTickerList[index].name,),
                                // ),

                              ],
                            ),
                            
                          ),// Replace with the actual number of items
                        ]
                      ),
                      
                    ],
                  ),
                );
              },
              childCount: pTickerList.length,
            ),
          ),
        ],
      ),
      
      
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
            backgroundColor: Color(0xFF292929),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: '분석',
            backgroundColor: Color(0xFF292929),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: '실적',
            backgroundColor: Color(0xFF292929),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: '회원',
            backgroundColor: Color(0xFF292929),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFFededed),
        unselectedItemColor: Color.fromARGB(255, 94, 94, 94),
        onTap: _onItemTapped,
      ),
    );
  }
}

