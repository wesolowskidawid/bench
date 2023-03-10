import 'package:bench/objects/Med.dart';
import 'package:bench/services/remote_service.dart';
import 'package:bench/utils/CalcUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {

  double weight;
  int id;

  ResultScreen(this.weight, this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: FutureBuilder<Map<String, String>>(
          future: fetchData(weight, id),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            else if(snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Waga: ' + CalcUtil().roundDouble(double.parse(snapshot.data!['weight']!)) + "kg"),
                  Text('Ilość substancji aktywnej: ' + CalcUtil().roundDouble(double.parse(snapshot.data!['activesubstance']!)) + 'mg'),
                  Text('Dawka dla dziecka: ' + CalcUtil().roundDouble(double.parse(snapshot.data!['meddose']!)) + 'mg'),
                  Text("Wielkości opakowań: " + snapshot.data!['packagesize']!),
                ],
              );
            }
          },
        ),
      ),
    );
  }



}