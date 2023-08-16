import 'package:flutter/material.dart';

import 'home.dart'; //This is our home page

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Charts Example',
      home: Scaffold(
        appBar: AppBar(title: Text('Flutter Charts Example')),
        body: NewsScreen(), //This is where we specify our homepage
      ),
    );
  }
}