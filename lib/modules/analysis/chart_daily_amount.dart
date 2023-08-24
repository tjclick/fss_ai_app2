import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/analysis_model.dart';
import '../../providers/analysis_provider.dart';

class AnalysisAmountChart extends StatefulWidget {
  final String ticker; // 상위 위젯 호출시 변수값 전달 받기 위함
  AnalysisAmountChart({required this.ticker}); // 상위 위젯 호출시 변수값 전달 받기 위함

  @override
  _AnalysisAmountChartState createState() => _AnalysisAmountChartState();
}

class _AnalysisAmountChartState extends State<AnalysisAmountChart> {
  late String ticker; // 상위 위젯으로부터 호출시 변수값 전달 받기 위함
  bool isLoading = true;
  List<TickerDailyAmountList> pTDAmountData = [];
  List<TickerDailyAmountList> _data = [];

  AnalysisProviders analysisProviders = AnalysisProviders();


  Future<List<dynamic>> fetchData() async {
    setState(() {
      ticker = widget.ticker; // 상위 위젯으로부터 호출시 변수값 전달 받기 위함
    });
    pTDAmountData = await analysisProviders.getTickerDailyAmountList(ticker);
    _data = pTDAmountData;

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
    // final blue = charts.MaterialPalette.blue.shadeDefault;
    // final red = charts.MaterialPalette.red.shadeDefault;
    // final customTickFormatter = new charts.BasicNumericTickFormatterSpec((value) => '$value'+'K');
    final customTickFormatter = new charts.BasicNumericTickFormatterSpec.fromNumberFormat(
          new NumberFormat.compact(locale: 'ko') // K, 만 단위 표시
    );

    List<charts.Series<TickerDailyAmountList, String>> series(){
      return [
          //Line #1
          new charts.Series(
            id: "기관",
            data: _data,
            domainFn: (TickerDailyAmountList series, _) => series.tda_datetime, // X축
            measureFn: (TickerDailyAmountList series, _) => series.tda_gov, // Y축
            strokeWidthPxFn: (_, __) => 1, // 라인 굵기 (PredictedTickerData series, _) => series.yprice
            colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
            // colorFn: (TickerDailySiseData series, _) =>
            //     series.tds_rate <= 0 ? blue : red,
          )..setAttribute(charts.rendererIdKey, 'customLine'),
          new charts.Series(
            id: "개인",
            data: _data,
            domainFn: (TickerDailyAmountList series, _) => series.tda_datetime, // X축
            measureFn: (TickerDailyAmountList series, _) => series.tda_person, // Y축
            strokeWidthPxFn: (_, __) => 1, // 라인 굵기 (PredictedTickerData series, _) => series.yprice
            colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
            // colorFn: (TickerDailySiseData series, _) =>
            //     series.tds_rate <= 0 ? blue : red,
          )..setAttribute(charts.rendererIdKey, 'customLine'),
          new charts.Series(
            id: "외국인",
            data: _data,
            domainFn: (TickerDailyAmountList series, _) => series.tda_datetime, // X축
            measureFn: (TickerDailyAmountList series, _) => series.tda_foreign, // Y축
            strokeWidthPxFn: (_, __) => 1, // 라인 굵기 (PredictedTickerData series, _) => series.yprice
            colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
            // colorFn: (TickerDailySiseData series, _) =>
            //     series.tds_rate <= 0 ? blue : red,
          )..setAttribute(charts.rendererIdKey, 'customLine'),

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
                  return new charts.OrdinalComboChart(
                    series(),
                    animate: true,
                    // X축 가이드라인, MAX/MIN 값 지정
                    //domainAxis: new charts.OrdinalAxisSpec(),

                    // 라인 그래프 String X축 설정
                    customSeriesRenderers: [new charts.LineRendererConfig(customRendererId: 'customLine')
                    ],
                    //Y축 가이드라인, MAX/MIN 값 지정
                    primaryMeasureAxis: new charts.NumericAxisSpec(
                      renderSpec: charts.GridlineRendererSpec(
                        lineStyle: charts.LineStyleSpec(
                          dashPattern: [1, 1],
                          color: charts.MaterialPalette.gray.shade800,
                        ),
                      ),
                      tickFormatterSpec: customTickFormatter,
                      // Y축 가이드 라인 수, 간격
                      tickProviderSpec: new charts.BasicNumericTickProviderSpec(
                          desiredTickCount: 5, zeroBound: false),
                    ),
                    // 라인별 범주 표시 (Line ID별, Color, Text)
                    behaviors: [new charts.SeriesLegend(
                      //position: charts.BehaviorPosition.start,
                      //desiredMaxRows: 2,
                      cellPadding: new EdgeInsets.only(right: 20.0, bottom: 0.0),
                      entryTextStyle: charts.TextStyleSpec(
                          color: charts.Color(r: 255, g: 255, b: 255),
                          fontSize: 11),
                    ),],
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