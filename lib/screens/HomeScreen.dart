import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fss_ai_app2/models/home_model.dart';
import 'package:fss_ai_app2/modules/home/predict_d123_chart.dart';
import 'package:fss_ai_app2/modules/home/recomm_sub_data.dart';
import 'package:fss_ai_app2/providers/home_provider.dart';
import 'package:fss_ai_app2/screens/BottomNavigationBar.dart';
import 'package:get/get.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PredictedTickerList> pTickerList = [];
  bool isLoading = true;
  HomeProviders homeProvider = HomeProviders();
  bool isToastDisplayed = false;

  int _currentIndex = 0;
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    //if (index == 0) Get.toNamed("/home");
    if (index == 1) Get.toNamed("/analysis");
    if (index == 2) Get.toNamed("/history");
    if (index == 3) Get.toNamed("/users");
  }


  Future initPredictedTickerList() async {
    pTickerList = await homeProvider.getPredictedTickerList();
    await Future.delayed(Duration(seconds: 1));
  }

  @override
  void initState() {
    super.initState();
    initPredictedTickerList().then((_) {
      setState(() {
        isLoading = false;
        isToastDisplayed = true;
      });
    });

    // fluttertoast 메세지 두번 띄우기
    if (!isToastDisplayed) {
      Fluttertoast.showToast(
            msg: "AI는 투자경고 종목은 추천하지 않습니다",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Color.fromARGB(255, 250, 78, 78), // Customize the background color
            fontSize: 16.0, // Customize the font size
      );
      
      Future.delayed(Duration(seconds: 2), () {
          if (pTickerList.isEmpty) {
            Fluttertoast.showToast(
              msg: "시황 불안정으로 종목을 추천하지 않습니다",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              backgroundColor: Color.fromARGB(255, 250, 78, 78), // Customize the background color
              fontSize: 16.0, // Customize the font size
            );
          
          }
        }
      );
      
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GOOD.AI',
          style: TextStyle(
            color: Color(0xFFEDEDED),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            color: Color(0xFFEDEDED),
            onPressed: () {
              // Handle search action
            },
          ),
        ],
        backgroundColor: Color(0xFF292929),
      ),

      body: CustomScrollView(
        slivers: <Widget>[
          // SliverList에 여러개의 item을 구성하고  title과 image를 구성
          // [더보기 + ] 누르면 해당 종목만 -> analysis(해당 종목만 보여주기)로 이동
          // bottomNavigationBar 이동시는 -> analysis(추천종목 전체 보여주기)
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                // Here, you can return a widget for each item based on the index.
                return Container(
                  padding: EdgeInsets.fromLTRB(15, 20, 0, 0),
                  child: Column(
                    children: [
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(pTickerList[index].name,
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFFEDEDED),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 20),
                          Text(pTickerList[index].ticker,
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF797979),
                              //fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        //row children right
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            height: 270,
                            width: MediaQuery.of(context).size.width * 0.92,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 0, 0, 0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              //column children left 위치 정렬
                              //padding left 15
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 180,
                                  width: MediaQuery.of(context).size.width * 0.99,
                                  // chart(home_chart) widget 호출 ticker변수 전달
                                  child: HomeItemChart(ticker: pTickerList[index].ticker),
                                ),
                                //SizedBox(height: 5),
                                // 3*3 grid안에  각각의 grid에 text를 넣기 위해 column 사용하고 radius 10을 주고 색상을 넣어줌 
                                Container(
                                  padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                                  height: 80,
                                  width: MediaQuery.of(context).size.width * 0.99,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: HomeSubLabelData(ticker: pTickerList[index].ticker),
                                ),
                              ],
                            ),
                            
                          ),// Replace with the actual number of items
                        ]
                      ),
                      
                    ],
                  ),
                );
              },
              childCount: pTickerList.length,
            ),
          ),
        ],
      ),
      
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
      
    );
  }
}

