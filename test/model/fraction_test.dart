import 'package:flutter_test/flutter_test.dart';
import 'package:calculator2022/model/fruction.dart';

void main() {
  test("fruction_and_fruction", () {
    final a = Fruction(2, 3);
    final b = Fruction(4, 3);
    final result = a / b;
    final anser = Fruction(1, 2);
    expect(result, anser);
  });

  test("fructionfruction_and_int", () {
    final a = Fruction(2, 3);
    const b = 3;
    final result = a / b;
    Fruction anser = Fruction(2, 9);
    expect(result, anser);
  });
}
