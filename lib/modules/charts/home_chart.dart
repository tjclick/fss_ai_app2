import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../../models/home_model.dart';
import '../../providers/home_provider.dart';

class HomeItemChart extends StatefulWidget  {
  @override
  _HomeItemChartState createState() => _HomeItemChartState();
}

class _HomeItemChartState extends State<HomeItemChart> {
  HomeProviders homeProvider = HomeProviders();
  List<PredictedTickerData> pTickerData = [];
  List<PredictedTickerData> _data = [];

  Future<void> loadJsonData() async {
    pTickerData = await homeProvider.getPredictedTickerData();

    setState(() {
      _data = pTickerData;
    });
  }

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

@override
  Widget build(BuildContext context) {
    List<charts.Series<PredictedTickerData, int>> series = [
      // Line #1
      new charts.Series(
        id: "ticker",
        data: _data,
        domainFn: (PredictedTickerData series, _) => series.xaxis,
        measureFn: (PredictedTickerData series, _) => series.yprice,
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
      ), 
    ];

    return Container(
      height: 200,
      //padding: EdgeInsets.all(10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: charts.LineChart(
                  series, 
                  animate: false
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }

}