import 'package:flutter_test/flutter_test.dart';
import 'package:calculator2022/model/fraction.dart';

void main() {
  test("fruction_and_fruction", () {
    final a = Fraction(2, 3);
    final b = Fraction(4, 3);
    final result = a / b;
    final anser = Fraction(1, 2);
    expect(result, anser);
  });

  test("fructionfruction_and_int", () {
    final a = Fraction(2, 3);
    const b = 3;
    final result = a / b;
    Fraction anser = Fraction(2, 9);
    expect(result, anser);
  });
}
