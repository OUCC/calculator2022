import 'package:flutter_test/flutter_test.dart';
import 'package:calculator2022/model/result_data.dart';

void main() {
  test("fromJson_test", () {
    final json = <String, dynamic>{
      "id": 0,
      "formula": "fo-myura",
      "result": 0.3232,
      "created_date": DateTime(2001, 05, 24, 12, 34)
    };
    var jsd = ResultData.fromJson(json);

    expect(jsd.formula, "fo-myura");
  });

  test("toJson_test", () {
    final jsd = ResultData(1, "fo-myura", 3, DateTime(2001, 05, 24, 12, 34));
    final json = <String, dynamic>{
      "id": 1,
      "formula": "fo-myura",
      "result": 3,
      "created_date": DateTime(2001, 05, 24, 12, 34)
    };
    final jsdJson = jsd.toJson();

    expect(jsdJson, json);
  });

  test("toJsonList_test", () {
    final formulaList = ["1", "2", "+"];
    final jsd =
        ResultData.fromList(1, formulaList, 3, DateTime(2001, 05, 24, 12, 34));
    final json = <String, dynamic>{
      "id": 1,
      "formula": "1 2 +",
      "result": 3,
      "created_date": DateTime(2001, 05, 24, 12, 34)
    };
    var jsdJson = jsd.toJson();

    expect(jsdJson, json);
  });
}
