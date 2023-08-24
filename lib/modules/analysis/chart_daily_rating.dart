import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../../models/analysis_model.dart';
import '../../providers/analysis_provider.dart';

class AnalysisItemChart extends StatefulWidget {
  final String ticker; // 상위 위젯 호출시 변수값 전달 받기 위함
  AnalysisItemChart({required this.ticker}); // 상위 위젯 호출시 변수값 전달 받기 위함

  @override
  _AnalysisItemChartState createState() => _AnalysisItemChartState();
}

class _AnalysisItemChartState extends State<AnalysisItemChart> {
  late String ticker; // 상위 위젯으로부터 호출시 변수값 전달 받기 위함
  bool isLoading = true;
  List<TickerDailySiseData> pTDSiseData = [];
  List<TickerDailySiseData> _data = [];

  AnalysisProviders analysisProviders = AnalysisProviders();


  Future<List<dynamic>> fetchData() async {
    setState(() {
      ticker = widget.ticker; // 상위 위젯으로부터 호출시 변수값 전달 받기 위함
    });
    pTDSiseData = await analysisProviders.getTickerDailySiseData(ticker);
    _data = pTDSiseData;

    return _data;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      ticker = widget.ticker; // 상위 위젯으로부터 호출시 변수값 전달 받기 위함
      //print('chart: $ticker');
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final blue = charts.MaterialPalette.blue.shadeDefault;
    final red = charts.MaterialPalette.red.shadeDefault;

    List<charts.Series<TickerDailySiseData, String>> series(){
      return [
          //Line #1
          new charts.Series(
          id: "ratingBar",
          data: _data,
          domainFn: (TickerDailySiseData series, _) => series.tds_datetime, // X축
          measureFn: (TickerDailySiseData series, _) => series.tds_rate, // Y축
          strokeWidthPxFn: (_, __) =>
              1, // 라인 굵기 (PredictedTickerData series, _) => series.yprice
          // 데이터 값에 상관없이 메세드 전체 적용시 ***
          //colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
          colorFn: (TickerDailySiseData series, _) =>
              series.tds_rate <= 0 ? blue : red,
          labelAccessorFn: (TickerDailySiseData series, _) =>
              '${series.tds_rate.toString()}', // 막대그래프 값 표시
        ),
      ];
    }

    return Container(
      height: 200,
      //padding: EdgeInsets.only(top: 10.0),
      child: Card(
        color: Color.fromARGB(255, 0, 0, 0),
        // child: Padding(
        // padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          children: <Widget>[
            Expanded(
                // FutureBuilder 사용시 Expanded 사용 필수, 이밴트 발생시 reload 위함
                child: FutureBuilder<List<dynamic>>(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return new charts.BarChart(
                    series(),
                    animate: true,
                    // X축 가이드라인, MAX/MIN 값 지정
                    barRendererDecorator: new charts.BarLabelDecorator(
                      insideLabelStyleSpec: new charts.TextStyleSpec(
                          color: charts.MaterialPalette.white, fontSize: 10),
                      outsideLabelStyleSpec: new charts.TextStyleSpec(
                          color: charts.MaterialPalette.white, fontSize: 10),
                    ),
                    domainAxis: new charts.OrdinalAxisSpec(),

                    //Y축 가이드라인, MAX/MIN 값 지정
                    primaryMeasureAxis: new charts.NumericAxisSpec(
                      renderSpec: charts.GridlineRendererSpec(
                        lineStyle: charts.LineStyleSpec(
                          dashPattern: [1, 1],
                          color: charts.MaterialPalette.gray.shade800,
                        ),
                      ),
                      // Y축 가이드 라인 수, 간격
                      tickProviderSpec: new charts.BasicNumericTickProviderSpec(
                          desiredTickCount: 5),
                    ),
                  );
                }
              },
            )),
          ],
        ),
        // ),
      ),
    );
  }
}