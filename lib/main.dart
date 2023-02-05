import 'package:bench/routes/MainScreen.dart';
import 'package:flutter/material.dart';
import 'routes/SplashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dawka Dziecięca',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'SanFrancisco',
      ),
      // home: LoadingScreen(),
      home: MainScreen(),
    );
  }
}