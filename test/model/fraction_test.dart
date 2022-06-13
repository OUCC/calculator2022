import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:calculator2022/model/fruction.dart';

void main() {
  test("fruction_and_fruction", () {
    final A = Fruction(2, 3);
    final B = Fruction(4, 3);
    final result = A / B;
    final anser = Fruction(1, 2);
    expect(result, anser);
  });

  test("fructionfruction_and_int", () {
    final A = Fruction(2, 3);
    final B = 3;
    final result = A / B;
    Fruction anser = Fruction(2, 9);
    expect(result, anser);
  });
}
