// import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:convert';

import 'package:flutter/material.dart';
import '../../models/analysis_model.dart';
import '../../providers/analysis_provider.dart';

class AnalysisPointList extends StatefulWidget  {
  final String ticker;                        // 상위 위젯 호출시 변수값 전달 받기 위함
  AnalysisPointList({required this.ticker});  // 상위 위젯 호출시 변수값 전달 받기 위함

  @override
  _AnalysisPointListState createState() => _AnalysisPointListState();
}

class _AnalysisPointListState extends State<AnalysisPointList> {
  late String ticker; // 상위 위젯으로부터 호출시 변수값 전달 받기 위함


  @override
  void initState() {
    super.initState();
    ticker = widget.ticker; // 상위 위젯으로부터 호출시 변수값 전달 받기 위함
  }

  @override
  Widget build(BuildContext context) {

    // final blue = charts.MaterialPalette.blue.shadeDefault;
    return Container(
      height: 230,
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

                            return ListView.builder(
                                itemCount: jsonData?.length,
                                itemBuilder: (BuildContext context, int index) {

                                  // 1행 데이터 분리(,)
                                  List<dynamic> rowData = _parseJsonRow(jsonData![index].toString());
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(rowData[0].toString().substring(5, 7)+'/'+rowData[0].toString().substring(7, 9), 
                                                  style: const TextStyle(fontSize: 13.0, color: Color(0xFFededed))),
                                          SizedBox(width: 12.0, height: 20,),
                                          Text(rowData[1].toString(), 
                                                  style: const TextStyle(fontSize: 13.0, color: Color(0xFF797979))),
                                          SizedBox(width: 12.0,),
                                          Text(rowData[2].toString(), 
                                                  style: const TextStyle(fontSize: 13.0, color: Color(0xFFededed))),
                                          SizedBox(width: 12.0,),
                                          Text(rowData[3].toString(), 
                                                  style: const TextStyle(fontSize: 13.0, color: Color(0xFFededed))),
                                          SizedBox(width: 12.0,),
                                          Text(rowData[4].toString(), 
                                                  style: const TextStyle(fontSize: 13.0, color: Color(0xFFededed))),
                                          SizedBox(width: 12.0,),
                                          // container에 넣고 radius(3)로 둥글게 처리하고 color(빨강, 파랑)로 색상 처리
                                          Container(
                                            //text align left로 설정
                                            alignment: Alignment.centerRight,
                                            width: 55.0,
                                            height: 18.0,
                                            padding: EdgeInsets.fromLTRB(2, 0, 5, 0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(3),
                                              color: _calcRate(rowData[4].toString(), rowData[1].toString()).contains('-') ?
                                              Color.fromARGB(255, 46, 117, 250) : Color.fromARGB(255, 251, 61, 61),
                                            ),
                                            child: Text(_calcRate(rowData[4].toString(), rowData[1].toString()) + '%', 
                                                    style: TextStyle(fontSize: 14.0, color: Color(0xFFededed))),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
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
}

