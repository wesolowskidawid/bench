import 'dart:collection';

class Med {
  int id;
  String name;
  double powerMg;
  double powerMl;
  List packageSizeMl; // if there are capsules, put the amount instead of ml
  int capsuleSizeMl; // if there are capsules, put ml of the capsules
  double doseMg;
  double doseKg;

  Med(this.id, this.name, this.powerMg, this.powerMl, this.packageSizeMl, this.capsuleSizeMl, this.doseMg, this.doseKg);

  factory Med.fromJson(Map<String, dynamic> json) {
    return Med(json['id'], json['name'], json['powerMg'], json['powerMl'], json['packageSizeMl'], json['capsuleSizeMl'], json['doseMg'], json['doseKg']);
  }

  int getId() {
    return id;
  }
  String getName() {
    return name;
  }
  double getPowerMg() {
    return powerMg;
  }
  double getPowerMl() {
    return powerMl;
  }
  List getPackageSizeMl() {
    return packageSizeMl;
  }
  int getCapsuleAmount() {
    return capsuleSizeMl;
  }
  double getDoseMg() {
    return doseMg;
  }
  double getDoseKg() {
    return doseKg;
  }

}