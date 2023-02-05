import 'dart:collection';

import 'package:bench/objects/Med.dart';
import 'package:bench/utils/CalcUtil.dart';
import 'package:bench/utils/ValidateValuesUtil.dart';
import 'package:flutter/material.dart';

String chosenValue = '';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  final List<Med> meds = List.of(
    {
      Med('APAP', 40.0, 1.0, List.of({85, 150}), 0, 15.0, 1.0),
      Med('LEVOpront', 60.0, 10.0, List.of({120}), 0, 1.5, 1.0),
      Med('Pulmicort', 0.5, 1.0, List.of({10, 20}), 2, 0.25, 5.0)
    },
  );

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {

  List<Med> meds = MainScreen().meds;

  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  bool isErrorVisible = false;

  void calc() {
    double weight = 40.0;
    print('Weight: ' + weight.toString() + 'kg');
    double activeSubstance;
    double dose;
    for(Med m in meds) {
      print('---\nMed name: ' + m.getName());
      print('Power: ' + m.getPowerMg().toString() + 'mg/' + m.getPowerMl().toString() + 'ml');
      print('Dose: ' + m.getDoseMg().toString() + 'mg/' + m.getDoseKg().toString() + 'kg');
      activeSubstance = CalcUtil().calculateActiveSubstance(weight, m.getDoseMg(), m.getDoseKg());
      print('Active Substance: ' + activeSubstance.toString() + 'ml');
      dose = CalcUtil().calculateDose(activeSubstance, m.powerMg, m.powerMl);
      print('Dose: ' + dose.toString() + 'ml');
      if(m.getCapsuleAmount() == 0) {
        print('Package size: ' + CalcUtil().calculatePackageSizeNoCapsules(7, 2, dose, m.getPackageSizeMl()).toString());
      }
      else {
        print('Package size: ' + CalcUtil().calculatePackageSizeCapsules(7, 2, dose, m.getPackageSizeMl(), m.getCapsuleAmount()).toString());
      }
    }
  }

  void submit(String age, String weight, String medName) {
    // print('Submit: ');
    // print('Age: ' + age + " | valid: " + ValidateValuesUtil().validateAge(age).toString());
    // print('Weight: ' + weight + " | valid: " + ValidateValuesUtil().validateWeight(weight).toString());
    // print(medName);
    bool isAgeOK = ValidateValuesUtil().validateAge(age);
    bool isWeightOK = ValidateValuesUtil().validateWeight(weight);

    if(!isAgeOK || !isWeightOK) {
      setState(() {
        isErrorVisible = true;
      });
    }
    else {
      setState(() {
        isErrorVisible = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight*0.9,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                            'Wprowadź wiek dziecka:',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth*0.5,
                          child: TextField(
                            controller: ageController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xff4ba9c8)),
                                  borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Color(0xff4ba9c8)),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              hintText: 'Wiek dziecka',
                            ),
                          ),
                        ),
                        const SizedBox(height: 40,),
                        const Text(
                            'Wprowadź wagę dziecka:',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth*0.5,
                          child: TextField(
                            controller: weightController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Color(0xff4ba9c8)),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Color(0xff4ba9c8)),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              hintText: 'Waga dziecka',
                            ),
                          ),
                        ),
                        const SizedBox(height: 40,),
                        const Text(
                            'Wybierz lek z listy:',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth*0.5,
                          child: const DropdownMenu(),
                        ),
                        const SizedBox(height: 40,),
                        RaisedButton(
                          onPressed: () {
                            submit(ageController.text, weightController.text, chosenValue);
                          },
                          child: Text('Test'),
                        ),
                        const SizedBox(height: 20,),
                        Visibility(
                          visible: isErrorVisible,
                          child: const Text(
                            'Błąd: Nieprawidłowy wiek lub waga dziecka.',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class DropdownMenu extends StatefulWidget {
  const DropdownMenu({key});

  @override
  State<DropdownMenu> createState() => DropdownMenuState();
}

class DropdownMenuState extends State<DropdownMenu> {
  String dropdownValue = MainScreen().meds.first.getName();
  List<String> medsName = List.empty(growable: true);

  void updateMedsName() {
    medsName.clear();
    for(Med m in MainScreen().meds) {
      medsName.add(m.getName());
    }
  }

  @override
  Widget build(BuildContext context) {
    updateMedsName();
    return DecoratedBox(
        decoration: const ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1.0, style: BorderStyle.solid, color: Color(0xff4ba9c8)),
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
        ),
        child: DropdownButton<String>(
          value: dropdownValue,
          elevation: 16,
          isExpanded: true,
          style: const TextStyle(color: Color(0xff4ba9c8)),
          underline: Container(
            height: 2,
            color: const Color(0xff4ba9c8),
          ),
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              dropdownValue = value!;
              chosenValue = dropdownValue;
              // print(dropdownValue);
            });
          },
          items: medsName.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
    );
  }
}