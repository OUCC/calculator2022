import 'package:calculator2022/model/fraction.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calculator2022/model/calculator.dart';
import 'package:calculator2022/model/operators.dart';

void main() {
  test("fraction_test",(){
    final f_Terms = <Term>[
      Term.fromNum(1),
      Term.fromNum(2),
      Term.fromNum(3),
      Term.fromOpr(Operators.div),
      Term.fromOpr(Operators.add)
    ];

    const formula = "1 + 2 + 3 * ( 4 + 5 ) / 20 - -10";
      final result=Fraction(parseStr2Polish(formula));
      expect(result, [287,20]);
      
 });


}