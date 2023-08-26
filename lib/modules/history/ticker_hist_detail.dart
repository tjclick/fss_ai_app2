import 'package:flutter/material.dart';
import 'package:fss_ai_app2/modules/analysis/chart_daily_amount.dart';
import 'package:fss_ai_app2/modules/analysis/chart_daily_ohlc.dart';
import 'package:fss_ai_app2/modules/analysis/chart_daily_rating.dart';
import 'package:fss_ai_app2/modules/analysis/point_list.dart';
import 'package:get/get.dart';

class HistoryDetailView extends StatefulWidget {
  const HistoryDetailView({super.key});

  @override
  _HistoryDetailViewState createState() => _HistoryDetailViewState();
}

class _HistoryDetailViewState extends State<HistoryDetailView> {
  late String ticker; // 상위 위젯으로부터 호출시 변수값 전달 받기 위함
  late String t_name;

  Future initPredictedTickerList() async {
    setState(() {
      ticker = Get.arguments["ticker"];
      t_name = Get.arguments["t_name"];
      //_fetchData();
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      ticker = Get.arguments["ticker"];
      t_name = Get.arguments["t_name"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          t_name + ' ' + ticker,
          style: TextStyle(
            color: Color(0xFFEDEDED),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            color: Color(0xFFEDEDED),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        backgroundColor: Color(0xFF292929),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
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
                                      arguments: {"ticker": ticker, "t_name": t_name, });
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
                                          ticker: ticker),
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
                                  '데이터 >',
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
                                          ticker: ticker),
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
                                      child: AnalysisItemChart(ticker: ticker),
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
                                  '매수/매도 >',
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
                                          ticker: ticker),
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
      
    );
  }
}