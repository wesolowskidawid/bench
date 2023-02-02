import 'dart:ui';

import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: constraints.maxHeight*0.05,
                  child: const SizedBox(),
                ),
                Container(
                  height: constraints.maxHeight*0.5,
                  child: Image.asset(
                    'assets/images/bench_logo.jpg',
                    fit: BoxFit.cover,
                    scale: 0.5,
                  ),
                ),
                Container(
                  height: constraints.maxHeight*0.1,
                  child: const Text(
                    'Dawka Dziecięca',
                    style: TextStyle(
                        fontFamily: 'SanFrancisco',
                        color: Color(0xff4ba9c8),
                        decoration: TextDecoration.none,
                        fontSize: 40
                    ),
                  ),
                ),
                Container(
                  height: constraints.maxHeight*0.2,
                  child: const SizedBox(),
                ),
                Container(
                  height: constraints.maxHeight*0.05,
                  width: constraints.maxHeight*0.05,
                  child: const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xff4ba9c8)),
                  ),
                ),
                Container(
                  height: constraints.maxHeight*0.1,
                  child: const SizedBox(),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}