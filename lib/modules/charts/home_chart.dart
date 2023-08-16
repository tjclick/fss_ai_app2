import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class HomeItemChart extends StatelessWidget {
  final List<charts.Series<OrdinalSales, int>> seriesList = [
    charts.Series<OrdinalSales, int>(
      id: 'Sales',
      domainFn: (OrdinalSales sales, _) => sales.year,
      measureFn: (OrdinalSales sales, _) => sales.sales,
      data: [
        OrdinalSales(0, 5),
        OrdinalSales(5, 25),
        OrdinalSales(7, 100),
        OrdinalSales(10, 75),
        OrdinalSales(13, 175),
        OrdinalSales(15, 45),
        OrdinalSales(17, 105),
        OrdinalSales(20, 145),
      ],
      colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
      //fillColorFn: (_, __) => charts.MaterialPalette.red.shadeDefault.lighter,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: charts.LineChart(
        seriesList,
        //animate: true,
      ),
    );
  }
}

class OrdinalSales {
  final int year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}