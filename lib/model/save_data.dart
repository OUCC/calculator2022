import 'dart:convert';
import 'dart:math';
import 'package:calculator2022/model/expression_data.dart';
import 'package:calculator2022/model/operator_generator.dart';
import 'package:calculator2022/model/operators.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'result_data.dart';

/// [ResultData]をSharedPreferencesに保存します。
Future<void> saveResultDataList(List<ResultData> datas) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setStringList(SaveKeys.calc_result_data.name,
      datas.map((r) => json.encode(r.toJson())).toList());
}

/// SharedPreferencesから結果を取得
/// 初めてのアクセスの場合は空の配列を返します。
Future<List<ResultData>> loadResultDataList() async {
  final prefs = await SharedPreferences.getInstance();

  final jsonData = prefs.getStringList(SaveKeys.calc_result_data.name);

  return jsonData
          ?.map((resultJson) => ResultData.fromJson(
              json.decode(resultJson) as Map<String, dynamic>))
          .toList() ??
      <ResultData>[];
}

Future<List<ResultData>> addResultData(String formula, double result) async {
  final currentHistory = await loadResultDataList();
  final nextId = currentHistory.isNotEmpty
      ? currentHistory.map((r) => r.id).reduce(max) + 1
      : 1;
  final curResult = ResultData(nextId, formula, result, DateTime.now());

  currentHistory.add(curResult);

  await saveResultDataList(currentHistory);

  return currentHistory;
}

Future<void> saveExpressionDataList(List<ExpressionData> datas) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setStringList(SaveKeys.calc_result_data.name,
      datas.map((r) => json.encode(r.toJson())).toList());
}

Future<List<ExpressionData>> loadExpressionDataList() async {
  final prefs = await SharedPreferences.getInstance();

  final jsonData = prefs.getStringList(SaveKeys.expression_data.name);

  final exprData = jsonData
          ?.map((exrJson) => ExpressionData.fromJson(
              json.decode(exrJson) as Map<String, dynamic>))
          .toList() ??
      <ExpressionData>[];

  for (var expr in exprData) {
    registerUnaryOperator(
        expr.name, parseStr2Func(expr.expressionString), expr.operator);
  }

  return exprData;
}

Future<List<ExpressionData>> addExpressionData(
    String name, String expression) async {
  final currentExpressions = await loadExpressionDataList();
  final nextId = currentExpressions.isNotEmpty
      ? currentExpressions.map((e) => e.id).reduce(max) + 1
      : 1;

  final func = parseStr2Func(expression);

  final operator = registerUnaryOperator(name, func);
  final expressionData =
      ExpressionData(nextId, name, operator, expression, DateTime.now());

  currentExpressions.add(expressionData);
  await saveExpressionDataList(currentExpressions);

  return currentExpressions;
}

enum SaveKeys {
  /// 計算結果を保存するキー
  // ignore: constant_identifier_names
  calc_result_data,

  /// 式を保存するキー
  // ignore: constant_identifier_names
  expression_data,
}

extension SaveKeysEx on SaveKeys {
  /// キーをStringにします
  String get name => toString().split(".").last;
}
