import 'package:flutter_test/flutter_test.dart';
import 'package:calculator2022/model/calculator.dart';

void main() {
  test("parseStrToPolish", () {
    const str = "1 + 2 + 3 * ( 4 + 5 ) / 20 - -10";
    expect("a", "a");
    final expectedTerms = <Term>[
      Term.fromNum(1),
      Term.fromNum(2),
      Term.fromNum(3),
      Term.fromNum(4),
      Term.fromNum(5),
      Term.fromOpr(operators.add),
      Term.fromNum(20),
      Term.fromOpr(operators.div),
      Term.fromOpr(operators.multi),
      Term.fromNum(-10),
      Term.fromOpr(operators.sub),
      Term.fromOpr(operators.add),
      Term.fromOpr(operators.add)
    ];

    final result = parseStrToPolish(str);

    expect(result, expectedTerms);
  });

  test("calculate", () {
    final argTerms = <Term>[
      Term.fromNum(1),
      Term.fromNum(2),
      Term.fromNum(3),
      Term.fromNum(4),
      Term.fromNum(5),
      Term.fromOpr(operators.add),
      Term.fromNum(20),
      Term.fromOpr(operators.div),
      Term.fromOpr(operators.multi),
      Term.fromNum(-10),
      Term.fromOpr(operators.sub),
      Term.fromOpr(operators.add),
      Term.fromOpr(operators.add)
    ];

    final result = calculate(argTerms);

    expect(result, 14.35);
  });
}
