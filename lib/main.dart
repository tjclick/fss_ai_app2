import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screens/AnalysisScreen.dart';
import 'screens/HomeScreen.dart';
import 'screens/NewsScreen.dart';

void main() {
  HttpOverrides.global = NoCheckCertificateHttpOverrides();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GOOD.AI',
      theme: ThemeData(
        useMaterial3: true,
        //colorScheme: lightColorScheme,
        scaffoldBackgroundColor: Color(0xff292929),
        iconTheme: IconThemeData(color: Colors.white, size: 30),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        //colorScheme: darkColorScheme,
        scaffoldBackgroundColor: Color(0xff292929),
        iconTheme: IconThemeData(
          color: Colors.white,
          size: 30,
        ),
      ),
      themeMode: ThemeMode.system,
      initialRoute: "/",
      getPages: [
        // # DEMO
        GetPage(name: "/", page: () => HomeScreen()),
        GetPage(name: "/home", page: () => HomeScreen()),
        GetPage(name: "/analysis", page: () => AnalysisScreen()),
        GetPage(name: "/news", page: () => NewsScreen()),

        // # API Test
        //GetPage(name: "/", page: () => HomeScreen()),
        //GetPage(name: "/drivers", page: () => ReturnPvc()),
        // # GetX Test
        //GetPage(name: "/map", page: () => PageMapApp()),
        //GetPage(name: "/para/:ID4", page: () => PageParaApp()),
      ],
      //home: HomeScreen(),
    );
  }
}

class NoCheckCertificateHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
