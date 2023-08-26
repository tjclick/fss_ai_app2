import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:fss_ai_app2/models/home_model.dart';
import 'package:fss_ai_app2/providers/home_provider.dart';

class HomeItemChart extends StatefulWidget  {
  final String ticker;                    // 상위 위젯 호출시 변수값 전달 받기 위함
  HomeItemChart({required this.ticker});  // 상위 위젯 호출시 변수값 전달 받기 위함

  @override
  _HomeItemChartState createState() => _HomeItemChartState();
}

class _HomeItemChartState extends State<HomeItemChart> {
  late String ticker; // 상위 위젯으로부터 호출시 변수값 전달 받기 위함
  int _idxDivid = 350;

  HomeProviders homeProvider = HomeProviders();
  List<PredictedTickerData> pTickerData = [];
  List<PredictedTickerData> _data = [];

  Future<void> loadJsonData() async {
    // provider에게 변수값으로 호출 연동
    pTickerData = await homeProvider.getPredictedTickerData(ticker);

    setState(() {
      _data = pTickerData;
      _idxDivid = (pTickerData.length / 3).toInt();  // 3일치 데이터로 나누기
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
    final blue = charts.MaterialPalette.blue.shadeDefault;
    final red = charts.MaterialPalette.red.shadeDefault;
    final yellow = charts.MaterialPalette.yellow.shadeDefault;

    List<charts.Series<PredictedTickerData, int>> series = [
      // Line #1
      new charts.Series(
        id: "ticker",
        data: _data,
        colorFn: (PredictedTickerData series, _) =>
            (series.xaxis / _idxDivid) < 1
                ? blue
                : (series.xaxis / _idxDivid) < 2
                    ? yellow
                    : red,
        domainFn: (PredictedTickerData series, _) => series.xaxis,    // X축
        measureFn: (PredictedTickerData series, _) => series.yprice,  // Y축
        strokeWidthPxFn: (_, __) => 1,                                // 라인 굵기 (PredictedTickerData series, _) => series.yprice
                                                                      // 데이터 값에 상관없이 메세드 전체 적용시 ***
        //colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
      ),
    ];

    return Container(
      height: 180,
      padding: EdgeInsets.only(top: 10.0),
      child: Card(
        color: Color.fromARGB(255, 0, 0, 0),
        // child: Padding(
        // padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: charts.LineChart(
                series,
                animate: false,
                // X축 가이드라인, MAX/MIN 값 지정
                // domainAxis: new charts.OrdinalAxisSpec(
                //     // Make sure that we draw the domain axis line.
                //     showAxisLine: true,
                //     // But don't draw anything else.
                //     renderSpec: new charts.NoneRenderSpec(),

                // ),
                // Y축 가이드라인, MAX/MIN 값 지정
                primaryMeasureAxis: new charts.NumericAxisSpec(
                  renderSpec: charts.GridlineRendererSpec(
                    lineStyle: charts.LineStyleSpec(
                      dashPattern: [1, 1],
                      color: charts.MaterialPalette.gray.shade500,
                    ),
                    //labelStyle: charts.TextStyleSpec(fontSize: 14, color: charts.MaterialPalette.white),
                  ),
                  tickProviderSpec:
                      new charts.BasicNumericTickProviderSpec(
                      desiredTickCount: 5, zeroBound: false
                      ),
                ),

                behaviors: [
                  // 블럭 영역 색상표시 지정 하기
                  new charts.RangeAnnotation([
                    new charts.RangeAnnotationSegment(
                        0, _idxDivid, charts.RangeAnnotationAxisType.domain,
                        startLabel: '어제',
                        //endLabel: '오늘+D1',
                        labelAnchor: charts.AnnotationLabelAnchor.end,
                        labelStyleSpec: charts.TextStyleSpec(
                            fontSize: 14,
                            color: charts.MaterialPalette.white.darker),
                        color: charts.MaterialPalette.gray.shade800,
                        labelDirection:
                            charts.AnnotationLabelDirection.horizontal),

                    new charts.RangeAnnotationSegment((_idxDivid),
                        (_idxDivid * 2), charts.RangeAnnotationAxisType.domain,
                        startLabel: '오늘/D+1',
                        //endLabel: '오늘+D1',
                        labelAnchor: charts.AnnotationLabelAnchor.end,
                        labelStyleSpec: charts.TextStyleSpec(
                            fontSize: 14,
                            color: charts.MaterialPalette.white.darker),
                        color: charts.MaterialPalette.black,
                        labelDirection:
                            charts.AnnotationLabelDirection.horizontal),

                    new charts.RangeAnnotationSegment((_idxDivid * 2),
                        (_idxDivid * 3), charts.RangeAnnotationAxisType.domain,
                        startLabel: 'D+2',
                        //endLabel: '오늘+D1',
                        labelAnchor: charts.AnnotationLabelAnchor.end,
                        labelStyleSpec: charts.TextStyleSpec(
                            fontSize: 14,
                            color: charts.MaterialPalette.white.darker),
                        color: charts.MaterialPalette.black,
                        labelDirection:
                            charts.AnnotationLabelDirection.horizontal),

                    //   new charts.LineAnnotationSegment(
                    //       70000, charts.RangeAnnotationAxisType.measure,
                    //       //startLabel: 'Measure 2 Start',
                    //       endLabel: 'High',
                    //       color: charts.MaterialPalette.gray.shade500,),
                  ],
                      defaultLabelPosition:
                          charts.AnnotationLabelPosition.margin),
                  // 라인 선택 하이라이트
                  // new charts.LinePointHighlighter(
                  //     showHorizontalFollowLine:charts.LinePointHighlighterFollowLineType.none,
                  //     showVerticalFollowLine:charts.LinePointHighlighterFollowLineType.nearest),
                  // new charts.SelectNearest(eventTrigger: charts.SelectionTrigger.tapAndDrag),
                ],
              ),
            )
          ],
        ),
        // ),
      ),
    );
  }
}
