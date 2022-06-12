/*
id: int
formula: string 何らかの区切り文字で区切られた式
result: double 結果
createdDate: DateTime 計算した日
toList(): formulaを区切り文字に従って分離する関数
Map<String,dynamic> toJson(): JSON用のMapに変換
fromJson(Map<String,dynamic>)コンストラクタ: JSON用のMapから変換する。
全てのフィールドにfinalをつけてイミュータブルにする
*/

import 'package:shared_preferences/shared_preferences.dart';

class JsonData {
  final int id;
  final String formula;
  final double result;
  final DateTime createdDate;

  JsonData(this.id, this.formula, this.result, this.createdDate);

//jsonはマップ型で、{id:int,formula:String,みたいな}
//そのマップのjsonを受け取って、何するんだこれは？
//下の変数に代入してくれるってことかな
  JsonData.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        formula = json["formula"],
        result = json["result"],
        createdDate = json["createdDate"];

//JsonData型の何かをJsonのmapにするってことか？
  Map<String, dynamic> toJson() => {
        "id": id,
        "formula": formula,
        "result": result,
        "createdDate": createdDate,
      };
}
