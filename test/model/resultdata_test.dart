import 'package:flutter_test/flutter_test.dart';
import 'package:calculator2022/model/result_data.dart';
import "dart:convert";

void main() {
  test("fromJson_test", () {
    Map<String, dynamic> json = {
      "id": 0,
      "formula": "fo-myura",
      "result": 0.3232,
      "createdDate": DateTime(2001, 05, 24, 12, 34)
    };
    var jsd = new ResultData.fromJson(json);

    print(jsd.formula);
    expect(jsd.formula, "fo-myura");
  });

  test("toJson_test", () {
    ResultData jsd =
        new ResultData(1, "fo-myura", 0.3, DateTime(2001, 05, 24, 12, 34));
    Map<String, dynamic> json = {
      "id": 1,
      "formula": "fo-myura",
      "result": 0.3,
      "createdDate": DateTime(2001, 05, 24, 12, 34)
    };
    var jsdJson = jsd.toJson();

    print(jsdJson);
    expect(jsdJson, json);
  });

  test("toJsonList_test", () {
    List<String> formulaList = ["1", "2", "+"];
    ResultData jsd = new ResultData.listFormula(
        1, formulaList, 0.3, DateTime(2001, 05, 24, 12, 34));
    Map<String, dynamic> json = {
      "id": 1,
      "formula": "1 2 +",
      "result": 0.3,
      "createdDate": DateTime(2001, 05, 24, 12, 34)
    };
    var jsdJson = jsd.toJson();

    print(jsdJson);
    expect(jsdJson, json);
  });
}
