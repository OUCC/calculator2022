import 'package:flutter_test/flutter_test.dart';
import 'package:calculator2022/model/timeSpan.dart';

void main() {
  test("sample-test", () {
    final timeSpan = TimeSpan(hour: 3, minute: 3, second: 3.3);
    final day = timeSpan.day;
    final hour = timeSpan.hour;
    expect(hour, 3);
  });
  test("methodTest", () {
    var TS2 = TimeSpan();
    TS2.fromMilliSec(86400077);
    final day2 = TS2.day;
    final milliSec = TS2.milliSec;
    expect(day2, 1);
  });
}
