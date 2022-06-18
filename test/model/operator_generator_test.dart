import 'dart:math';

import 'package:calculator2022/model/operator_generator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const signs = [
    "+",
    "-",
    "*",
    "/",
    "^",
    "+ sin",
    "+ cos",
    "+ tan",
    "+ ln",
    "+ log",
    "+ sqrt"
  ];
  const args = <double>[
    3,
    3,
    3,
    2,
    3,
    pi,
    pi,
    0.25 * pi,
    e,
    10,
    4,
  ];
  const expeted = <double>[7, 1, 12, 2, 64, 4, 3, 5, 5, 5, 6];
  test("parseStrArr2Func", () {
    for (var i = 0; i < signs.length; i++) {
      final f = parseStrArr2Func("4 ${signs[i]} x".split(" "));
      expect(f(args[i]), expeted[i]);
    }
  });
}
