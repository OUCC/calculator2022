import 'package:flutter_test/flutter_test.dart';
import 'package:calculator2022/model/timeSpan.dart';

void main() {
  test("sample-test", () {
    final String a = getStrFromTime(3723.4);
    expect(a, "1:2:3.4");
  });
  test("StringToDouble1", () {
    final double b = getTimeFromStr("1:2:3.4");
    expect(b, 3723.4);
  });
  test("StringToDouble2", () {
    final double b = getTimeFromStr("1.0002:::");
    expect(b, 216043.2);
  });
}
