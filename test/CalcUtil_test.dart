import 'package:bench/utils/CalcUtil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('APAP', () {
    test('Dose should be 11.25: ', () {
      const double weight = 30.0;
      const double powerMg = 40.0;
      const double powerMl = 1.0;
      const double doseMg = 15.0;
      const double doseKg = 1.0;

      final double dose = CalcUtil().calculateDose(CalcUtil().calculateActiveSubstance(weight, doseMg, doseKg), powerMg, powerMl);
      final String res = CalcUtil().roundDouble(dose);

      expect(res, "11.25");
    });
    test('Dose should be 15.00: ', () {
      const double weight = 40.0;
      const double powerMg = 40.0;
      const double powerMl = 1.0;
      const double doseMg = 15.0;
      const double doseKg = 1.0;

      final dose = CalcUtil().calculateDose(CalcUtil().calculateActiveSubstance(weight, doseMg, doseKg), powerMg, powerMl);
      final String res = CalcUtil().roundDouble(dose);

      expect(res, "15.00");
    });
    test('Dose should be 18.75: ', () {
      const double weight = 50.0;
      const double powerMg = 40.0;
      const double powerMl = 1.0;
      const double doseMg = 15.0;
      const double doseKg = 1.0;

      final dose = CalcUtil().calculateDose(CalcUtil().calculateActiveSubstance(weight, doseMg, doseKg), powerMg, powerMl);
      final String res = CalcUtil().roundDouble(dose);

      expect(res, "18.75");
    });
    test('Dose should be 14.06: ', () {
      const double weight = 37.5;
      const double powerMg = 40.0;
      const double powerMl = 1.0;
      const double doseMg = 15.0;
      const double doseKg = 1.0;

      final dose = CalcUtil().calculateDose(CalcUtil().calculateActiveSubstance(weight, doseMg, doseKg), powerMg, powerMl);
      final String res = CalcUtil().roundDouble(dose);

      expect(res, "14.06");
    });
  });

  group('PackagesNoCapsules', () {
    test('Should return [150.0, 85.0]', () {
      const double dose = 15.0;
      final List<double> packageSize = List.of({85, 150});

      final List<double> res = CalcUtil().calculatePackageSizeNoCapsules(7, 2, dose, packageSize);

      expect(res.toString(), "[150.0, 85.0]");
    });
    test('Should return [150.0, 85.0, 85.0]', () {
      const double dose = 18.75;
      final List<double> packageSize = List.of({85, 150});

      final List<double> res = CalcUtil().calculatePackageSizeNoCapsules(7, 2, dose, packageSize);

      expect(res.toString(), "[150.0, 85.0, 85.0]");
    });
    test('Should return [150.0, 150.0, 85.0]', () {
      const double dose = 22.0;
      final List<double> packageSize = List.of({85, 150});

      final List<double> res = CalcUtil().calculatePackageSizeNoCapsules(7, 2, dose, packageSize);

      expect(res.toString(), "[150.0, 150.0, 85.0]");
    });
  });

  group('PackagesCapsules', () {
    test('Should return [20.0, 10.0]', () {
      const double dose = 4.0;
      const int capsuleSizeMl = 2;
      final List<double> packageSize = List.of({10, 20});

      final List<double> res = CalcUtil().calculatePackageSizeCapsules(7, 2, dose, packageSize, capsuleSizeMl);

      expect(res.toString(), "[20.0, 10.0]");
    });
    test('Should return [20.0, 20.0, 20.0]', () {
      const double dose = 8.2;
      const int capsuleSizeMl = 2;
      final List<double> packageSize = List.of({10, 20});

      final List<double> res = CalcUtil().calculatePackageSizeCapsules(7, 2, dose, packageSize, capsuleSizeMl);

      expect(res.toString(), "[20.0, 20.0, 20.0]");
    });
  });
}