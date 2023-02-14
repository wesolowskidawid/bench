class CalcUtil {

  double calculateActiveSubstance(double weight, double doseMl, double doseKg) {
    return (weight/doseKg)*doseMl;
  }

  double calculateDose(double activeSubstace, double powerMg, double powerMl) {
    return (activeSubstace/powerMg)*powerMl;
  }

  List<double> calculatePackageSizeNoCapsules(int days, int timesADay, double dose, List<double> packageSize) {
    double bigDose = dose*(days*timesADay);
    List<double> result = List.empty(growable: true);
    // int temp = packageSize.length-1;
    // while(true) {
    //   if(temp == 0 && bigDose > 0) {
    //     result.add(packageSize[temp]);
    //     bigDose -= packageSize[temp];
    //   }
    //   else if(temp == 0 && bigDose <= 0) {
    //     break;
    //   }
    //   else if(packageSize[temp] <= bigDose) {
    //     result.add(packageSize[temp]);
    //     bigDose -= packageSize[temp];
    //   }
    //   else {
    //     temp -= 1;
    //   }
    // }
    while(bigDose > 0) {
      for(int i = 0; i < packageSize.length; i++) {
        if(i == packageSize.length-1) {
          result.add(packageSize[i]);
          bigDose -= packageSize[i];
          break;
        }
        else if((bigDose - packageSize[i]).abs() < (bigDose - packageSize[i+1]).abs()) {
          result.add(packageSize[i]);
          bigDose -= packageSize[i];
          break;
        }
      }
    }
    return result;
  }

  List<double> calculatePackageSizeCapsules(int days, int timesADay, double dose, List<double> packageSize, int capsuleSizeMl) {
    double bigDose = dose*(days*timesADay);
    List<double> result = List.empty(growable: true);
    double capsulesAmount = bigDose / capsuleSizeMl;
    while(capsulesAmount > 0) {
      for(int i = 0; i < packageSize.length; i++) {
        if(i == packageSize.length-1) {
          result.add(packageSize[i]);
          capsulesAmount -= packageSize[i];
          break;
        }
        else if((capsulesAmount - packageSize[i]).abs() < (capsulesAmount - packageSize[i+1]).abs()) {
          result.add(packageSize[i]);
          capsulesAmount -= packageSize[i];
          break;
        }
      }
    }
    return result;
  }

  String roundDouble(double x) {
    return x.toStringAsFixed(2);
  }

}