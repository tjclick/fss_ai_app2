import 'package:flutter/material.dart';

import 'developer_chart.dart';

class HomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: HomeChart()
      ),
    );
  }
}