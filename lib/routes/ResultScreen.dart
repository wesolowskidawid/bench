import 'dart:convert';

import 'package:bench/main.dart';
import 'package:bench/objects/Med.dart';
import 'package:bench/routes/MainScreen.dart';
import 'package:bench/services/remote_service.dart';
import 'package:bench/utils/CalcUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultScreen extends StatelessWidget {

  double weight;
  int id;

  ResultScreen({required this.weight, required this.id});

  // Scaffold w Materialapp

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<Map<String, String>>(
          future: fetchData(weight, id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            else {
              String response = snapshot.data!['packagesize']!;
              List<double> respList = (jsonDecode(response) as List<dynamic>)
                  .cast<double>();
              Map<double, int> result = {};
              for (double d in respList) {
                if (result.containsKey(d)) {
                  int x = result[d]!;
                  x += 1;
                  result[d] = x;
                }
                else {
                  result[d] = 1;
                }
              }
              respList = respList.toSet().toList();
              print(result.entries);
              return Center(
                child: LayoutBuilder(
                    builder: (BuildContext context,
                        BoxConstraints constraints) {
                      return Column(
                          children: [
                            AppHeader(constraints: constraints),
                            Container(
                              width: constraints.maxWidth,
                              height: constraints.maxHeight * 0.9,
                              child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      EmptySpaceWidget(height: 30),
                                      const Text(
                                        'Dawka dla dziecka:',
                                        style: AppTextStyle.normalFont,
                                      ),
                                      EmptySpaceWidget(height: 5),
                                      Container(
                                          width: constraints.maxWidth * 0.8,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color(
                                                    0xff4ba9c8)),
                                            borderRadius: BorderRadius
                                                .circular(20),
                                          ),
                                          child: Center(
                                            child: Text(
                                              CalcUtil().roundDouble(
                                                  double.parse(snapshot
                                                      .data!['meddose']!)) +
                                                  'mg',
                                              style: AppTextStyle.normalFont,
                                            ),
                                          )
                                      ),
                                      EmptySpaceWidget(height: 30),
                                      const Text(
                                        "Wielkości opakowań: ",
                                        style: AppTextStyle.normalFont,
                                      ),
                                      EmptySpaceWidget(height: 5),
                                      Container(
                                        width: constraints.maxWidth * 0.8,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(
                                                  0xff4ba9c8)),
                                          borderRadius: BorderRadius
                                              .circular(20),
                                        ),
                                        child: Center(
                                          child: ListView(
                                            children: result.entries.map((e) => Center(
                                                child: Text(
                                                  '${e.key}mg: ${e.value} sztuk',
                                                  style: AppTextStyle.normalFont,
                                                )
                                            )).toList(),
                                          ),
                                        ),
                                      ),
                                      EmptySpaceWidget(height: 60),
                                      Center(
                                          child: Column(
                                            children: const [
                                              Text('Terapia trwa 7 dni.'),
                                              Text('Podawać lek 2 razy na dobę.'),
                                            ],
                                          )
                                      ),
                                      EmptySpaceWidget(height: 60),
                                      SizedBox(
                                        width: constraints.maxWidth*0.8,
                                        height: 60,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: const Text('Powrót'),
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.white,
                                              onPrimary: Colors.black,
                                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20),
                                                  side: const BorderSide(
                                                    color: Color(0xff4ba9c8),
                                                    width: 1.0,
                                                  )
                                              )
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                            ),
                          ]
                      );
                    }
                ),
              );
            }
          },
        ),
      ),
    );
  }
}