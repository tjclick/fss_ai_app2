import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:fss_ai_app2/models/analysis_model.dart';
import 'package:fss_ai_app2/providers/analysis_provider.dart';

class AnalysisOhlcChart extends StatefulWidget {
  final String ticker; // 상위 위젯 호출시 변수값 전달 받기 위함
  AnalysisOhlcChart({required this.ticker}); // 상위 위젯 호출시 변수값 전달 받기 위함

  @override
  _AnalysisOhlcChartState createState() => _AnalysisOhlcChartState();
}

class _AnalysisOhlcChartState extends State<AnalysisOhlcChart> {
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
      print('chart: $ticker');
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final blue = charts.MaterialPalette.blue.shadeDefault;
    // final red = charts.MaterialPalette.red.shadeDefault;

    List<charts.Series<TickerDailySiseData, String>> series(){
      return [
          //Line #1
          new charts.Series(
            id: "고가",
            data: _data,
            domainFn: (TickerDailySiseData series, _) => series.tds_datetime, // X축
            measureFn: (TickerDailySiseData series, _) => series.tds_high, // Y축
            strokeWidthPxFn: (_, __) => 1, // 라인 굵기 (PredictedTickerData series, _) => series.yprice
            colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
            // colorFn: (TickerDailySiseData series, _) =>
            //     series.tds_rate <= 0 ? blue : red,
          )..setAttribute(charts.rendererIdKey, 'customLine'),
          new charts.Series(
            id: "종가",
            data: _data,
            domainFn: (TickerDailySiseData series, _) => series.tds_datetime, // X축
            measureFn: (TickerDailySiseData series, _) => series.tds_close, // Y축
            strokeWidthPxFn: (_, __) => 1, // 라인 굵기 (PredictedTickerData series, _) => series.yprice
            colorFn: (_, __) => charts.MaterialPalette.white,
            // colorFn: (TickerDailySiseData series, _) =>
            //     series.tds_rate <= 0 ? blue : red,
          )..setAttribute(charts.rendererIdKey, 'customLine'),
          new charts.Series(
            id: "저가",
            data: _data,
            domainFn: (TickerDailySiseData series, _) => series.tds_datetime, // X축
            measureFn: (TickerDailySiseData series, _) => series.tds_low, // Y축
            strokeWidthPxFn: (_, __) => 1, // 라인 굵기 (PredictedTickerData series, _) => series.yprice
            colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
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
                      // Y축 가이드 라인 수, 간격
                      tickProviderSpec: new charts.BasicNumericTickProviderSpec(
                          desiredTickCount: 5, zeroBound: false),
                    ),
                    // 라인별 범주 표시 (Line ID별, Color, Text)
                    behaviors: [new charts.SeriesLegend(
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