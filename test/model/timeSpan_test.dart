import 'package:flutter_test/flutter_test.dart';
import 'package:calculator2022/model/timeSpan.dart';

void main() {
  test("int-tests", () {
    final int d = getSecFromTime(3723.4);
    expect(d, 3);
    final int e = getMinFromTime(3723.4);
    expect(e, 2);
    final int f = getHourFromTime(3723.4);
    expect(f, 1);
  });
  test("double-tests", () {
    final double g = getLimSecFromTime(3723.4);
    expect(g, 3.4);
    final double h = getFullMinFromTime(3723.3);
    expect(h, 62.055);
    final double i = getFullHourFromTime(3723.3);
    expect(i, 1.03425);
  });
  test("doubleToString", () {
    final String a = getStrFromTime(3723.4);
    expect(a, "1:2:3.4");
  });
  test("StringToDouble1", () {
    final double? b = tryParseTimeFromStr("1:2:3.4");
    expect(b, 3723.4);
  });
  test("StringToDouble2", () {
    final double? c = tryParseTimeFromStr("1.0002:::");
    expect(c, 216043.2);
  });
}
