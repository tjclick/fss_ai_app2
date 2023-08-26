import 'package:flutter/material.dart';
import 'package:fss_ai_app2/models/history_model.dart';
import 'package:fss_ai_app2/providers/history_provider.dart';
import 'package:fss_ai_app2/screens/BottomNavigationBar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String listTitleDate = '';
  List<HistoryDailyRateList> pTDHistoryList = [];
  List<HistoryDailyRateList> jsonData = [];
  bool isLoading = true;
  HistoryProviders historyProvider = HistoryProviders();

  int _currentIndex = 2;
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (index == 0) Get.toNamed("/home");
    if (index == 1) Get.toNamed("/analysis");
    //if (index == 2) Get.toNamed("/history");
    if (index == 3) Get.toNamed("/users");
  }

  Future initHistoryDailyRateList() async {
    pTDHistoryList = await historyProvider.getHistoryDailyRateList();
    jsonData = pTDHistoryList;

    await Future.delayed(Duration(seconds: 1));
  }

  @override
  void initState() {
    super.initState();
    initHistoryDailyRateList().then((_) {
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
          'History',
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
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                // Here, you can return a widget for each item based on the index.
                return Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                  child: Column(
                    children: [
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            pTDHistoryList[index].play_date.substring(4, 6) + '/' + pTDHistoryList[index].play_date.substring(6, 8),
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFFEDEDED),
                              //fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      //SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                  pTDHistoryList[index].t_name,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFFEDEDED),
                                    //fontWeight: FontWeight.bold,
                                  ),
                                ),
                              SizedBox(width: 10),
                              Text(
                                  pTDHistoryList[index].ticker,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF797979),
                                    //fontWeight: FontWeight.bold,
                                  ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 180, 
                            height: 20,
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                  icon: Icon(Icons.arrow_forward_ios, size: 17),
                                  color: Color(0xFFEDEDED),
                                  onPressed: () {
                                      Get.toNamed("/historyDetail",
                                      arguments: {"ticker": pTDHistoryList[index].ticker, "t_name": pTDHistoryList[index].t_name, });
                                  },
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                          //row children right
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                              Container(
                                  padding: EdgeInsets.fromLTRB(15, 0, 5, 0),
                                  height: 120,
                                  width: MediaQuery.of(context).size.width *0.90,
                                  // decoration: BoxDecoration(
                                  //   //color: Color.fromARGB(255, 0, 0, 0),
                                  //   borderRadius: BorderRadius.circular(5),
                                  //   border: Border.all(
                                  //     color: Color.fromARGB(255, 85, 85, 85),
                                  //     width: 1,
                                  //   ),
                                  // ),
                                  child: _makeSubResultData(jsonData, index),
                              ),  

                          ]
                      ),
                      Divider(
                        color: Color.fromARGB(255, 68, 68, 68),
                        height: 1,
                        thickness: 1,
                        indent: 0,
                        endIndent: 20,
                      ),
                    ],
                  ),
                );
              },
              childCount: pTDHistoryList.length,
            ),
          ),
        ],
      ),
      
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }

  // ticker별 구매/판매 영역 데이터 위젯 구성
  Widget _makeSubResultData(List<HistoryDailyRateList> jsonData, int index) {
    // 금액 천단위(,) 포맷 표시
    final compactFormat = NumberFormat.simpleCurrency(locale: 'ko_KR', name: '', decimalDigits: 0);

  // D+2 날짜 계산
  DateTime strToDateTime(String rDate) {
      DateTime p_day = DateTime.parse(rDate);
      DateTime calculatedDate = p_day.add(Duration(days: 2));
        // 만약 계산된 날짜가 토요일(6) 또는 일요일(7)이라면 월요일(1)로 변경
        if (calculatedDate.weekday == 6) {
          calculatedDate = calculatedDate.add(Duration(days: 2));
        } else if (calculatedDate.weekday == 7) {
          calculatedDate = calculatedDate.add(Duration(days: 1));
        }
      return calculatedDate;
  }

    // 서버로 부터 받은 데이터 변수에 할당
    var play_date = jsonData[index].play_date;
        play_date = play_date.substring(4, 6) +'/' +play_date.substring(6, 8);
    var yest_close = jsonData[index].yest_close;
    var r_low_date = jsonData[index].r_low_date;
        r_low_date = r_low_date == '' ? play_date : r_low_date.substring(4, 6) +'/' +r_low_date.substring(6, 8);
    var day1_buy_price = jsonData[index].day1_buy_price;
    var g_buy_rate = jsonData[index].g_buy_rate;
    var r_low_price = jsonData[index].r_low_price;
    var r_low_rate = (r_low_price - yest_close) / yest_close * 100;
    double r_low_rate2 = double.parse(r_low_rate.toStringAsFixed(1));
    //-- 하단 판매 데이터
    var r_high_date = jsonData[index].r_high_date;
    var d2_date = strToDateTime(jsonData[index].play_date).toString();
        d2_date = d2_date.substring(5, 7) +'/' + d2_date.substring(8, 10);
        r_high_date = r_high_date == '' ? d2_date : r_high_date.substring(4, 6) +'/' +r_high_date.substring(6, 8);
    var day2_sale_price = jsonData[index].day2_sale_price;
    var g_sale_rate = jsonData[index].g_sale_rate;
    var r_high_price = jsonData[index].r_high_price;
    var r_high_rate = (r_high_price - yest_close) / yest_close * 100;
    double r_high_rate2 = double.parse(r_high_rate.toStringAsFixed(1));

    
    // 종목별 구매/판매 영역 데이터 위젯 구성
    return Column(
      children: [
        //SizedBox(height: 5),
        // 구매 타이틀 
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
              SizedBox(
              width: 45, // 원하는 너비
              child: Container(
                height: 20,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xFF4488EE),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(
                    r_low_date,
                    style: TextStyle(color: Color(0xFFededed), fontSize: 14,),
                    ),
                ),
              ),
              SizedBox(
                width: 70, // 원하는 너비
                child: Container(
                  height: 20,
                  alignment: Alignment.centerLeft,
                  child: Text(
                      '사면 좋아요',
                      style: TextStyle(color: Color(0xFF797979), fontSize: 12,),
                      ),
                  ),
              ),
              SizedBox(
              width: 70, // 원하는 너비
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                    '적중률',
                    style: TextStyle(color: Color(0xFF797979), fontSize: 12),
                    ),
                ),
              ),
              SizedBox(
              width: 120, // 원하는 너비
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                    r_low_date.toString() == '/' ? '' : r_low_date.toString()+' 실저가',
                    style: TextStyle(color: Color(0xFF797979), fontSize: 12),
                    ),
                ),
              ),
              
          ],
        ),

        // 구매 데이터 레이어 구성 
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
              SizedBox(width: 40),
              SizedBox(
              width: 75, // 원하는 너비
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                    compactFormat.format(day1_buy_price),
                    style: TextStyle(color: Color(0xFF4488EE), fontSize: 18),
                    ),
                ),
              ),
              SizedBox(
              width: 70, // 원하는 너비
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                    g_buy_rate.toString() == '0.0' ? '' : g_buy_rate.toString()+'%',
                    style: TextStyle(color: Color(0xFFEDEDED), fontSize: 20),
                    ),
                ),
              ),
              SizedBox(
              width: 60, // 원하는 너비
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                    r_low_price.toString() == '0' ? '...' : compactFormat.format(r_low_price),
                    style: TextStyle(color: Color(0xFFEDEDED), fontSize: 16),
                    ),
                ),
              ),

              SizedBox(
              width: 50, // 원하는 너비
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                    r_low_rate2.toString() == '-100.0' ? '' : r_low_rate2.toString()+'%',
                    style: TextStyle(
                      color: r_low_rate2.toString().contains('-') ? Color(0xFF4488EE) : Color(0xFFEE4444), 
                    fontSize: 16),
                    ),
                ),
              ),
              
          ],
        ),

        // 판매 타이틀 구성
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
              SizedBox(
              width: 45, // 원하는 너비
              child: Container(
                height: 20,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xFFFF4444),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(
                    r_high_date,
                    style: TextStyle(color: Color(0xFFededed), fontSize: 14,),
                    ),
                ),
              ),
              SizedBox(
              width: 70, // 원하는 너비
              child: Container(
                height: 20,
                alignment: Alignment.centerLeft,
                child: Text(
                    '팔면 좋아요',
                    style: TextStyle(color: Color(0xFF797979), fontSize: 12,),
                    ),
                ),
              ),
              SizedBox(
              width: 70, // 원하는 너비
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                    '적중률',
                    style: TextStyle(color: Color(0xFF797979), fontSize: 12),
                    ),
                ),
              ),
              SizedBox(
              width: 120, // 원하는 너비
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                    r_high_date.toString() == '/' ? '' : r_high_date.toString()+' 실고가',
                    style: TextStyle(color: Color(0xFF797979), fontSize: 12),
                    ),
                ),
              ),
          ],
        ),

        // 판매 데이터 레이어 구성 
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
              SizedBox(width: 40),
              SizedBox(
              width: 75, // 원하는 너비
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                    compactFormat.format(day2_sale_price),
                    style: TextStyle(color: Color(0xFFEE4444), fontSize: 18),
                    ),
                ),
              ),
              SizedBox(
              width: 70, // 원하는 너비
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                    g_sale_rate.toString() == '0.0' ? '' : g_sale_rate.toString()+'%',
                    style: TextStyle(color: Color(0xFFEDEDED), fontSize: 20),
                    ),
                ),
              ),
              SizedBox(
              width: 60, // 원하는 너비
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                    r_high_price.toString() == '0' ? '...' : compactFormat.format(r_high_price),
                    style: TextStyle(color: Color(0xFFEDEDED), fontSize: 16),
                    ),
                ),
              ),

              SizedBox(
              width: 50, // 원하는 너비
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                    r_high_rate2.toString() == '-100.0' ? '' : r_high_rate2.toString()+'%',
                    style: TextStyle(
                      color: r_high_rate2.toString().contains('-') ? Color(0xFF4488EE) : Color(0xFFEE4444), 
                      fontSize: 16),
                    ),
                ),
              ),
              
          ],
        ),



      ],
    );
  }
}