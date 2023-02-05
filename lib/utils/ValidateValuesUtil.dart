class ValidateValuesUtil {

  bool validateAge(String age) {
    if(int.tryParse(age) != null) {
      if(int.tryParse(age)! > 0 && int.tryParse(age)! <= 100) {
        return true;
      }
    }
    return false;
  }

  bool validateWeight(String weight) {
    weight = weight.replaceAll(',', '.');
    if(double.tryParse(weight) != null) {
      if(double.tryParse(weight)! > 0) {
        return true;
      }
    }
    return false;
  }

}