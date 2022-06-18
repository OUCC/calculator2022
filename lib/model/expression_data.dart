import 'package:calculator2022/model/operators.dart';

class ExpressionData {
  /// id
  final int id;

  /// 式の名前
  final String name;

  /// 文字列の形の式
  final String expressionString;

  final Operator operator;

  /// 作成された日時
  final DateTime createdDate;

  ExpressionData(this.id, this.name, this.operator, this.expressionString,
      this.createdDate);

  ExpressionData.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        expressionString = json["expression_string"],
        operator = json["operator"],
        createdDate = DateTime.parse(json["created_date"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "expression_string": expressionString,
        "operator": operator,
        "created_date": createdDate.toIso8601String(),
      };
}
