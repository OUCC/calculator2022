import 'package:flutter_test/flutter_test.dart';
//import 'package:calculator2022/model/calculator.dart';
import 'package:calculator2022/model/fanction.dart';

void main() {
  test("fanction_sin", () {
    final String result = Fanction("sin|90");
    print(result);
    expect(result, "1.00");
  });
  test("fanction_e", () {
    final String result = Fanction("e|0");
    print(result);
    expect(result, "1.00");
  });
  test("fanction_log", () {
    final String result = Fanction("log|2|4");
    print(result);
    expect(result, "2.00");
  });
}
