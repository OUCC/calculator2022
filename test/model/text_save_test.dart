import 'package:flutter_test/flutter_test.dart';
import 'package:calculator2022/model/text_save.dart';
import 'dart:io'; //File classを使うのに必要(mainにも必要)
import 'dart:async'; //非同期処理用(mainにも必要)

void main() async {
  test("textSave", () async {
    final json = <String, dynamic>{
      "id": 1,
      "formula": "1 + 2 + 3",
      "result": "6",
      "created_date": DateTime(2001, 05, 24, 12, 34)
    };
    String fileName = "text_save_text.txt";
    String filePath;
    filePath = await saveText(json, fileName);
    print(filePath);
  });

  test("textSaveClass", () async {
    final json = <String, dynamic>{
      "id": 1,
      "formula": "1 + 2 + 3",
      "result": "6",
      "created_date": DateTime(2001, 05, 24, 12, 34)
    };
    String fileName = "text_save_class_test.txt";

    TextSave textSave = TextSave(fileName);
    textSave.textAdd(json);
    textSave.save();
  });

  test("textSaveAppendClass", () async {
    final json = <String, dynamic>{
      "id": 1,
      "formula": "1 + 2 + 3",
      "result": "6",
      "created_date": DateTime(2001, 05, 24, 12, 34)
    };
    String fileName = "text_save_class_append_test.txt";

    TextSave textSave = TextSave(fileName);
    textSave.textAdd(json);
    textSave.saveApend();
  });
}
