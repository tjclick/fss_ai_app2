// import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:fss_ai_app2/models/analysis_model.dart';
import 'package:fss_ai_app2/providers/analysis_provider.dart';

class AnalysisPointList extends StatefulWidget {
  final String ticker; // 상위 위젯 호출시 변수값 전달 받기 위함
  AnalysisPointList({required this.ticker}); // 상위 위젯 호출시 변수값 전달 받기 위함

  @override
  _AnalysisPointListState createState() => _AnalysisPointListState();
}

class _AnalysisPointListState extends State<AnalysisPointList> {
  late String ticker; // 상위 위젯으로부터 호출시 변수값 전달 받기 위함
  bool isLoading = true;
  List<TickerPointListData> pTDPointList = [];

  AnalysisProviders analysisProvider = AnalysisProviders();

  Future<List<dynamic>> fetchData() async {
    setState(() {
      ticker = widget.ticker; // 상위 위젯으로부터 호출시 변수값 전달 받기 위함
    });
    List<dynamic> jsonData = [];
    pTDPointList = await analysisProvider.getTickerPointListData(ticker);

    jsonData = pTDPointList;
    jsonData.insert(
        0,
        TickerPointListData(
          play_date: '100',
          company: 100,
          volume: 100,
          economic: 100,
          news: 100,
          day_rate: 100,
          day1_low: 100,
          day2_high: 100,
        ));
    return jsonData;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      ticker = widget.ticker; // 상위 위젯으로부터 호출시 변수값 전달 받기 위함
      print('point: $ticker');
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final blue = charts.MaterialPalette.blue.shadeDefault;
    return Container(
      height: 150,
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

                    //listview 상단에 title 삽입하기
                    return ListView.builder(
                      itemCount: jsonData?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _makeListViewData(jsonData!, index);
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

  // ListView에 들어갈 데이터를 만든다
  Widget _makeListViewData(List<dynamic> jsonData, int index) {
    Color backgroundColor = index % 2 == 0
        ? Color.fromARGB(255, 17, 17, 17)
        : Color.fromARGB(255, 48, 48, 48);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              color: backgroundColor,
              width: 45,
              height: 30,
              alignment: Alignment.center,
              // Text 정렬 right로 설정
              child: Text(
                  jsonData[index].play_date == '100'
                      ? 'Date'
                      : (jsonData[index].play_date.substring(4, 6) +
                          '/' +
                          jsonData[index].play_date.substring(6, 8)),
                  style: const TextStyle(
                      fontSize: 14.0, color: Color(0xFFededed))),
            ),
            Container(
              color: backgroundColor,
              width: 35,
              height: 30,
              alignment: Alignment.centerRight,
              // Text 정렬 right로 설정
              child: Text(
                  jsonData[index].company == 100
                      ? '기업'
                      : jsonData[index].company.toString(),
                  style: const TextStyle(
                      fontSize: 14.0, color: Color(0xFFededed))),
            ),
            Container(
              color: backgroundColor,
              width: 35,
              height: 30,
              alignment: Alignment.centerRight,
              // Text 정렬 right로 설정
              child: Text(
                  jsonData[index].volume == 100
                      ? '거래'
                      : jsonData[index].volume.toString(),
                  style: const TextStyle(
                      fontSize: 14.0, color: Color(0xFFededed))),
            ),
            Container(
              color: backgroundColor,
              width: 45,
              height: 30,
              alignment: Alignment.centerRight,
              // Text 정렬 right로 설정
              child: Text(
                  jsonData[index].economic == 100
                      ? '시황'
                      : jsonData[index].economic.toString(),
                  style: const TextStyle(
                      fontSize: 14.0, color: Color(0xFFededed))),
            ),
            Container(
              color: backgroundColor,
              width: 35,
              height: 30,
              alignment: Alignment.centerRight,
              child: Text(
                  jsonData[index].news == 100
                      ? '뉴스'
                      : jsonData[index].news.toString(),
                  style: const TextStyle(
                      fontSize: 14.0, color: Color(0xFFededed))),
              // container에 넣고 radius(3)로 둥글게 처리하고 color(빨강, 파랑)로 색상 처리
            ),
            Container(
              color: backgroundColor,
              width: 45,
              height: 30,
              alignment: Alignment.centerRight,
              child: Text(
                  jsonData[index].day_rate == 100
                      ? '저가'
                      : jsonData[index].day_rate.toString(),
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Color.fromARGB(255, 69, 152, 247))),
            ),
            Container(
              color: backgroundColor,
              width: 50,
              height: 30,
              alignment: Alignment.centerRight,
              child: Text(
                  jsonData[index].day1_low == 100
                      ? 'D+1저'
                      : jsonData[index].day1_low.toString(),
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Color.fromARGB(255, 69, 152, 247))),
            ),
            Container(
              color: backgroundColor,
              width: 50,
              height: 30,
              alignment: Alignment.centerRight,
              child: Text(
                  jsonData[index].day2_high == 100
                      ? 'D+2고'
                      : jsonData[index].day2_high.toString(),
                  style: TextStyle(
                      fontSize: 14.0,
                      color: jsonData[index].day2_high.toString().contains('-')
                          ? Color.fromARGB(255, 69, 152, 247)
                          : Color.fromARGB(255, 245, 76, 76))),
            ),
          ],
        ),
      ],
    );
  }
}