import 'dart:convert';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'developer_series.dart';

class HomeChart extends StatefulWidget  {
  @override
  _HomeChartState createState() => _HomeChartState();
}

class _HomeChartState extends State<HomeChart> {
  List<HomeItemSeries> _data = [];

  Future<void> loadJsonData() async {
    final String jsonString = await rootBundle.loadString('assets/json/data.json');
    final List<dynamic> jsonList = json.decode(jsonString);

    setState(() {
      _data = jsonList.map((jsonData) {
        return HomeItemSeries(day: jsonData['day'], price: jsonData['price']);
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<HomeItemSeries, int>> series = [
      // Line #1
      new charts.Series(
        id: "ticker",
        data: _data,
        domainFn: (HomeItemSeries series, _) => series.day,
        measureFn: (HomeItemSeries series, _) => series.price,
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
      ), 
      // Line #2
      // new charts.Series(
      //   id: "tester",
      //   data: [
      //       HomeItemSeries(day: 1,price: 40000,barColor: charts.ColorUtil.fromDartColor(Colors.blue),),
      //       HomeItemSeries(day: 2,price: 8000,barColor: charts.ColorUtil.fromDartColor(Colors.blue),),
      //       HomeItemSeries(day: 6,price: 35000,barColor: charts.ColorUtil.fromDartColor(Colors.blue),),
      //       HomeItemSeries(day: 9,price: 38000,barColor: charts.ColorUtil.fromDartColor(Colors.blue),),
      //   ],
      //   domainFn: (HomeItemSeries series, _) => series.day,
      //   measureFn: (HomeItemSeries series, _) => series.price,
      //   colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
      //   dashPatternFn: (_, __) => [2, 2],
      // )
    ];

    return Container(
      height: 300,
      padding: EdgeInsets.all(10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: charts.LineChart(series, animate: true),
              )
            ],
          ),
        ),
      ),
    );
  }

}
