import "package:flutter_test/flutter_test.dart";
import 'package:calculator2022/model/fileIO.dart';
import 'dart:async';
import 'dart:io';

//テストの使いかた違いますよね。
void main() async {
  String fileName = "samplefile.txt";
  print("1");
  File file = await fileOpen(fileName);
  print("2");
  String filePath = file.path;
  print(filePath);
  file.writeAsString("Kitty on lap");
  print("3");
  String readStr = await file.readAsString();
  print(readStr);
}
