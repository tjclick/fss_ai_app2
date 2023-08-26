// import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

// import 'package:fss_ai_app2/models/analysis_model.dart';
// import 'package:fss_ai_app2/providers/analysis_provider.dart';

class AnalysisCrawlJson extends StatefulWidget  {
  final String ticker;                    // 상위 위젯 호출시 변수값 전달 받기 위함
  AnalysisCrawlJson({required this.ticker});  // 상위 위젯 호출시 변수값 전달 받기 위함

  @override
  _AnalysisCrawlJsonState createState() => _AnalysisCrawlJsonState();
}

class _AnalysisCrawlJsonState extends State<AnalysisCrawlJson> {
  late String ticker; // 상위 위젯으로부터 호출시 변수값 전달 받기 위함
  // int _idxDivid = 350;

  // AnalysisProviders analysisProviders = AnalysisProviders();
  // List<TickerDailySiseData> pTDSiseData = [];
  // List<TickerDailySiseData> _data = [];

  Future<void> loadJsonData() async {
    // provider에게 변수값으로 호출 연동
    // pTDSiseData = await analysisProviders.getTickerDailySiseData(ticker);

    // setState(() {
    //   _data = pTDSiseData;
      
    // });
  }

  @override
  void initState() {
    super.initState();
    ticker = widget.ticker; // 상위 위젯으로부터 호출시 변수값 전달 받기 위함

    loadJsonData();
  }

  @override
  Widget build(BuildContext context) {
    // final blue = charts.MaterialPalette.blue.shadeDefault;
    // final red = charts.MaterialPalette.red.shadeDefault;
    // final yellow = charts.MaterialPalette.yellow.shadeDefault;

    // List<charts.Series<TickerDailySiseData, int>> series = [
    //   // Line #1
    //   // new charts.Series(
    //   //   id: "ticker",
    //   //   data: _data,
    //   //   domainFn: (TickerDailySiseData series, _) => series.tds_datetime,    // X축
    //   //   measureFn: (TickerDailySiseData series, _) => series.tds_high,       // Y축
    //   //   strokeWidthPxFn: (_, __) => 1,                                // 라인 굵기 (PredictedTickerData series, _) => series.yprice
    //   //                                                                 // 데이터 값에 상관없이 메세드 전체 적용시 ***
    //   //   colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
    //   // ),
    // ];

    return Container(
      height: 180,
      padding: EdgeInsets.only(top: 10.0),
      child: Card(
        color: Color.fromARGB(255, 0, 0, 0),
        // child: Padding(
        // padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          // children: <Widget>[
          //   Expanded(
          //     child: 


          //     ),
          //   )
          // ],
        ),
        // ),
      ),
    );
  }
}
