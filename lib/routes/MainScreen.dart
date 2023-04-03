import 'dart:collection';

import 'package:bench/objects/Med.dart';
import 'package:bench/services/remote_service.dart';
import 'package:bench/utils/CalcUtil.dart';
import 'package:bench/utils/ValidateValuesUtil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ResultScreen.dart';

String chosenValue = '';
bool _ageValidated = false;
bool _weightValidated = false;
List<Med> meds = List.empty(growable: true);
bool isErrorVisible = false;

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  void setAgeValidated(bool validated) {
    _ageValidated = validated;
  }
  bool getAgeValidated() {
    return _ageValidated;
  }
  void setWeightValidated(bool validated) {
    _weightValidated = validated;
  }
  bool getWeightValidated() {
    return _weightValidated;
  }

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {

  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  // TextStyle style1 = testStyleGenerator().fontFamily("").fontSize(12).build();

  void submit(String age, String weight, String medName) {
    bool isAgeOK = ValidateValuesUtil().validateAge(age);
    bool isWeightOK = ValidateValuesUtil().validateWeight(weight);
    Med chosenMed = meds.first;
    int medId = 0;

    for(int i = 0; i < meds.length; ++i) {
      if(meds[i].getName() == medName) {
        chosenMed = meds[i];
        medId = i;
        break;
      }
    }

    if(!isAgeOK || !isWeightOK) {
      setState(() {
        isErrorVisible = true;
      });
    }
    else {
      setState(() {
        isErrorVisible = false;
        Get.to(() => ResultScreen(weight: double.tryParse(weight.replaceAll(',', '.'))!, id: medId),
        transition: Transition.downToUp);
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => ResultScreen(double.tryParse(weight.replaceAll(',', '.'))!, medId)),
        // );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchMedList(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xff4ba9c8)),
            );
          }
          else if(snapshot.hasError) {
            return Text('Error: ' + snapshot.error.toString());
          }
          else {
            meds = snapshot.data as List<Med>;
            return Center(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Column(
                    children: [
                      AppHeader(constraints: constraints),
                      Container(
                        width: constraints.maxWidth,
                        height: constraints.maxHeight*0.9,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              EmptySpaceWidget(height: 30),
                              /*
                            AGE
                         */
                              const Text(
                                'Wprowadź wiek dziecka:',
                              ),
                              EmptySpaceWidget(height: 8),
                              SizedBox(
                                width: constraints.maxWidth*0.8,
                                child: FormTextField(controller: ageController, type: TextFieldType.age,),
                              ),
                              EmptySpaceWidget(height: 40),
                              /*
                            WEIGHT
                         */
                              const Text(
                                'Wprowadź wagę dziecka:',
                              ),
                              EmptySpaceWidget(height: 8),
                              SizedBox(
                                width: constraints.maxWidth*0.8,
                                child: FormTextField(controller: weightController, type: TextFieldType.weight,),
                              ),
                              EmptySpaceWidget(height: 40),
                              /*
                            DROPDOWN MENU
                         */
                              const Text(
                                'Wybierz lek z listy:',
                              ),
                              EmptySpaceWidget(height: 8),
                              SizedBox(
                                width: constraints.maxWidth*0.8,
                                height: 60,
                                child: DropdownMenu(width: constraints.maxWidth*0.7,)
                              ),
                              EmptySpaceWidget(height: 60),
                              /*
                            SUBMIT BUTTON
                         */
                              SizedBox(
                                width: constraints.maxWidth*0.8,
                                height: 60,
                                child: ElevatedButton(
                                  onPressed: () {
                                    submit(ageController.text, weightController.text, chosenValue);
                                  },
                                  child: const Text('Oblicz'),
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
                              EmptySpaceWidget(height: 20),
                              const ErrorText(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}

class AppHeader extends StatelessWidget {

  final BoxConstraints constraints;

  AppHeader({required this.constraints});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      )
    );
  }

}

class EmptySpaceWidget extends StatelessWidget {

  final double height;

  EmptySpaceWidget({required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height,);
  }

}

class AppTextStyle {
  static const TextStyle normalFont = TextStyle(fontSize: 18, color: Colors.black,);
}

class ErrorText extends StatefulWidget {
  const ErrorText({Key? key}) : super(key: key);

  State<StatefulWidget> createState() => ErrorTextState();
}

class ErrorTextState extends State<ErrorText> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      key: const Key('errorText'),
      visible: isErrorVisible,
      child: const Text(
        'Błąd: Nieprawidłowy wiek lub waga dziecka.',
        style: TextStyle(
          color: Colors.red,
        ),
      ),
    );
  }
}

/*
    MED DROPDOWN MENU
 */

class DropdownMenu extends StatefulWidget {
  final double width;

  DropdownMenu({key, required this.width});

  @override
  State<DropdownMenu> createState() => DropdownMenuState();
}

class DropdownMenuState extends State<DropdownMenu> {
  String dropdownValue = meds.first.getName();
  List<String> medsName = List.empty(growable: true);

  void updateMedsName() {
    medsName.clear();
    for(Med m in meds) {
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
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Center(
            child: DropdownButton<String>(
              value: dropdownValue,
              elevation: 16,
              isExpanded: true,
              style: const TextStyle(color: Color(0xff4ba9c8)),
              underline: const SizedBox(),
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
              iconEnabledColor: Color(0xff4ba9c8),
              iconDisabledColor: Colors.grey,

            ),
          ),
        ),
    );
  }
}

/*
    TEXT FIELDS
 */

enum TextFieldType {
  age, weight
}

class FormTextField extends StatefulWidget {
  const FormTextField({Key? key, required this.controller, required this.type}) : super(key: key);

  final TextEditingController controller;
  final TextFieldType type;

  @override
  State<FormTextField> createState() => FormTextFieldState();
}

class FormTextFieldState extends State<FormTextField> {

  void _validate() {
    if(widget.type == TextFieldType.age) {
      MainScreen().setAgeValidated(ValidateValuesUtil().validateAge(widget.controller.text));
    }
    else {
      MainScreen().setWeightValidated(ValidateValuesUtil().validateWeight(widget.controller.text));
    }
  }

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    widget.controller.addListener(_validate);
  }

  @override
  Widget build(BuildContext context) {
    Key _key;
    String _hint;
    if(widget.type == TextFieldType.age) {
      _key = const Key('ageTextField');
      _hint = "Wiek dziecka";
    }
    else {
      _key = const Key('weightTextField');
      _hint = "Waga dziecka";
    }

    return TextField(
      key: _key,
      controller: widget.controller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xff4ba9c8)),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xff4ba9c8)),
          borderRadius: BorderRadius.circular(20),
        ),
        hintText: _hint,
      ),
      textAlign: TextAlign.left,
    );
  }
}