import 'package:flutter_test/flutter_test.dart';
import 'package:calculator2022/model/timeSpan.dart';

void main() {
  final timeSpan = TimeSpan(hour: 3, minute: 3, second: 3.3);
  test("sample-test", () {
    final day = timeSpan.day;
    expect(day, 0);
  });
}
