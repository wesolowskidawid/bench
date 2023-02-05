import 'package:bench/objects/Med.dart';
import 'package:bench/utils/CalcUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  double weight;
  Med chosenMed;

  ResultScreen(this.weight, this.chosenMed, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    double activeSubstance = CalcUtil().calculateActiveSubstance(weight, chosenMed.getDoseMg(), chosenMed.doseKg);
    double medDose = CalcUtil().calculateDose(activeSubstance, chosenMed.powerMg, chosenMed.powerMl);
    String packageSize;
    if(chosenMed.getCapsuleAmount() == 0) {
      packageSize = CalcUtil().calculatePackageSizeNoCapsules(7, 2, medDose, chosenMed.getPackageSizeMl()).toString();
    }
    else {
      packageSize = CalcUtil().calculatePackageSizeCapsules(7, 2, medDose, chosenMed.getPackageSizeMl(), chosenMed.getCapsuleAmount()).toString();
    }
    return Scaffold(
      body: Center(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Column(
              children: [
                Container(
                  height: constraints.maxHeight*0.1,
                  width: constraints.maxWidth,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xff4ba9c8),
                        width: 1,
                      ),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Dawka Dziecięca',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff4ba9c8),
                      ),
                    ),
                  ),
                ),
                Text('Waga dziecka: ' + weight.toString() + 'kg'),
                Text('Dawka substancji czynnej: ' + CalcUtil().roundDouble(activeSubstance) + 'mg'),
                const Text('Długość terapii: 7 dni / 2 razy dziennie'),
                Text('Dawka dla dziecka: ' + CalcUtil().roundDouble(medDose) + 'ml'),
                Text('Zalecane wielkości opakowań: ' + packageSize),
                RaisedButton(
                  child: const Text('Powrót'),
                  onPressed: () {
                    Navigator.pop(context);
                  }
                ),
              ],
            );
          },
        )
      ),
    );
  }

}