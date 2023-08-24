import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/home_model.dart';
import '../modules/analysis/chart_daily_amount.dart';
import '../modules/analysis/chart_daily_ohlc.dart';
import '../modules/analysis/chart_daily_rating.dart';
//import '../modules/analysis/analysis_crawl.dart';
import '../modules/analysis/point_list.dart';
import '../providers/home_provider.dart';

class AnalysisScreen extends StatefulWidget {
  @override
  _AnalysisScreenState createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  int _selectedIndex = 1;
  bool isLoading = true;
  String selectedMenu = ''; // 선택된 ticker
  String selectedName = ''; // 선택된 ticker의 name
  List<PredictedTickerList> pTickerList = [];
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
          'Analysis of Today',
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
              children: pTickerList.map((pTickerList) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: selectedMenu == pTickerList.ticker
                          ? Color.fromARGB(255, 87, 87, 87) // 선택된 메뉴는 파란색으로 표시
                          : Color.fromARGB(255, 46, 46, 46),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedMenu = pTickerList.ticker; // ticker 코드값
                        selectedName = pTickerList.name; // ticker 코드값
                        //print(selectedMenu);
                      });
                    },
                    child: Text(
                      pTickerList.name,
                      style: TextStyle(
                        fontSize: 18,
                        color: selectedMenu == pTickerList.ticker
                            ? Color.fromARGB(
                                255, 230, 230, 230) // 선택된 메뉴는 파란색으로 표시
                            : Color.fromARGB(255, 80, 80, 80),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                if (selectedMenu.isNotEmpty)
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        // SUB layer-01 (title : AI indexing, company name)
                        if (index == 0) {
                          return Container(
                            padding: EdgeInsets.fromLTRB(20, 0, 15, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '분석평가이력',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFFEDEDED),
                                    //fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 110),
                                TextButton(
                                  onPressed: () {
                                    print('TextButton Clicked');
                                  },
                                  child: Text(
                                    'Company',
                                    style: TextStyle(
                                        fontSize: 16, color: Color(0xFF797979)),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                      Get.toNamed("/news",
                                      arguments: {"ticker": selectedMenu, "t_name": selectedName, });
                                  },
                                  child: Text(
                                    'News',
                                    style: TextStyle(
                                        fontSize: 16, color: Color(0xFF797979)),
                                  ),
                                ),
                                // 토글 버튼으로 Y, N 변경시 호출할 API POST처리
                                // AdminConfirmFlagUpdate?flag=N&ticker={ticker}&p_date={e_date}"
                                //

                              ],
                            ),
                          );
                        }
                        // AI분석 포인트 리스트 구성
                        if (index == 1) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                height: 150,
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
                                      height: 150,
                                      width: MediaQuery.of(context).size.width *
                                          0.99,
                                      //chart(home_chart) widget 호출 ticker변수 전달
                                      //child: AnalysisCrawlJson(ticker: selectedMenu),
                                      child: AnalysisPointList(
                                          ticker: selectedMenu),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }

                        // SUB layer-02 (시세)
                        if (index == 2) {
                          return Container(
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '시세',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFFEDEDED),
                                    //fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '주간 +12.5%',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 245, 70, 70),
                                    //fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                              
                            ),
                          );
                        }

                        // 시세 chart 구성
                        if (index == 3) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                height: 200,
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
                                      width: MediaQuery.of(context).size.width *
                                          0.99,
                                      //chart(home_chart) widget 호출 ticker변수 전달
                                      child: AnalysisOhlcChart(
                                          ticker: selectedMenu),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }

                        // SUB layer-02 (등락률)
                        if (index == 4) {
                          return Container(
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '등락률',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFFEDEDED),
                                    //fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '주간 +12.5%',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 245, 70, 70),
                                    //fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        // 등락률 chart 구성
                        if (index == 5) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                height: 200,
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
                                      child: AnalysisItemChart(ticker: selectedMenu),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }

                        // SUB layer-02 (거래량)
                        if (index == 6) {
                          return Container(
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '순매수',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFFEDEDED),
                                    //fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '주간 +12.5%',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 245, 70, 70),
                                    //fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        // 거래량 chart 구성
                        if (index == 7) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                height: 200,
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
                                    SizedBox(
                                      height: 200,
                                      width: MediaQuery.of(context).size.width *
                                          0.99,
                                      //chart(home_chart) widget 호출 ticker변수 전달
                                      child: AnalysisAmountChart(
                                          ticker: selectedMenu),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }  

                      },
                      childCount: 10,
                    ),
                  ),
              ],
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