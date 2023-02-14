import 'package:bench/utils/CalcUtil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('APAP', () {
    test('Dose should be 11.25: ', () {
      final double weight = 30.0;
      final double powerMg = 40.0;
      final double powerMl = 1.0;
      final double doseMg = 15.0;
      final double doseKg = 1.0;

      final double dose = CalcUtil().calculateDose(CalcUtil().calculateActiveSubstance(weight, doseMg, doseKg), powerMg, powerMl);
      final String res = CalcUtil().roundDouble(dose);

      expect(res, "11.25");
    });
    test('Dose should be 15.00: ', () {
      final double weight = 40.0;
      final double powerMg = 40.0;
      final double powerMl = 1.0;
      final double doseMg = 15.0;
      final double doseKg = 1.0;

      final dose = CalcUtil().calculateDose(CalcUtil().calculateActiveSubstance(weight, doseMg, doseKg), powerMg, powerMl);
      final String res = CalcUtil().roundDouble(dose);

      expect(res, "15.00");
    });
    test('Dose should be 18.75: ', () {
      final double weight = 50.0;
      final double powerMg = 40.0;
      final double powerMl = 1.0;
      final double doseMg = 15.0;
      final double doseKg = 1.0;

      final dose = CalcUtil().calculateDose(CalcUtil().calculateActiveSubstance(weight, doseMg, doseKg), powerMg, powerMl);
      final String res = CalcUtil().roundDouble(dose);

      expect(res, "18.75");
    });
    test('Dose should be 14.06: ', () {
      final double weight = 37.5;
      final double powerMg = 40.0;
      final double powerMl = 1.0;
      final double doseMg = 15.0;
      final double doseKg = 1.0;

      final dose = CalcUtil().calculateDose(CalcUtil().calculateActiveSubstance(weight, doseMg, doseKg), powerMg, powerMl);
      final String res = CalcUtil().roundDouble(dose);

      expect(res, "14.06");
    });
  });
}