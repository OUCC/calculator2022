import 'dart:convert';
import 'package:calculator2022/model/expression_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("toJson", () {
    final data = ExpressionData(
        1, "name", 0x2FF, "expressionString", DateTime.parse("2020-01-01"));
    final actualJson = json.encode(data.toJson());

    const expectedJson =
        '{"id":1,"name":"name","operator":767,"expression_string":"expressionString","created_date":"2020-01-01T00:00:00.000"}';

    expect(actualJson, expectedJson);
  });

  test("fromJson", () {
    const sendingJson =
        '{"id":1,"name":"name","operator":767,"expression_string":"expressionString","created_date":"2020-01-01T00:00:00.000"}';
    final actualData = ExpressionData.fromJson(json.decode(sendingJson));

    expect(actualData.id, 1);
    expect(actualData.name, "name");
    expect(actualData.expressionString, "expressionString");
    expect(actualData.createdDate, DateTime.parse("2020-01-01"));
  });
}
