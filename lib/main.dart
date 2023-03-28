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
        fontFamily: 'Montserrat',
        textTheme: appTheme(),
      ),
      // home: LoadingScreen(),
      home: MainScreen(),
    );
  }
}

TextTheme appTheme() {
  return const TextTheme(
    button: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 16,
    ),
    bodyText1: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 16,
    ),
    bodyText2: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 16,
    ),
  );
}