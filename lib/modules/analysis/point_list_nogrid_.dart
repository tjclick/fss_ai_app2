
import 'package:flutter/material.dart';
import 'package:fss_ai_app2/models/analysis_model.dart';
import 'package:fss_ai_app2/providers/analysis_provider.dart';

class AnalysisPointList extends StatefulWidget {
  final String ticker; // 상위 위젯 호출시 변수값 전달 받기 위함
  AnalysisPointList({required this.ticker}); // 상위 위젯 호출시 변수값 전달 받기 위함

  @override
  _AnalysisPointListState createState() => _AnalysisPointListState();
}

class _AnalysisPointListState extends State<AnalysisPointList> {
  late String ticker; // 상위 위젯으로부터 호출시 변수값 전달 받기 위함
  bool isLoading = true;
  List<TickerPointListData> pTDPointList = [];
  AnalysisProviders analysisProvider = AnalysisProviders();

  Future initTickerPointList() async {
    List<dynamic> jsonData = [];
    pTDPointList = await analysisProvider.getTickerPointListData(ticker);

    jsonData = pTDPointList;
  }

  @override
  void initState() {
    super.initState();
    ticker = widget.ticker; // 상위 위젯으로부터 호출시 변수값 전달 받기 위함
    initTickerPointList().then((_) {
      setState(() {
        isLoading = false;
      });
    });

  }


  @override
  Widget build(BuildContext context) {
    // final blue = charts.MaterialPalette.blue.shadeDefault;
    return Container(
      height: 150,
      //padding: EdgeInsets.only(top: 10.0),
      child: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: pTDPointList.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                          8,
                          (index) => Container(
                            height: 25,
                            width: 42, // 각 열의 너비
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Text('$index', style: TextStyle(fontSize: 12, color: Colors.white)),
                          ),
                        ),
                      ),
                );
              },
            ),
      
    );

  }


}