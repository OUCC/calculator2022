import 'package:shared_preferences/shared_preferences.dart';
import 'package:calculator2022/model/result_data.dart';
import "dart:async";
/*
キー用の列挙型とそれの値をとる拡張関数の追加
拡張する関数は以下の通り


shared preference のキー用
ストリングスしかない
だからえなむからストリングスにして、
拡張関数？



String get name => this.toString().split(".").last;

下のものを参考にJSONリストの入出力を追加する。
https://qiita.com/mamoru_takami/items/2d930ee927c048060741
*/

void save(Map<String, dynamic> json) async {
  // Obtain shared preferences.
  final prefs = await SharedPreferences.getInstance();
  await prefs.setStringList("saveData", jsonToList(json));
}

List<String> jsonToList(Map<String, dynamic> json) {
  List<String> listedData = [
    json["id"],
    json["formula"],
    json["result"],
    json["created_date"]
  ];
  return listedData;
}

enum key { id, formula, result, created_date }
