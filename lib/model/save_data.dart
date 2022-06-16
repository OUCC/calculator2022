import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'result_data.dart';

/// [ResultData]をSharedPreferencesに保存します。
Future<void> saveResultDataList(List<ResultData> datas) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setStringList(SaveKeys.calc_result_data.name,
      datas.map((r) => json.encode(r.toString())).toList());
}

/// SharedPreferencesから結果を取得
/// 初めてのアクセスの場合は空の配列を返します。
Future<List<ResultData>> loadResultDataList() async {
  final prefs = await SharedPreferences.getInstance();

  final jsonData = prefs.getStringList(SaveKeys.calc_result_data.name);

  if (jsonData == null) {
    return <ResultData>[];
  }

  return jsonData.map((s) => ResultData.fromJson(json.decode(s))).toList();
}

enum SaveKeys {
  /// 計算結果を保存するキー
  // ignore: constant_identifier_names
  calc_result_data,
}

extension SaveKeysEx on SaveKeys {
  /// キーをStringにします
  String get name => toString().split(".").last;
}
