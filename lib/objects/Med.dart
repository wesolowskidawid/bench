import 'dart:collection';

class Med {
  String name;
  double powerMg;
  double powerMl;
  List<double> packageSizeMl; // if there are capsules, put the amount instead of ml
  int capsuleSizeMl; // if there are capsules, put ml of the capsules
  double doseMg;
  double doseKg;

  Med(this.name, this.powerMg, this.powerMl, this.packageSizeMl, this.capsuleSizeMl, this.doseMg, this.doseKg);

  String getName() {
    return name;
  }
  double getPowerMg() {
    return powerMg;
  }
  double getPowerMl() {
    return powerMl;
  }
  List<double> getPackageSizeMl() {
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