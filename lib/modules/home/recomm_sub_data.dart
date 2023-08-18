import 'package:flutter/material.dart';

import '../../models/home_model.dart';
import '../../providers/home_provider.dart';

class HomeSubLabelData extends StatefulWidget {
  final String ticker; // 상위 위젯 호출시 변수값 전달 받기 위함
  HomeSubLabelData({required this.ticker}); // 상위 위젯 호출시 변수값 전달 받기 위함

  @override
  _HomeSubLabelDataState createState() => _HomeSubLabelDataState();
}

class _HomeSubLabelDataState extends State<HomeSubLabelData> {
  late String ticker; // 상위 위젯으로부터 호출시 변수값 전달 받기 위함

  HomeProviders homeProvider = HomeProviders();
  List<TickerSubLabelData> pTSubLabelData = [];
  List<TickerSubLabelData> _data = [];

  Future<void> loadJsonData() async {
    // provider에게 변수값으로 호출 연동
    pTSubLabelData = await homeProvider.getTickerSubLabelData(ticker);

    setState(() {
      _data = pTSubLabelData;
    });
  }

  @override
  void initState() {
    super.initState();
    ticker = widget.ticker; // 상위 위젯으로부터 호출시 변수값 전달 받기 위함

    loadJsonData();
  }

  @override
  Widget build(BuildContext context) {
    // DB 결과 한개 1 row Json(pTSubLabelData)에 대하여 변수 값 처리
    var yest_high;
    var yest_low;
    var yest_close;
    var day1_high;
    var day1_low;
    var day1_buy_price;
    var day2_high;
    var day2_low;
    var day2_sale_price;
    for (var item in _data) {
        yest_high = item.yest_high;
        yest_low = item.yest_low;
        yest_close = item.yest_close;
        day1_high = item.day1_high;
        day1_low = item.day1_low;
        day1_buy_price = item.day1_buy_price;
        day2_high = item.day2_high;
        day2_low = item.day2_low;
        day2_sale_price = item.day2_sale_price;
    }
 
    return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('H ' + yest_high.toString(),
                          style: TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(255, 240,60,60),
                          ),
                        ),
                        Text('L ' + yest_low.toString(),
                        // Text(pTickerList[index].close.toString(),
                          style: TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(255, 60,150,230),
                          ),
                        ),
                        Text('C ' + yest_close.toString(),
                        // Text(pTickerList[index].close.toString(),
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFFEDEDED),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('H ' + day1_high.toString() + '%',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(255, 240,60,60),
                          ),
                        ),
                        Text('L ' + day1_low.toString() + '%',
                        // Text(pTickerList[index].close.toString(),
                          style: TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(255, 60,150,230),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(3, 1, 3, 1),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 60,150,230),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text('매수 ' + day1_buy_price.toString(),
                          // Text(pTickerList[index].close.toString(),
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFFEDEDED), 
                            )
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('H ' + day2_high.toString() + '%',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(255, 240,60,60),
                          ),
                        ),
                        Text('L ' + day2_low.toString() + '%',
                        // Text(pTickerList[index].close.toString(),
                          style: TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(255, 60,150,230),
                          ),
                        ),
                        
                        Container(
                          padding: EdgeInsets.fromLTRB(3, 1, 3, 1),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 250, 60, 60),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text('매도 ' + day2_sale_price.toString(),
                          // Text(pTickerList[index].close.toString(),
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFFEDEDED), 
                            )
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                ],
              ),
            ],
    );
  }
}