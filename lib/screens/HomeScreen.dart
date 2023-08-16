import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/home_model.dart';
import '../modules/charts/home_chart.dart';
import '../providers/home_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<PredictedTickerList> pTickerList = [];
  bool isLoading = true;
  HomeProviders homeProvider = HomeProviders();

  void _onItemTapped(int index) {
    if (index == 0) Get.toNamed("/home");
    if (index == 1) Get.toNamed("/analysis");
    if (index == 2) Get.toNamed("/perform");
    if (index == 3) Get.toNamed("/users");
  }


  Future initPredictedTickerList() async {
    pTickerList = await homeProvider.getPredictedTickerList();
  }

  @override
  void initState() {
    super.initState();
    initPredictedTickerList().then((_) {
      setState(() {
        isLoading = false;
      });
    });
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
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                // Here, you can return a widget for each item based on the index.
                return Container(
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
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
                            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                            height: 280,
                            width: MediaQuery.of(context).size.width * 0.92,
                            decoration: BoxDecoration(
                              color: Color(0xFF1e1e1e),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              //column children left 위치 정렬
                              //padding left 15
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 200,
                                  width: MediaQuery.of(context).size.width * 0.91,
                                  child: HomeItemChart(),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'H 13,500 (+12.4%)',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 255, 70, 70),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'L 12,100 (-1.8%)',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 42, 174, 250),
                                  ),
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
      
      
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
            backgroundColor: Color(0xFF292929),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: '분석',
            backgroundColor: Color(0xFF292929),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: '실적',
            backgroundColor: Color(0xFF292929),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: '회원',
            backgroundColor: Color(0xFF292929),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFFededed),
        unselectedItemColor: Color.fromARGB(255, 94, 94, 94),
        onTap: _onItemTapped,
      ),
    );
  }
}

