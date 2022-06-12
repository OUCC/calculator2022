class ResultData {
  /// id
  final int id;

  /// 半角空白を区切り文字とした式
  final String formula;

  /// 計算結果
  final double result;

  /// 作成された日時
  final DateTime createdDate;

  ResultData(this.id, this.formula, this.result, this.createdDate);

  /// 式の配列から`ResultDataを生成します。
  ResultData.fromList(
      this.id, List<String> formulaList, this.result, this.createdDate)
      : formula = formulaList.join(" ");

  /// JSONをデコードして出てきた`Map<String, dynamic>`から[ResultData]を生成します。
  ResultData.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        formula = json["formula"],
        result = json["result"],
        createdDate = json["created_date"];

  /// JSONへエンコードするためにデータを変換します。
  Map<String, dynamic> toJson() => {
        "id": id,
        "formula": formula,
        "result": result,
        "created_date": createdDate,
      };
}
