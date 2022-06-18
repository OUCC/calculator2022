import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:calculator2022/model/calculator.dart';
import 'package:calculator2022/model/operators.dart';

void main() {
  test("parseStrToPolish", () {
    const str = "1 + 2 ^ 3 + 3 * ( 4 + 5 ) / 20 - -10";
    final expectedTerms = <Term>[
      Term.fromNum(1),
      Term.fromNum(2),
      Term.fromNum(3),
      Term.fromOpr(Operators.pow),
      Term.fromNum(3),
      Term.fromNum(4),
      Term.fromNum(5),
      Term.fromOpr(Operators.add),
      Term.fromNum(20),
      Term.fromOpr(Operators.div),
      Term.fromOpr(Operators.multi),
      Term.fromNum(-10),
      Term.fromOpr(Operators.sub),
      Term.fromOpr(Operators.add),
      Term.fromOpr(Operators.add)
    ];

    final result = parseStr2Polish(str);

    expect(result, expectedTerms);
  });

  test("calculate", () {
    final argTerms = <Term>[
      Term.fromNum(1),
      Term.fromNum(2),
      Term.fromNum(3),
      Term.fromOpr(Operators.pow),
      Term.fromNum(3),
      Term.fromNum(4),
      Term.fromNum(5),
      Term.fromOpr(Operators.add),
      Term.fromNum(20),
      Term.fromOpr(Operators.div),
      Term.fromOpr(Operators.multi),
      Term.fromNum(-10),
      Term.fromOpr(Operators.sub),
      Term.fromOpr(Operators.add),
      Term.fromOpr(Operators.add)
    ];

    final result = calculate(argTerms);

    expect(result, 20.35);
  });

  test("calculate-unaryoperator", () {
    const formula = "1 + 2 + 3 * sin ( ( 0.25 + 0.25 ) * pi ) + ln ( e ^ 2 )";

    var result = calculate(parseStr2Polish(formula));

    expect(result, 8);
  });

  test("calculate-0.2+0.1", () {
    final result = calculate(parseStr2Polish("0.2 + 0.1"));

    expect(result, 0.3);
  });
}
