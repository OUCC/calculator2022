import 'package:flutter_test/flutter_test.dart';
import 'package:calculator2022/model/jsonData.dart';
import "dart:convert";



void main() {

  test("fromJson_test",(){
  Map<String, dynamic> json = {
  "id":0,
  "formula":"fo-myura",
  "result":0.3232,
  "createdDate": DateTime(2001,05,24,12,34)
};
  var jsd = new JsonData.fromJson(json);

  print(jsd.formula);
  expect(jsd.formula, "fo-myura");
  });
///////////////////
  test("toJson_test",(){
    JsonData jsd = new JsonData(1,"fo-myura",0.3,DateTime(2001,05,24,12,34));
    Map<String, dynamic> json = {
  "id":1,
  "formula":"fo-myura",
  "result":0.3,
  "createdDate": DateTime(2001,05,24,12,34)
};
  var jsdJson = jsd.toJson();

  print(jsdJson); 
  expect(jsdJson, json);
  });
}
