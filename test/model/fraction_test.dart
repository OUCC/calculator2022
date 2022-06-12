import 'package:flutter_test/flutter_test.dart';
import 'package:calculator2022/model/fruction.dart';

void main() {
  test("fruction_test", () {
    final A = Fruction(2, 3);
    final B = Fruction(4, 3);
    final result = A / B;
    //result.Reduce();
    print(result);
  });
}
